#!../login/loggedin /bin/csh -f
can --redirect --site='$SESSION_SITE' candisarm
if($status) exit 0

if($?DISARM) then
	if($?disarm) then
		setenv MSG `message --site="$SESSION_SITE" --disarm="$disarm"`
		if($status) goto done
	endif
	redirect /
	exit 0
endif

done:
source ../types
xmlsql -C -d "$DB" head.html - foot.html << END
<h1>Arming</h1>
<sql table=site where='site=$SESSION_SITE'>
<form method=post>
<table border=1>
<tr>
<th></th><th>Disarm</th>
<th>Areas</th>
</tr>
<sql table=area where="site=$SESSION_SITE">
<set s='background:green;'><if armed=*\$tag><set s='background:yellow;'></if><if alarm=*\$tag><set s='background:red;'></if>
<tr style="\$s">
<th><label for=\$tag><output name=tag></label></th>
<td><input type=checkbox value=\$tag name=disarm id=\$tag></td>
<td><label for=\$tag><output name=areaname></label></td>
</tr>
</sql>
</table>
<input type=submit value="Disarm" name=DISARM>
</form>
</sql>
END
