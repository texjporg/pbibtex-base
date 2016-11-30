RM = rm
PLATEX = platex -kanji=jis
PBIBTEX = pbibtex -kanji=jis

all:	test clean

test:
	$(PLATEX) test
	$(PBIBTEX) test
	$(PLATEX) test
	$(PLATEX) test
	diff test.bbl jplain.bbl.base
	@echo \*\*\*  TESTING SUCCESS  \*\*\*

clean:
	$(RM) *.dvi *.aux *.bbl *.blg *.log #*.bib *.bst
