#! /bin/sh
mv src/cv.xml src/cv.old.xml
openssl enc -d -aes-256-cbc -a -in src/cv.enc -out src/cv.xml