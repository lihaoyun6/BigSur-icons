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
	iconName=${i%.*}
	urlName=$(echo ${i%.*}|sed 's/ /%20/g')
	echo '[!['$iconName'.jpg](./'$urlName'.jpg "'$iconName'")](../icons/'$urlName'.icns)' >> ../thumbs/thumbs.md
	echo '['$iconName'](../icons/'$urlName'.icns)  ' >> ../thumbs/textlist.md
done
cd ..
IFS=$old_IFS
echo "Done!"
