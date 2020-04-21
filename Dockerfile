FROM ubuntu

RUN apt-get update -y \
	&& apt-get install -y \
		build-essential \
		inotify-tools \
		ocaml-native-compilers \
		wget

ARG UNISON_VERSION=2.51.2
RUN echo "Install Unison." \
    && cd /tmp \
    && wget https://github.com/bcpierce00/unison/archive/v$UNISON_VERSION.tar.gz \
    && tar -xzvf v$UNISON_VERSION.tar.gz \
    && rm v$UNISON_VERSION.tar.gz \
    && cd unison-$UNISON_VERSION \
    && make \
    && cp -t /usr/local/bin ./src/unison ./src/unison-fsmonitor \
    && cd .. \
    && rm -rf unison-$UNISON_VERSION \
    && cd ..
