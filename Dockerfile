FROM anapsix/alpine-java:8_jdk
#FROM alpine

COPY ./usr_local_bin/ /usr/local/bin
COPY ./vimrc /root/.vimrc
#COPY ./jdk1.8.0_202 /usr/local/jdk

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
	&& echo -e '# self-defined\n' >> /etc/profile \
	&& echo 'export PS1="\[\e[35m\]\u\[\e[30m\]@\[\e[32m\]\h \[\e[36m\]\w\e[31m\] \$ \[\e[0m\]"' >> /etc/profile \
	&& echo -e '\n' >> /etc/profile \
	&& apk --no-cache add vim \
#	alpine 非常精简, 这里加几个常用的工具
	&& apk add --no-cache bash git curl tzdata openssh \
#	vim 插件中依赖的外部命令行工具 或 所需依赖
	&& apk add --no-cache the_silver_searcher ctags gcc python3-dev musl-dev \
#	自行安装jdk8时, 需要 CA 证书验证工具
#	&& apk add --no-cache ca-certificates \
#	给自定义的脚本 755 权限
	&& chmod 755 /usr/local/bin/* \
#	安装 vim-plug
	&& curl -fLo /root/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
#	时区 东八
	&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo 'Asia/Shanghai' > /etc/timezone \
#	ssh 允许 root 登录, 并且设定 root 密码, ssh 初始化
	&& sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
	&& sed -i s/ash/bash/ /etc/passwd \
	&& echo "root:gavin" | chpasswd \
	&& ssh-keygen -A \
#   自行安装jdk8时, 安装依赖的CA证书, 安装依赖, 环境配置
#	&& wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
#	&& wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk \
#	&& wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-bin-2.28-r0.apk \
#	&& apk add glibc-2.28-r0.apk glibc-bin-2.28-r0.apk \
#	&& rm -rf glibc-2.28-r0.apk glibc-bin-2.28-r0.apk \
#	&& ln -s /lib/libc.musl-x86_64.so.1 /usr/lib/libc.musl-x86_64.so.1 \
#	&& ln -s /lib/libz.so.1 /usr/lib/libz.so.1 \
#	&& echo -e 'export JAVA_HOME=/usr/local/jdk\nexport PATH=.:$JAVA_HOME/bin:$PATH\n' >> /etc/profile \
#	此处的java_home 是 image 中带有的, 并不是自行安装的
	&& echo -e 'export JAVA_HOME=/opt/jdk1.8.0_192\nexport PATH=.:$JAVA_HOME/bin:$PATH\n' >> /etc/profile \
#	maven 安装及环境配置
	&& wget http://mirrors.shu.edu.cn/apache/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz \
	&& tar -zxf apache-maven-3.6.0-bin.tar.gz && mv apache-maven-3.6.0 /usr/local/maven \
	&& rm -rf apache-maven-3.6.0-bin.tar.gz \
	&& echo -e 'export MAVEN_HOME=/usr/local/maven\nexport PATH=$PATH:$MAVEN_HOME/bin\n' \
	&& echo "Finished. J-vim."
CMD /usr/sbin/sshd -D

# 花了一些时间结合 alpine 与 oracle-jdk11, 然后自己才疏学浅, 最后执行java -version 后报错解决不了, 于是改目标为oracle-jdk8.
# 简单说就是需要安装glibc的两个包, 建立两个软链, 配置一下环境变量即可使用了. 问题是我不知道如何精简jdk8.
# 自己构建的alpine-jdk8 有 400+MB, 于是使用docker仓库中别人配置好且清除了不必要文件的alpine-jdk8镜像.
# 之所以加入了 bash, openssh, 是因为 docker exec 进入容器时, 一些环境总是很奇怪, 所以放弃这种方式.
# 总之, 现在配置环境都在 /etc/profile 写, 然后 docker restart 容器即可.
