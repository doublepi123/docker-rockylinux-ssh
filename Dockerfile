FROM rockylinux

RUN dnf install openssh-server vim -y
RUN mkdir -p /run/sshd
RUN echo "root:password" | chpasswd
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key  -N '' 
RUN sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config
RUN sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config

CMD /usr/sbin/sshd -D