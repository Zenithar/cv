.PHONY: clean pdf hresume html5 encode decode default

VERSION	        = $(shell git describe --always)

clean:
	rm -Rf target
	mkdir target

decode:
	mv src/cv.xml src/cv.old.xml
	openssl enc -d -aes-256-cbc -a -in src/cv.enc -out src/cv.xml

encode:
	openssl enc -aes-256-cbc -a -salt -in src/cv.xml -out src/cv.enc

fo-fr:
	xsltproc --stringparam current-date `date +%Y-%m-%d` --stringparam version $(VERSION) --stringparam OutLang fr tmpl/fo/cvFO.xsl src/cv.xml >> target/cv-fr.fo

fo-en:
	xsltproc --stringparam current-date `date +%Y-%m-%d` --stringparam version $(VERSION) --stringparam OutLang en tmpl/fo/cvFO.xsl src/cv.xml >> target/cv-en.fo

pdf-fr: fo-fr
	fop target/cv-fr.fo target/cv-fr.pdf

pdf-en: fo-en
	fop target/cv-en.fo target/cv-en.pdf

pdf: clean pdf-en pdf-fr

hresume:
	xsltproc tmpl/hresume/cvHResume.xsl src/cv.xml >> target/hresume.html

html5:
	xsltproc tmpl/html5/cvHTML5.xsl src/cv.xml >> target/html5.html

all: clean pdf hresume html5
