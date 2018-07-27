CIBLE=template_final

all: $(CIBLE).eps


%.eps: %.pdf	
	pdfcrop $< 
	pdftops -f 3 -l 3 -eps $(CIBLE)-crop.pdf 	 
	rm  $(CIBLE)-crop.pdf 
	mv  $(CIBLE)-crop.eps $(CIBLE).eps
	#inkscape $(CIBLE).eps
