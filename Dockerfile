FROM ubuntu:rolling
COPY data /data
RUN apt update
RUN apt install -y openssh-server bedtools wamerican
RUN mkdir /var/run/sshd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]