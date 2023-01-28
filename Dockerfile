FROM alpine

RUN apk add --update openssh

COPY sshd_config /etc/ssh/sshd_bastion_config
RUN echo "Include /etc/ssh/sshd_bastion_config" >> /etc/ssh/sshd_config

RUN adduser -D -s /bin/sh -H bastion
RUN passwd -u -d bastion

EXPOSE 2222

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]