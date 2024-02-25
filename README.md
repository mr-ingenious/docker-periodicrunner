# docker-periodicrunner
small docker image to run scripts periodically.


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
      - RUN_ON_STARTUP=1min 15min 30min none
    volumes:
      - /path/to/periodic:/etc/periodic
      - /path/to/additional:/opt/additional
      - /path/to/startup:/opt/startup
```


