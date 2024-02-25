#!/bin/sh

# add lines to crontab
echo "*       *       *       *       *       run-parts /etc/periodic/1min"  >> /etc/crontabs/root
echo "*/5     *       *       *       *       run-parts /etc/periodic/5min"  >> /etc/crontabs/root
echo "*/30    *       *       *       *       run-parts /etc/periodic/30min" >> /etc/crontabs/root

crontab -l

if [ -f /opt/startup/startup.sh ]; then
  /opt/startup/startup.sh
fi

if [ -n "$RUN_ON_STARTUP"  ]; then
  echo "running scripts on startup ..."
  for d in $RUN_ON_STARTUP; do
     currdir=/etc/periodic/$d
     if [ -d $currdir ]; then
        echo "executing scripts in $currdir ..."
        run-parts $currdir
     else
        echo "ERROR: $currdir does not exist, please check RUN_ON_STARTUP setting!"
     fi
  done
else
  echo "running no scripts on startup."
fi



echo "starting ..."

## start crond as daemon
crond -f
