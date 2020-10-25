FROM centos:7

RUN yum -y install openssh-server

RUN useradd deploy && \
    echo "deploy123" | passwd deploy --stdin && \
    mkdir /home/deploy/.ssh && \
    chmod 700 /home/deploy/.ssh

COPY deploy.pub /home/deploy/.ssh/authorized_keys

RUN chown -R deploy:deploy /home/deploy/.ssh/ && \
    chmod 600 /home/deploy/.ssh/authorized_keys

RUN /usr/sbin/sshd-keygen

# CMD /usr/sbin/sshd -D
CMD ["/usr/sbin/sshd", "-D"]
