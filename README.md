# FFMpeg and ImageMagick

## Ideas
 * Two more _unix power tools_: nothing is better than command line for repetitive tasks
 * Web gallery in bash with image overlay and exif info
 * FFmpeg pipes: multiple output with one input 
 * html HiHDI images @2x
 * IM filters. Worrolizer 
 * study JPEG compression

options with `+` and `-` have differen mening. Example:
 - `-write` writes the image in the given format. The image will be available
   for further processing later in the pipe
 - `+write` writes the image in the given format but duplicate the original
   before so that the next processing in the pipe is done on an uncompressed
   image
 - `-append` attach image below
 - `+append` attach image on the right

 
### miff images
 - is the internal IM storage and can hold several images


### Commands
 * identify (`identify [-verbose] file.png` is equivalent to `convert [-verbose] file.png info:-`)
 * convert (magick)
 * compare
 * mogrify
 * montage
 * display (X11 only)


```
PresentazioneFFMpegImageMagick % convert -list interpolate     
Average
Average4	
Average9
Average16
Background
Bilinear
Blend
Catrom
Integer
Mesh
Nearest
Spline
```



[FredsEffects]: http://www.fmwconcepts.com/imagemagick/index.php
[TheColorApi]: http://www.thecolorapi.com/docs
[colormindApi]: http://colormind.io/api-access/

[clut]: http://www.imagemagick.org/script/command-line-options.php#clut
[interpolate]: http://www.imagemagick.org/script/command-line-options.php#interpolate
https://www.ibm.com/developerworks/library/l-graf/?ca=dnt-428