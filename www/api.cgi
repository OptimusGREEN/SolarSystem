#!../login/loggedin --http-auth /bin/csh -f
echo "Content-Type: text/plain"
echo ""
printenv

can --organisation='$SESSION_ORGANISATION' api
if($status) then
	echo "Status: 403"
	echo ""
	exit 1
endif

setenv MSG `../message --api="$USER_ID" --stdin`
if(! $status) then
	echo "Status: 204"
	echo ""
	exit 0
endif
echo "Status: 500"
echo "Content-Type: text/plain"
echo ""
echo "$MSG"
