#!/bin/bash


pdfcrop $1
pdftops -f $2 -l $2 -eps $1-crop.pdf 	 
rm  $1-crop.pdf 
mv  $1-crop.eps $1.eps
#inkscape $(CIBLE).eps
