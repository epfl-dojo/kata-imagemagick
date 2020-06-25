% — EPFL Dojo — \
  ImageMagick
% Giovanni Cangiani <<giovanni.cangiani@epfl.ch>>
% 2020-06-25

# ImageMagick

![](./img/image-magick-wizard.jpg)

https://imagemagick.org | https://github.com/imagemagick/imagemagick

---

# About

> ImageMagick is a free and open-source software suite for displaying,
  creating, converting, modifying, and editing raster images. It can read and
  write over 200 image file formats.

https://en.wikipedia.org/wiki/ImageMagick#cite_note-exploits-ars-technica-5

---

# History

> ImageMagick was created in 1987 by John Cristy when working at DuPont, to
convert 24-bit images (16 million colors) to 8-bit images (256 colors), so they
could be displayed on most screens. It was freely released in 1990 when DuPont
agreed to transfer copyright to ImageMagick Studio LLC, still currently the
project maintainer organization.

https://en.wikipedia.org/wiki/ImageMagick#History

---

# Features and Capabilities

   * [File format conversion](https://imagemagick.org/script/convert.php)
   * [Animation](https://imagemagick.org/Usage/anim_basics/)
   * [Color management](https://imagemagick.org/script/color-management.php)
   * [Command-line processing](https://imagemagick.org/script/command-line-processing.php)
   * [Montage](https://imagemagick.org/script/montage.php)
   * [Special effects](https://imagemagick.org/Usage/blur/)
   * [Text & comments](https://imagemagick.org/Usage/text/)
   * and much more...

---

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

---

### miff images
 - is the internal IM storage and can hold several images

---

### Commands
 * identify (`identify [-verbose] file.png` is equivalent to `convert [-verbose] file.png info:-`)
 * convert (magick)
 * compare
 * mogrify
 * montage
 * display (X11 only)

---

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