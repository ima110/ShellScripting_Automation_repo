#!/bin/bash

services=(helloservice hiservice nameservice managerservice teamservice)
MAX=2

for service in "${services[@]}"; do
  COUNT=$(ps -ef | grep -w "$service" | grep -v grep | wc -l)

  echo "Service: $service"
  echo "Running count: $COUNT"

  if [ "$COUNT" -gt "$MAX" ]; then
    PROCS=$(ps -ef | grep -w "$service" | grep -v grep | awk '{print $2, $11, $12, $13}')
    JAR=$(echo "$PROCS" | awk -F"-Djar_name=| " '{print $5}')
    JAR_RUN=$(echo "$JAR" | tr ' ' ',')

    cd /apps/nnos/test/scripts || exit 1

    echo -e "The following JAR(s) have exceeded the process threshold.\n\nService: $service\nRunning Count: $COUNT\nJARs: $JAR_RUN\n\nPlease take necessary action." \
    | mailx -s "Process threshold exceeded for $service" your_email@example.com
  fi
done
