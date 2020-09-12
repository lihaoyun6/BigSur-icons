#!/bin/bash

old_IFS=$IFS
IFS=$'\n'
rm -rf thumbs
mkdir thumbs
cd icons
num=`ls *.icns|wc -l|tr -d ' '`
printf "### 点击小图标可跳转至ICNS原图  /  Click on the thumbnail to access the ICNS file  \n当前共有 ["$num"] 个图标 / Here are ["$num"] icons now  \n****  \n\n" >> ../thumbs/thumbs.md
printf "### 点击文字链接可跳转至ICNS原图  /  Click on the link to access the ICNS file  \n当前共有 ["$num"] 个图标 / Here are ["$num"] icons now  \n****  \n\n" >> ../thumbs/textlist.md
for i in `ls *.icns`
do
	sips -Z 128 -s format png $i --out ../thumbs/${i%.*}.png
	convert -background white -flatten -sampling-factor 4:2:0 -strip ../thumbs/${i%.*}.png ../thumbs/${i%.*}.jpg
	rm -f ../thumbs/${i%.*}.png
	iconName=${i%.*}
	urlName=$(echo ${i%.*}|sed 's/ /%20/g')
	#echo '[!['$iconName'.jpg](./'$urlName'.jpg "'$iconName'")](../icons/'$urlName'.icns)' >> ../thumbs/thumbs.md
	echo '<a href="../icons/'$urlName'.icns"><img src="./'$urlName'.jpg" alt="'$iconName'" width="64" /></a>' >> ../thumbs/thumbs.md
	echo '['$iconName'](../icons/'$urlName'.icns)  ' >> ../thumbs/textlist.md
done
cd ..
sed -i "" '$d' README.md
echo '当前共有 ['$num'] 个图标 / Here are ['$num'] icons now' >> README.md
IFS=$old_IFS
git add *
read -p "请输入commit信息: " commit
git commit -m "$commit"
git push origin master
echo "已完成!"
