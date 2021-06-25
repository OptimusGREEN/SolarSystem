// Security check

#define _GNU_SOURCE             /* See feature_test_macros(7) */
#include "config.h"
#include <stdio.h>
#include <string.h>
#include <popt.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>
#include <ctype.h>
#include <err.h>
#include "AJL/ajl.h"
#include "SQLlib/sqllib.h"
#include "login/redirect.h"

int can(SQL_RES * res, const char *test)
{
   if (!strcasecmp(test, "admin"))
      return 0;                 // Already tested
   char *s;
   if (asprintf(&s, "can%s", test) < 0)
      errx(1, "malloc");
   char *v = sql_colz(res, s);
   free(s);
   if (!v || *v != 't')
      return 0;
   return 1;
}

int main(int argc, const char *argv[])
{
   int us = 0,
       user = 0,
       organisation = 0,
       site = 0,
       aid = 0,
       class = 0;
   int redirect = 0;
   int reason = 0;
   const char *configfile = "../solarsystem.conf";
   poptContext optCon;          // context for parsing command-line options
   const struct poptOption optionsTable[] = {
      { "as", 0, POPT_ARG_INT, &us, 0, "Check as user", "N" },
      { "user", 'u', POPT_ARG_INT, &user, 0, "Check access to user", "N" },
      { "organisation", 'o', POPT_ARG_INT, &organisation, 0, "Check access to organisation", "N" },
      { "site", 's', POPT_ARG_INT, &site, 0, "Check access to site", "N" },
      { "aid", 'a', POPT_ARG_INT, &aid, 0, "Check access to aid", "N" },
      { "class", 'c', POPT_ARG_INT, &class, 0, "Check access to class", "N" },
      { "config-file", 0, POPT_ARG_STRING | POPT_ARGFLAG_SHOW_DEFAULT, &configfile, 0, "Config file", "filename" },
      { "redirect", 'r', POPT_ARG_NONE, &redirect, 0, "Redirect", NULL },
      { "reason", 0, POPT_ARG_NONE, &reason, 0, "Output reason allowed", NULL },
      { "debug", 'v', POPT_ARG_NONE, &sqldebug, 0, "Debug", NULL },
      POPT_AUTOHELP { }
   };

   optCon = poptGetContext(NULL, argc, argv, optionsTable, 0);
   poptSetOtherOptionHelp(optCon, "{permissions}");

   int c;
   if ((c = poptGetNextOpt(optCon)) < -1)
      errx(1, "%s: %s\n", poptBadOption(optCon, POPT_BADOPTION_NOALIAS), poptStrerror(c));

   SQL sql;
   sql_cnf_connect(&sql, CONFIG_SQL_CONFIG_FILE);
   if (*CONFIG_SQL_DATABASE)
      sql_safe_select_db(&sql, CONFIG_SQL_DATABASE);
   SQL_RES *resus = NULL;
   const char *check(void) {
      if (!us)
         us = atoi(getenv("USER_ID") ? : "");
      if (!us)
      {
         warnx("No --as/$USER_ID provided for can");
         return NULL;
      }
      resus = sql_safe_query_store_free(&sql, sql_printf("SELECT * FROM `user` WHERE `user`=%d", us));
      if (!sql_fetch_row(resus))
      {
         warnx("User does not exist %d", us);
         return NULL;
      }
      if (*sql_colz(resus, "admin") == 't')
         return "User is top level admin.";
      if (user)
      {                         // User editing self
         const char *a;
         while ((a = poptPeekArg(optCon)))
            if (!can(resus, a))
               return NULL;
         if (us == user)
            return "Editing self";
         return NULL;           // Only admin can edit users directly
      }
      const char *getorg(char *query) {
         SQL_RES *res = sql_safe_query_store_free(&sql, query);
         if (!sql_fetch_row(res))
         {
            sql_free_result(res);
            return "Did not find security match";
         }
         int o = atoi(sql_colz(res, "organisation"));
         sql_free_result(res);
         if (o && organisation && o != organisation)
            return "Organisation mismatch";
         organisation = o;
         return NULL;
      }
      const char *e = NULL;
      if (!e && class)
         e = getorg(sql_printf("SELECT * FROM `class` WHERE `class`=%d", class));
      if (!e && site)
         e = getorg(sql_printf("SELECT * FROM `site` WHERE `site`=%d", site));
      if (!e && aid)
         e = getorg(sql_printf("SELECT * FROM `aid` LEFT JOIN `site` USING (`site`) WHERE `aid`=%d", aid));
      if (e)
      {
         if (sqldebug)
            warnx("Fail: %s", e);
         return NULL;
      }
      if (organisation)
      {
         SQL_RES *res = sql_safe_query_store_free(&sql, sql_printf("SELECT * FROM `userorganisation` LEFT JOIN `class` USING (`class`,`organisation`) WHERE `user`=%d AND `organisation`=%d", us, organisation));
         if (!sql_fetch_row(res))
         {
            sql_free_result(res);
            return NULL;
         }
         // Now check permissions
         if (*sql_colz(resus, "admin") == 't')
            return "User is top level admin.";
         if (!poptPeekArg(optCon))
            return NULL;        // No args is checking admin
         const char *a;
         while ((a = poptGetArg(optCon)))
            if (!can(resus, a))
               return NULL;
         sql_free_result(res);
      }
      return NULL;              // Fail
   }
   const char *why = check();
   if (resus)
      sql_free_result(resus);
   if (!why)
   {                            // not allowed
      if (redirect)
         sendredirect(NULL, "Sorry, access not allowed to this page");
   } else
   {
      if (reason)
         printf("%s", why);
      if (sqldebug)
         warnx("%s", why);
   }
   sql_close(&sql);
   poptFreeContext(optCon);
   return why ? 0 : 1;
}
