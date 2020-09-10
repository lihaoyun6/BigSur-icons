#!/bin/bash

rm -rf thumbs
mkdir thumbs
cd icons
for i in `ls *.icns`
do
	sips -Z 64 -s format jpeg $i --out ../thumbs/${i%.*}.jpg
	echo '[!['${i%.*}.jpg'](./'${i%.*}.jpg' "'${i%.*}'")](../icons/'${i%.*}.icns')' >> ../thumbs/thumbs.md
done
cd ..
echo "Done!"
