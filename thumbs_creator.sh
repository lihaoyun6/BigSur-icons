#!/bin/bash

rm -rf thumbs
mkdir thumbs
cd icons
for i in `ls *.icns`
do
	sips -s format png $i --out ../thumbs/${i%.*}.png >/dev/null
done
cd ../thumbs
for i in `ls *.png`
do
	convert $i -resize 64x64 $i
	echo "!["$i"](./"$i" \""${i%.*}"\")" >> thumbs.md
done
cd ..
echo "Done!"
