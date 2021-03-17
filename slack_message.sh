#!/bin/bash
# parse arguments
while getopts "h:c:u:m:" option; do
  case $option in
    "h")
      HOOK=${OPTARG}
      ;;
    "c")
      CHANNEL=${OPTARG}
      ;;
    "u")
      USERNAME=${OPTARG}
      ;;
    "m")
      MESSAGE=${OPTARG}
      ;;
    \?|:)
      echo "Options -u -c -m -h"
      exit
      ;;
    esac
done

# prepare message
MESSAGE_TO_SEND=$(echo -e "${MESSAGE}" | sed 's/\"/\\"/g' | sed "s/'/\'/g" | sed 's/`/\`/g')
TEXT="\"text\": \"${MESSAGE_TO_SEND}\""
PAYLOAD="{\"channel\": \"${CHANNEL}\", \"username\":\"${USERNAME}\", ${TEXT}}"
echo $PAYLOAD
# send message
curl -s -d "payload=$PAYLOAD" $HOOK
