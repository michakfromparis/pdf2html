FROM ubuntu
VOLUME /fontforge
VOLUME /pdf2htmlEX
# install system dependencies
RUN apt-get update && apt-get install -qq git cmake autotools-dev libjpeg-dev libtiff-dev libpng-dev libgif-dev libxt-dev autoconf automake libtool bzip2 libxml2-dev libuninameslist-dev libspiro-dev python-dev libpango1.0-dev libcairo2-dev chrpath uuid-dev uthash-dev libpoppler-glib-dev libpoppler-private-dev
# clone, configure & build fontforge
RUN git clone git://github.com/michakfromparis/fontforge.git /fontforge && cd /fontforge && git checkout pdf2htmlEX && ./autogen.sh && ./configure && make V=1 && make install
# clone and configure pdf2htmlEX
RUN git clone git://github.com/michakfromparis/pdf2htmlEX.git /pdf2htmlEX && cd pdf2htmlEX && mkdir build && cd build && cmake .. 
# build & install pdf2htmlEX
RUN cd /pdf2htmlEX/build && make && sudo make install
ENTRYPOINT ["pdf2htmlEX"]
CMD ["-h"]
