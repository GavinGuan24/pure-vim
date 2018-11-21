# pure-vim

pure-vim 是一个 docker 化的 vim.
"习惯至上", "核心而小巧" 为原则

## 我想要的 pure-vim

我想要的 pure-vim 是一个类IDE, 不具有一个完善的IDE的所有功能, 而是有着IDE最基本的功能的编辑器.
为选定一个技术栈之后定制 pure-vim 提供方便.
所以它不会像 [spacevim](https://spacevim.org/) 一样, 将数个流行编程语言的各种IDE集成功能都包含进去.

## 版本

#### 当前版本

0.1.0

#### 历史版本

0.0.1

## 使用它

#### 1. 运行 pure-vim 在容器中

执行

```sh
git clone git@github.com:GavinGuan24/pure-vim.git
cd pure-vim
vim run_container.sh
```

修改run_container中的 **target_folder** 为你喜欢的文件夹路径(执行脚本时, 脚本会为其加上你定制的版本号作为后缀)

执行

```sh
chmod 755 build_image.sh run_container.sh
# 0.1.0 可以被替换为你喜欢的任何版本名. 由于我编写 pure-vim 的初衷, 所以保留了必填参数, 版本.
./build_image.sh 0.1.0
# 这里的版本号请与上一个保持一致
./run_container.sh 0.1.0
# 进入 docker 中的容器 pure-vim 开始你的编辑或定制工作(这里的版本号请与上一个保持一致)
docker exec -it purevim_0.1.0 /bin/sh
```

在容器中执行

```sh
# 默认用户是root, 这里进入的是/root/
cd
# 打开vim
vim
:PlugInstall
# 提示插件安装完成后, 关闭vim, 重新进入即可开始你的表演
```


## 已完成的整合

- vim-plug: 插件管理工具
- vim-devicons: 图标插件, 支持多个vim插件, 如:NERDTree
- NERDTree: 目录树
	- vim-nerdtree-tabs: 使 NERDTree 更像一个独立窗口
	- nerdtree-git-plugin: 显示文件的git状态
- vim-terminal: 基于 vim split 的终端
- ctrlp: 模糊搜索文件等

## 试用中或尝试整合的插件

- vim-airline
- syntastic
- tagbar
