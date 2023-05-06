#!/bin/bash -e
pacman -Syu
chown -R alarm: /home/alarm
cd /home/alarm/alarm-builder
sudo -E -u alarm ./build.sh