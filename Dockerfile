FROM alpine

COPY ./usr_local_bin/ /usr/local/bin
COPY ./vimrc /root/.vimrc

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
	&& apk add --no-cache vim git curl the_silver_searcher ctags\
	&& chmod 755 /usr/local/bin/* \
	&& curl -fLo /root/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
	&& echo 'Build Pure-vim Finished'
