.PHONY: clean pdf hresume html5 encode decode default

clean:
	rm -Rf target
	mkdir target

decode: 
	mv src/cv.xml src/cv.old.xml
	openssl enc -d -aes-256-cbc -a -in src/cv.enc -out src/cv.xml

encode:
	openssl enc -aes-256-cbc -a -salt -in src/cv.xml -out src/cv.enc

pdf:
	xsltproc tmpl/fo/cvFO.xsl src/cv.xml >> target/cv.fo
	fop target/cv.fo target/cv.pdf

hresume:
	xsltproc tmpl/hresume/cvHResume.xsl src/cv.xml >> target/hresume.html

html5:
	xsltproc tmpl/html5/cvHTML5.xsl src/cv.xml >> target/html5.html

all: clean pdf hresume html5