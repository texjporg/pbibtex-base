TEXMF = $(shell kpsewhich -var-value=TEXMFHOME)

all:
	echo Nothing to be built.

.PHONY: install jisfile
install:
	mkdir -p ${TEXMF}/doc/ptex/pbibtex
	cp ./LICENSE ${TEXMF}/doc/ptex/pbibtex/
	cp ./README.md ${TEXMF}/doc/ptex/pbibtex/
	cp ./cpp.awk ${TEXMF}/doc/ptex/pbibtex/
	cp ./generate.sh ${TEXMF}/doc/ptex/pbibtex/
	cp ./jbibtex.bib ${TEXMF}/doc/ptex/pbibtex/
	cp ./jbtxbst.doc ${TEXMF}/doc/ptex/pbibtex/
	cp ./jbtxdoc.bib ${TEXMF}/doc/ptex/pbibtex/
	mkdir -p ${TEXMF}/pbibtex
	mkdir -p ${TEXMF}/pbibtex/bib
	cp ./jxampl.bib ${TEXMF}/pbibtex/bib/
	mkdir -p ${TEXMF}/pbibtex/bst
	cp ./*.bst ${TEXMF}/pbibtex/bst/
jisfile:
	mkdir -p jis0
	cp *.bib *.bst *.doc cpp.awk jis0/
	# GNU iconv can be used to convert UTF-8 -> ISO-2022-JP
	for x in jis0/*; do \
		if [ -f "$$x" ]; then \
			iconv -f UTF-8 -t ISO-2022-JP "$$x" >"$$x.conv"; \
			mv "$$x.conv" "$$x"; \
		fi \
	done
	rm -f jis/*.{bib,bst,doc,awk}
	mv jis0/* jis/
	rmdir jis0
