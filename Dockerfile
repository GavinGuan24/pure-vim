FROM anapsix/alpine-java:8_jdk

COPY ./usr_local_bin/ /usr/local/bin
COPY ./vimrc /root/.vimrc

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
	&& apk add --no-cache vim git curl the_silver_searcher ctags tzdata openssh\
	&& chmod 755 /usr/local/bin/* \
	&& curl -fLo /root/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
	&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo 'Asia/Shanghai' > /etc/timezone \
	&& sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
	&& sed -i s/ash/bash/ /etc/passwd \
	&& echo "root:gavin" | chpasswd \
	&& ssh-keygen -A
CMD /usr/sbin/sshd -D
