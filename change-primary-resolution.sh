#!/bin/bash

# change-primary-resolution.sh
# Changes the resolution of the primary display using xrandr
# Usage: ./change-primary-resolution.sh X Y
#  X: Desired horizontal resolution (multiple of 8)
#  Y: Desired vertial resolution

# extract primary screen name from xrandr
PRIMARY_SCREEN=`xrandr | sed -n -e 's/^\(.*\) connected primary.*/\1/p'`

# get mode line from cvt
MODELINE=`cvt $1 $2 60 | sed -n -e 's/^.*Modeline //p'`
if [[ $MODELINE == *usage:* ]] # invalid input to cvt
then
  echo "invalid resolution"
  exit 1
fi

# mode name is in quotes
MODE_NAME=`echo $MODELINE | sed -n -e 's/^"\(.*\)".*/\1/p'`
MODELINE_TAIL=`echo $MODELINE | sed -n -e 's/^".*"\(.*\)/\1/p'`

# silence stderr if mode already exists
xrandr --newmode $MODE_NAME $MODELINE_TAIL 2> /dev/null
xrandr --addmode $PRIMARY_SCREEN $MODE_NAME
xrandr --output $PRIMARY_SCREEN --mode $MODE_NAME
