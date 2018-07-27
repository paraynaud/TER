FILE1=template
SRC=$(FILE1).tex 
RES= $(FILE1).pdf 



all: $(RES)
	ls; \
	evince $(RES) &

%.pdf : %.tex
	ls
	texliveonfly $< 
