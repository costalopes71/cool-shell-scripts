#!/bin/sh

current_date=$(date +\%Y\%m\%d\%H\%M\%s)

fswebcam -d /dev/video0 --jpeg 85 -F 1 /tmp/spypic-${current_date}.jpeg &> /dev/null

echo "/tmp/spypic-${current_date}.jpeg" > /tmp/lastspypic.txt

