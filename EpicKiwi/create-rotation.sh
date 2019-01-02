#!/bin/bash

FRAMES=180
STEP=$(expr 360 / $FRAMES)

echo Creation of $FRAMES images

mkdir .tmp -p
touch .tmp/images.txt

for frame in $(seq $FRAMES)
    do
    ROTATE=$(expr $STEP "*" "(" $frame - 1 ")")
    convert "Renders/logo.png" -distort SRT -$ROTATE ".tmp/logo-$frame.png"
    echo .tmp/logo-${frame}.png >> .tmp/images.txt
done

echo Compilation into GIF

ffmpeg -y -i ".tmp/logo-1.png" -vf "palettegen" ".tmp/palette.png"
ffmpeg -y -i ".tmp/logo-%d.png" -i ".tmp/palette.png" -lavfi "paletteuse" "Renders/logo-rotation.gif"

rm -r .tmp

echo "Final gif created in Renders/logo-rotation.gif"
