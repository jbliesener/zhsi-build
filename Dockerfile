FROM ubuntu:bionic
RUN apt update -qq
RUN apt -yq install gnupg ca-certificates apt-transport-https software-properties-common git
RUN echo "deb http://mirror.mxe.cc/repos/apt bionic main" | tee /etc/apt/sources.list.d/mxeapt.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D43A795B73B16ABE9643FE1AFD8FFF16DB45C6AB
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C6BF758A33A3A276
RUN apt update -qq
RUN apt install -yq mxe-x86-64-w64-mingw32.static-qtbase mxe-x86-64-w64-mingw32.static-qtdeclarative
RUN apt install -yq build-essential perl python git
RUN git clone https://code.qt.io/qt/qt5.git && \
    cd qt5 && \
    git checkout 5.12 && \
    perl init-repository --module-subset=qtbase,qtdeclarative && \
    cd .. && \
    mkdir qt5build-static && \
    cd qt5build-static && \
    ../qt5/configure -static -prefix /opt/qt5-static -opensource -confirm-license -qt-zlib -qt-libjpeg -qt-libpng -qt-freetype -qt-pcre -qt-harfbuzz -no-opengl -nomake examples -nomake tests && \
    make -j 4 && \
    make install
RUN wget http://developer.x-plane.com/wp-content/plugins/code-sample-generation/sample_templates/XPSDK300.zip
RUN unzip *.zip
RUN rm XPSDK300.zip
RUN mv SDK /XPlaneSDK

