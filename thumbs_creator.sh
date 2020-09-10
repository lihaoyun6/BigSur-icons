#!/bin/bash

old_IFS=$IFS
IFS=$'\n'
rm -rf thumbs
mkdir thumbs
printf "### 点击小图标可跳转至ICNS原图  /  Click on the thumbnail to access the ICNS file  \n****  \n\n" >> thumbs/thumbs.md
cd icons
for i in `ls *.icns`
do
	sips -Z 64 -s format jpeg $i --out ../thumbs/${i%.*}.jpg
	echo '[!['${i%.*}.jpg'](./'${i%.*}.jpg' "'${i%.*}'")](../icons/'${i%.*}.icns')' >> ../thumbs/thumbs.md
	echo '['${i%.*}'](../icons/'${i%.*}.icns')  ' >> ../thumbs/textlist.md
done
cd ..
IFS=$old_IFS
echo "Done!"
