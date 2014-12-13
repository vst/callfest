#!/bin/bash

########################################################################
# Description:
#     Produces custom ChangeLog file contents out of the "git log"
#
# Usage:
#     sh changelog.sh
#
# Usage (Save output):
#     sh changelog.sh > ChangeLog
########################################################################

branch_name=$(git symbolic-ref -q HEAD)
branch_name=${branch_name##refs/heads/}
branch_name=${branch_name:-HEAD}
today=$(date +"%Y-%m-%d")

echo VERSION: $today ------- $branch_name
echo

git log --date=short --pretty="    * %ad %h %s (%ae)" | sed "s/^    \* \(.*\) \(.......\) Merge branch '\([^f].*\)' into develop \(.*\)$/\\`echo -e '\n\r'`VERSION: \1 \2 \3 \4\\`echo -e '\n\r'`/g" | tr -d "\r" | while read line; do
    echo "$line"
done
