#!/bin/bash

while read -r issue; do
  curl -s -X PUT \
    -u "$JIRA_USER:$JIRA_TOKEN" \
    -H "Content-Type: application/json" \
    --data '{"update":{"labels":[{"add":"DEMO_NEW"}]}}' \
    "https://atlassian_id.atlassian.net/rest/api/3/issue/$issue"
done < jiraid.txt
