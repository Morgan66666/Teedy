FROM sismics/ubuntu-jetty:9.4.36
#Using the LABEL instruction to add metadata to the image,sets the maintainer's
LABEL maintainer="b.gamard@sismics.com"
# update the package list, install various packages,
# clean up unnecessary files after installation to reduce the size of the image.
RUN apt-get update && \
apt-get -y -q --no-install-recommends install \
ffmpeg \
mediainfo \
tesseract-ocr \
tesseract-ocr-ara \
tesseract-ocr-ces \
tesseract-ocr-chi-sim \
tesseract-ocr-chi-tra \
tesseract-ocr-dan \
tesseract-ocr-deu \
tesseract-ocr-fin \
tesseract-ocr-fra \
tesseract-ocr-heb \
tesseract-ocr-hin \
tesseract-ocr-hun \
tesseract-ocr-ita \
tesseract-ocr-jpn \
tesseract-ocr-kor \
tesseract-ocr-lav \
tesseract-ocr-nld \
tesseract-ocr-nor \
tesseract-ocr-pol \
tesseract-ocr-por \
tesseract-ocr-rus \
tesseract-ocr-spa \
tesseract-ocr-swe \
tesseract-ocr-tha \
tesseract-ocr-tur \
tesseract-ocr-ukr \
tesseract-ocr-vie && \
apt-get clean && rm -rf /var/lib/apt/lists/*
# Remove the embedded javax.mail jar from Jetty
RUN rm -f /opt/jetty/lib/mail/javax.mail.glassfish-*.jar
# Add the local file docs.xml and the built WAR file docs-web-*.war to the container's #Jetty web applications directory.Allows Jetty to load these web applications at startup.
ADD docs.xml /opt/jetty/webapps/docs.xml
ADD docs-web/target/docs-web-*.war /opt/jetty/webapps/docs.war
# Sets the maximum heap memory to 1GB
ENV JAVA_OPTIONS -Xmx1g