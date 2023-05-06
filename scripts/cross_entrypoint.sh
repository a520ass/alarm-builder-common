#!/bin/bash -e
pacman -Syu
chown -R alarm: /home/alarm
su - alarm -c 'cd alarm-builder; ./build.sh'