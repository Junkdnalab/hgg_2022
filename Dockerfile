FROM ubuntu:rolling
COPY data /data
RUN yes | unminimize
RUN apt update
RUN apt install -y openssh-server bedtools wamerican nano less vim man manpages gawk
RUN mkdir /var/run/sshd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]