#!/bin/bash
screen -dmS switch /dev/ttyUSB0 9600
screen -r
killall -r -I screen
