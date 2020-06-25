#!/bin/sh
set -x
src=images/malawi.jpg

dir=tmp/compression

[ -d $dir ] || mkdir $dir

rm $dir/diff.data
for q in 10 20 30 40 50 60 70 80 90 ; do 
	convert $src -quality $q $dir/quality_$q.jpg
	d=$(compare -metric SSIM  $src $dir/quality_$q.jpg $dir/diff_$q.png 2>&1)
	s=$(ls -l $src $dir/quality_$q.jpg | awk 'NR==1{s0=$5; next}{print $5/s0;}')
	echo "$q $d $s" >> $dir/diff.data
done

gnuplot << EOF
set xrange [0:100]
set yrange [0:1]
set term svg
set output "$dir/diff.svg"
plot "$dir/diff.data" u 1:2 title "diff", "$dir/diff.data" u 1:3 title "size"
EOF

q=60
l=$dir/quality_$q.jpg
for i in {1..9} ; do 
	convert $l -quality $q $dir/iterate_$i.jpg 
	compare -metric SSIM  $src $dir/iterate_$i.jpg $dir/iterdiff_$i.png 2>&1
	echo
	l=$dir/iterate_$i.jpg 
done
  