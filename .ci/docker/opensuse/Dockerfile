# Create a virtual environment with all tools installed
# ref: https://hub.docker.com/r/opensuse/tumbleweed
FROM opensuse/tumbleweed AS env
LABEL maintainer="corentinl@google.com"
# Install system build dependencies
ENV PATH=$PATH:/usr/local/bin
RUN zypper up -y \
&& zypper install -y gcc gcc-c++ cmake git \
&& zypper clean -a
ENV CC=gcc CXX=g++

RUN cd /tmp \
&& git clone https://github.com/Mizux/CoinUtils.git \
&& cd CoinUtils \
&& cmake -H. -Bbuild \
&& cmake --build build --target install \
&& cd .. \
&& rm -rf CoinUtils

CMD [ "/bin/sh" ]

# Add the library src to our build env
FROM env AS devel
# Create lib directory
WORKDIR /home/lib
# Bundle lib source
COPY . .
# CMake configure
RUN cmake -S. -Bbuild
# CMake build
RUN cmake --build build --target all -v
# CMake build
RUN cmake --build build --target install

# Create an install image
FROM env AS install
# Copy lib from devel to prod
COPY --from=devel /usr/local /usr/local/
# Copy  sample
WORKDIR /home/sample
COPY .ci/sample .
