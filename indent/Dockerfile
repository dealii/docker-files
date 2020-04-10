FROM dealii/base:gcc-serial

LABEL maintainer="timo.heister@gmail.com"

USER root

RUN wget https://github.com/dealii/dealii/releases/download/v9.0.0/clang-format-6-linux.tar.gz \
    && tar xfv clang* && cp clang-6/bin/clang-format /usr/local/bin/ \
    && rm -rf clang*

USER dealii
