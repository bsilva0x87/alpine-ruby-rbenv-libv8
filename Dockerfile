FROM alpine:3.8

RUN apk add --update \
    bash \
    git \
    curl \
    vim \
    build-base \
    readline-dev \
    openssl-dev \
    zlib-dev \
    && rm -rf /var/cache/apk/*

# RBENV
ENV PATH /usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH
ENV RBENV_ROOT /usr/local/rbenv
ENV CONFIGURE_OPTS --disable-install-doc

RUN apk add --update \
    linux-headers \
    imagemagick-dev \    
    libffi-dev \    
    libffi-dev \
    && rm -rf /var/cache/apk/*

RUN git clone --depth 1 https://github.com/rbenv/rbenv.git ${RBENV_ROOT} \
    && git clone --depth 1 https://github.com/rbenv/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build \
    && ${RBENV_ROOT}/plugins/ruby-build/install.sh

RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh 

ENV RUBY_VERSION 1.9.3-p550
ENV BUNDLER_VERSION 1.16.2
ENV LIBV8_VERSION 3.16.14.11

RUN apk add busybox=1.29.3-r10 --repository=http://dl-cdn.alpinelinux.org/alpine/v3.9/main/

RUN curl https://patch-diff.githubusercontent.com/raw/ruby/ruby/pull/1485.patch -o /tmp/ruby_compile_fix.patch \
    && rbenv install --patch $RUBY_VERSION < /tmp/ruby_compile_fix.patch \
    && rbenv global $RUBY_VERSION \
    && gem install --no-rdoc --no-ri bundler -v $BUNDLER_VERSION \
    && gem install --no-rdoc --no-ri libv8 -v $LIBV8_VERSION \
    && rbenv rehash

COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]