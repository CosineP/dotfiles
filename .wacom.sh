#!/bin/bash 
#
# the darn thing change names if is on wireless or not...
#
pad_name=$(xsetwacom --list | grep -i "pad" |  awk '{print $(NF-2)}')
stylus_name=$(xsetwacom --list | grep -i "stylus" |  awk '{print $(NF-2)}')
#device="Wacom Intuos Pro S Pen stylus"

# Input 16:9 (no stretch)
xsetwacom set "$stylus_name" Area 0 0 31496 17717
# Unlike desktop no offset or fractions needed
# .... unless i were to add another monitor would fuck everything up
# which i Don't Like

# Laid out the way they are on the thing
xsetwacom set "$pad_name" Button 2 "key +ctrl"
xsetwacom set "$pad_name" Button 3 "key ctrl +space" # Krita zoom
xsetwacom set "$pad_name" button 8 "key shift +space" # Krita rotate
# TODO: Do the scrolly here!
xsetwacom set "$pad_name" Button 9 "key ctrl z"
xsetwacom set "$pad_name" Button 10 "key ctrl shift z"
xsetwacom set "$pad_name" button 11 "key b" # eh, idk

exit 0
