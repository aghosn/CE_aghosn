PAPER=edic
BIBCLOUDDIR=./bibcloud

all: pdf
pdf: $(PAPER).pdf

clean:
		rm -f $(PAPER).pdf prepress.pdf *.aux *.fdb_latexmk *.log *.bbl *.blg \
					*~ *.dvi *.vrb *.nav *.snm texput.* *.synctex.gz
			latexmk -C $(PAPER).tex

bib:
		$(BIBCLOUDDIR)/bibcloud.py $(PAPER)
			bibtex $(PAPER)
spell:
		../../tools/linearize.pl word $(PAPER).tex; open -a /Applications/Microsoft\ Word.app/ latex-all.tex

spell2:
		../../tools/lin.py  $(PAPER).tex >latex-all.log


$(PAPER).pdf:
		latexmk -pdf -latexoption=-halt-on-error \
				-latexoption=-file-line-error \
				-latexoption=-synctex=1 \
				-latexoption=-shell-escape \
				$(PAPER).tex \
				&& touch $(PAPER).dvi || ! rm -f $@
			#$(RM) $*.dvi *.aux *.log *.bbl *.blg *.toc *.tmp.ps



.PHONY: $(PAPER).pdf pdf all clean prepress.pdf