#!/bin/csh -f
if("$REMOTE_ADDR" != "2001:8b0:0:30::51bb:1e15") then
	echo "Status: 403"
	echo ""
	exit 1
endif
echo "Status: 204"
echo ""
../message --stdin --print --silent
