#!/bin/sh
set -x 

src=images/gallery/cameron-venti-ISqTudqZERQ-unsplash.jpg
src=images/gallery/pascal-meier-tXpD84c8ZwI-unsplash.jpg
wmk=images/dojoman.png

dir=tmp/composite
[ -d $dir ] || mkdir -p $dir

rm -f $dir/*.jpg
composite -gravity south $wmk $src $dir/00_basic_composite.jpg
composite -watermark 30x100 -gravity south $wmk $src $dir/01_watermark_30x100.jpg
composite -watermark 30x0 -gravity south $wmk $src $dir/02_watermark_30x0.jpg
composite -watermark 80x100 -gravity SouthEast $wmk $src $dir/03_watermark_80x100.jpg

# convert -list font
convert -background transparent -fill "#ffffff" \
        -font Helvetica -pointsize 240 label:"(C) EPFL-Dojo" $dir/copy.png
composite -watermark 30x100 -gravity SouthEast $dir/copy.png $src $dir/04_watermark_text1.jpg

convert -background transparent -fill "#ffffff"  \
        -font Helvetica -pointsize 240 label:"(C) EPFL-Dojo" miff:- \
    | composite -watermark 30x100 -gravity SouthEast - $src $dir/05_watermark_text2.jpg        

# composite -watermark 30x100 -gravity SouthEast           \
#         \( -background transparent -fill "#ffffff"           \
#           	 -font Helvetica -pointsize 240 label:"(C) EPFL-Dojo" \) \
#         $src $dir/01_watermark_text3.jpg

# composite -resize 25% -bordercolor "#000000" -border 10 $src $dir/98_bordered.jpg 
# magick $src -gravity Center -region 500x500-200+20 -negate $dir/99_inverted_square.jpg
