#!/bin/bash

#set -x
set -f # disable file name expansion, especially in for loops

LIMIT="300"

echo "Renaming and closing PRs to get them recreated by renovate"
echo "learn more at https://github.com/renovatebot/renovate/discussions/13975#discussioncomment-2104370"
# Learn about github NOT keyword syntax at https://stackoverflow.com/a/73795581/1484823 "
ISSUES=$(gh issue list \
  --search "is:issue is:open -author:app/renovate  in:title NOT helm  " \
  --limit ${LIMIT} \
  --repo orange-cloudfoundry/k3s-boshrelease \
  --json number \
  | jq -r '.[].number' )
echo "first Issues (maxed at ${LIMIT}} to rename are: ${ISSUES}"
for i in $ISSUES; do
  echo "renaming to: "
  gh issue transfer --repo orange-cloudfoundry/k3s-boshrelease ${i} orange-cloudfoundry/k3s-wrapper-boshrelease
  echo ".. done"
done;

echo "please rerun this command to check not more PR beyond $LIMIT is left to process"