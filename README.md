# docker-periodicrunner
This is a small docker image to run scripts periodically. The image is based on the python alpine image.
After startup, the image executes scripts which are located in ```/etc/periodic``` sub folders at defined intervals.


## Directory structure of /etc/periodic
The volume mounted at ```/etc/periodic``` is structured as shown below. The image will execute all scripts located in 
the respective folders at the given intervals. For example, all scripts in ```/etc/periodic/1min``` are executed every minute.


```
/etc/periodic/1min
/etc/periodic/5min
/etc/periodic/15min
/etc/periodic/30min
/etc/periodic/hourly
/etc/periodic/weekly
/etc/periodic/monthly
```

## Defining activities after startup
If additional activities shall be performed after startup, these steps can be defined with a script ```startup.sh``` which 
resides in ```/opt/startup```.

The variable ```RUN_ON_STARTUP``` allows executing the scripts located in one of the subfolders in ```/etc/periodic``` directly
after startup.
For example, setting ```RUN_ON_STARTUP=1min``` directly executes all scripts in ```/etc/periodic/1min``` after starting up.

Please note, that all scripts must be set executable!

## Adding further assets
The directory ```/opt/additional``` allows adding further scripts or additional assets. This can be useful for helper scripts
that are called by the scripts in ```/etc/periodic```.

# Docker Compose example:

```
version: '3.9'

services:
  periodicrunner:
    image: xxx/periodicrunner:latest
    container_name: prunner
    restart: unless-stopped
    hostname: prunner-service
    environment:
      - RUN_ON_STARTUP=1min 15min 30min
    volumes:
      - /path/to/periodic:/etc/periodic
      - /path/to/additional:/opt/additional
      - /path/to/startup:/opt/startup
```
