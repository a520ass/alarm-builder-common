#!/bin/bash -e
pacman -Syu
chown -R alarm: /home/alarm
cd /home/alarm/alarm-builder
export HOME=/home/alarm # because distcc will break with env kept
sudo -E -u alarm ./build.sh