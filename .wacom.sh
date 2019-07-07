#!/bin/bash 
#
# the darn thing change names if is on wireless or not...
#
pad_name=$(xsetwacom --list | grep -i "pad" |  awk '{print $(NF-2)}')
stylus_name=$(xsetwacom --list | grep -i "stylus" |  awk '{print $(NF-2)}')
#device="Wacom Intuos Pro S Pen stylus"

# Input 16:9 (no stretch)
xsetwacom set "$stylus_name" Area 0 0 31496 17717
# 0.54545 is ratio of big monitor to total, used to be 0.5 (1/2 the screen)
# but now I have a big and a small
# Height ratio comes from offset I've put on smallmon:
# total height is 1100, desired is 1080
xinput set-prop "$stylus_name" --type=float "Coordinate Transformation Matrix" 0.54545 0 0 0 0.9818 0 0 0 1

# Laid out the way they are on the thing
xsetwacom set "$pad_name" Button 2 "key ctrl z"
xsetwacom set "$pad_name" Button 3 "key ctrl shift z"
xsetwacom set "$pad_name" Button 8 "key ctrl +space"
# TODO: Do the scrolly here!
xsetwacom --set "$pad_name" button 9 "key shift +space"
xsetwacom --set "$pad_name" button 10 "key e"
# Two more to set!

exit 0
