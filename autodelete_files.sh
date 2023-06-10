#!/bin/bash

# Remove files 4 days old
# change the number of days if necessary

XDAILYDIR=/path/to/file

xremove()
{
pushd $XDAILYDIR > /dev/null 2>&1;rc=$?
if test $rc -eq 0; then
      echo "Deleting files +4 days old package.."
      find . -mtime +4 -type f -delete
      popd > /dev/null 2>&1
fi
}

xremove
exit 0