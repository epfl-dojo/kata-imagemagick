#!/bin/sh
# WARHOLize the image of Marilyn Monroe with FFMpeg
# set -x

# IM canvas and interpolation


src=images/MarilynMonroe.jpg
tmpdir="tmp/warholizer"
tmpsq=$tmpdir/01_square_marilyn
tmpcm=$tmpdir/02_colorized_marilyn
tmpft=$tmpdir/03_multiple_marilyn
tmpgr=$tmpdir/04_gray_warhol
dst=$tmpdir/05_warholized_marilyn

xcrgbs() {
	if [ $# -lt 3 ] ; then
	  color="hex=$1"
	  shift 1
	else
	  color="rgb=rgb($1,$2,$3)"
	  shift 3
	fi	
	if [ $# -gt 0 ] ; then
		mode="mode=$1"
	else
		mode="mode=analogic"
	fi
	shift 1
	count="count=3"
	curl -k "http://www.thecolorapi.com/scheme?$color&$mode&$count&format=json" \
	| jq .colors[].hex.value | awk '{printf(" xc:%s", $0);}'
}

[ -d $tmpdir ] || mkdir -p $tmpdir 

rm $tmpdir/*.jpg $tmpdir/*.png

# Create a 100x100 square solid color
convert -size 100x100 xc:#ff0000 $tmpdir/red_square.png 

# Create 6 of those and put them one next to the other (+append)
convert -size 100x500 \(  xc:"hsv(0,255,255)" xc:"hsv(50,255,255)" xc:"hsv(100,255,255)" xc:"hsv(150,255,255)" xc:"hsv(200,255,255)" xc:"hsv(250,255,255)" +append \) $tmpdir/rainbow_hflag.png

# Actually the reainbow flag have colors one on top of the other...
convert -size 500x50 \(  xc:"hsv(0,255,255)" xc:"hsv(50,255,255)" xc:"hsv(100,255,255)" xc:"hsv(150,255,255)" xc:"hsv(200,255,255)" xc:"hsv(250,255,255)" -append \) $tmpdir/rainbow_vflag.png

[ -f $tmpdir/c1 ] || ( xcrgbs FF00CC triad > $tmpdir/c1 )
[ -f $tmpdir/c2 ] || ( xcrgbs 6F00FF triad > $tmpdir/c2 )
[ -f $tmpdir/c3 ] || ( xcrgbs F2FF00 monochrome-light > $tmpdir/c3 )
[ -f $tmpdir/c4 ] || ( xcrgbs 00FF19 triad > $tmpdir/c4 )
xc1="$(cat $tmpdir/c1)"
xc2="$(cat $tmpdir/c2)"
xc3="$(cat $tmpdir/c3)"
xc4="$(cat $tmpdir/c4)"

sqsize=$(identify -format "%[fx:min(w,h)]" $src)
echo "sqsize: $sqsize"

# Crop the image to obtain a square
convert $src -gravity center -crop ${sqsize}x${sqsize}+0+0 +repage $tmpsq.jpg

# Colorize the image a la Warhol trying various interpolation methods
for interp in Average Average9 Bilinear Blend Catrom Integer Mesh Nearest Spline ; do
	convert $tmpsq.jpg \
		-colorspace gray \( $xc1 +append \) -interpolate $interp -clut \
		${tmpcm}_$interp.jpg
done

convert $tmpsq.jpg \( -clone 0 \) \( -clone 0  \) \( -clone 0 \) \
  miff:- | montage - -geometry +0+0 $tmpft.jpg

convert $tmpsq.jpg -colorspace gray \( -clone 0 \) \( -clone 0 \) \( -clone 0  \) \( -clone 0 \) \
  -delete 0 miff:- | montage - -geometry +0+0 $tmpgr.jpg

convert $tmpsq.jpg -colorspace gray \
	\( -clone 0 \( $xc1 +append \) -interpolate Nearest -clut \) \
	\( -clone 0 \( $xc2 +append \) -interpolate Nearest -clut \) \
	\( -clone 0 \( $xc3 +append \) -interpolate Nearest -clut \) \
	\( -clone 0 \( $xc4 +append \) -interpolate Nearest -clut \) \
	-delete 0 miff:- | montage - -geometry +0+0 $dst.jpg

