FROM alpine:latest

#RUN sed -i 's/https/http/' /etc/apk/repositories

RUN apk update && apk add gpsd --no-cache

ENV GPS_DEVICE=/dev/gps0

ENTRYPOINT ["/bin/sh", "-c", "exec /usr/sbin/gpsd -N -n -G ${*} -F /var/run/gpsd.sock $GPS_DEVICE"]
