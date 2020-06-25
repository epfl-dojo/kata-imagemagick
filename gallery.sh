#!/bin/sh
# http://www.imagemagick.org/Usage/thumbnails/
# at most 100x100 keeping aspect ratio
# convert -define jpeg:size=200x200 $srcdir/*.jpg \
#         -thumbnail '100x100>' $thdir/%03d.png

# exactly 100x100 with black background filler
# convert -define jpeg:size=200x200 $srcdir/*.jpg -thumbnail '100x100>' \
#         -background black -gravity center -extent 100x100 $thdir/%03d.png
# convert -define jpeg:size=500x180 $srcdir/*.jpg -auto-orient \
#         -thumbnail x90 -unsharp 0x.5 $thdir/%03d.png

# set -x
set -e

srcdir=images/gallery
thdir=tmp/gallery/thumbs
imdir=tmp/gallery/images
index=tmp/gallery/index.html

[ -d $thdir ] || mkdir -p $thdir
[ -d $imdir ] || mkdir -p $imdir

rm -f $imdir/*
rm -f $thdir/*

watemark="-pointsize 24 -fill black -annotate +621+32 unsplash.com -fill white -annotate +620+32 unsplash.com" 
i=0
for src in $srcdir/*.jpg ; do 
  sn=$(printf "%03d" $i)
  echo "$src -> $sn"
  let i=$i+1
  # Use write to avoid reading the original image twice:
  convert $src \( +clone -resize 800x $watemark -write $imdir/$sn.jpg +delete \) \
          -thumbnail 100x100^ -gravity center -extent 100x100  $thdir/$sn.png 
done

# cut the image to fit 100x100 thumbnail
# convert -define jpeg:size=200x200 $srcdir/*.jpg  -thumbnail 100x100^ \
#         -gravity center -extent 100x100  $thdir/%03d.png


cat > $index << EOF
<!DOCTYPE html>
<html>
<head>
	<title>A simple Bash Gallery</title>
	<style type="text/css">
		body { background-color: #000; color: #999;}
		h1 { text-align: center; }
		ul { margin: 2em auto; list-style-type: none; overflow: hidden; width:800px; }
		ul li { margin-left: 20px; float:left; }
		ul li a { display: block; padding: 5px;}
		ul li a:hover { background: #999; }
	</style>
</head>
<body>
	<h1>Minimal Image Gallery</h1>
	<ul>
EOF

for i in $(ls -1 $imdir) ; do
	ipath=$(basename $imdir)/$i
	tpath=$(basename $thdir)/$(basename $i .jpg).png
	echo "      <li><a href='$ipath' target='_blank'><img src='$tpath'></a></li>" >> $index
done

cat >> $index << EOF
	</ul>
</body>
</html>
EOF