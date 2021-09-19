#!/bin/bash

yum -q list installed jq &>/dev/null && echo "JQ Installed" || echo "JQ Not installed"

DATA=`aws secretsmanager get-secret-value --secret-id $1 --version-stage AWSCURRENT | jq -r '.SecretString'`

USER_DATA=`echo $DATA | jq -r '.username'` 
PASS_DATA=`echo $DATA | jq -r '.password'` 
HOST_DATA=`echo $DATA | jq -r '.host'` 
PORT_DATA=`echo $DATA | jq -r '.port'` 

echo "Retrieving secretsmanager data ..."

[  -z "$USER_DATA" ] && echo "USER_DATA Empty: Yes"
[  -z "$PASS_DATA" ] && echo "PASS_DATA Empty: Yes"
[  -z "$HOST_DATA" ] && echo "HOST_DATA Empty: Yes"
[  -z "$PORT_DATA" ] && echo "PORT_DATA Empty: Yes"

echo "trying to Connect to $HOST_DATA with user $USER_DATA"

TMPFILE=$(mktemp)

echo -e "[client]\nuser=$USER_DATA\npassword=$PASS_DATA" > $TMPFILE
trap '{ rm -f -- "$TMPFILE"; }' EXIT

mysql --defaults-file=$TMPFILE -h $HOST_DATA --port=$PORT_DATA