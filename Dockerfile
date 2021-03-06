# Based on https://android.googlesource.com/platform/build/+/master/tools/docker/Dockerfile
FROM ubuntu:16.04
ARG userid
ARG groupid
ARG username
RUN apt-get update && apt-get install -y git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip quilt libffi-dev libssl-dev libsqlite3-dev libreadline-dev libncursesw5-dev libbz2-dev liblzma-dev libgdbm-dev libdb-dev tk-dev blt-dev libexpat1-dev libmpdec-dev uuid-dev python
RUN curl -o jdk8.tgz https://android.googlesource.com/platform/prebuilts/jdk/jdk8/+archive/master.tar.gz \
 && tar -zxf jdk8.tgz linux-x86 \
 && mkdir -p /usr/lib/jvm \
 && mv linux-x86 /usr/lib/jvm/java-8-openjdk-amd64 \
 && rm -rf jdk8.tgz
RUN curl -o Python-3.8.7.tgz https://www.python.org/ftp/python/3.8.7/Python-3.8.7.tgz && tar -xvf Python-3.8.7.tgz && cd Python-3.8.7 && ./configure --enable-optimizations && make install
RUN curl -o /usr/local/bin/repo https://storage.googleapis.com/git-repo-downloads/repo \
 && chmod a+x /usr/local/bin/repo
RUN groupadd -g $groupid $username \
 && useradd -m -u $userid -g $groupid $username \
 && usermod -a -G sudo $username \
 && echo $username >/root/username
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
COPY data/gitconfig /home/$username/.gitconfig
ADD data /data
ADD patches /patches
ENV HOME=/home/$username
ENV USER=$username
ENTRYPOINT chroot --userspec=$(cat /root/username):$(cat /root/username) / /data/anbox-build.sh
