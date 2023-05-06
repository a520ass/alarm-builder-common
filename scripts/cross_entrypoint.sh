#!/bin/bash -e
pacman -Syu
chown -R alarm: /home/alarm
su --preserve-environment - alarm -c 'cd alarm-builder; ./build.sh'