# pure-vim

**pure-vim** 是一个 **docker化** 的 vim.
基于 alpine 的镜像, 使用脚本 build 完成的镜像, 只有 47.6MB
**"docker化"**, **"习惯至上"**, **"核心而小巧"** 为原则

## 我想要的 pure-vim

我想要的 **pure-vim** 是一个 **类IDE( IDE like )**, **不具有**一个完善的IDE的**所有**功能, 而是有着 IDE **最核心功能**的编辑器.

为选定一个技术栈之后定制 pure-vim 提供方便.
所以它不会像 [spacevim](https://spacevim.org/) 一样, 将数个流行编程语言的各种IDE集成功能都包含进去, 那样太大了.

同时, 因为 pure-vim 是 docker 化的, 基于 alpine 的. 所以, 其本身就是一个完整的 linux, 我在 /usr/local/bin 中加入以下脚本作为辅助命令
    
    - clean_cache: 清除 alpine 的 apk 命令的缓存
    - hit: 不如 ag, 但是专注检索文件内容
    - ll: 就是 ll


## 版本

#### 当前版本

0.1.2

#### 历史版本

0.1.1

## 使用它

#### 1. 运行 pure-vim 在容器中

执行

```sh
git clone git@github.com:GavinGuan24/pure-vim.git
cd pure-vim
vim run_container.sh
```

修改run_container中的 **target_folder** 为你喜欢的文件夹路径(执行脚本时, 脚本会为其加上你定制的版本号作为后缀)
target_folder: pure-vim 容器运行时, 宿主机挂载到容器中的文件夹路径

执行

```sh
chmod 755 build_image.sh run_container.sh
# 0.1.2 可以被替换为你喜欢的任何版本名. 由于我编写 pure-vim 的初衷, 所以保留了必填参数, 版本.
./build_image.sh 0.1.2
# 这里的版本号请与上一个保持一致
./run_container.sh 0.1.2
# 进入 docker 中的容器 pure-vim 开始你的编辑或定制工作(这里的版本号请与上一个保持一致)
docker exec -it purevim_0.1.2 /bin/sh
```

在容器中执行

```sh
# 默认用户是root, 这里进入的是/root/
cd
# 打开vim
vim
:PlugInstall
# 提示插件安装完成后, 关闭vim, 重新进入 vim 即可开始你的 coding
```
#### 2. 快捷键(不同系统的终端对 Alt, Cmd 等特殊键值的处理方式不一, 以下配置仅在 Mac/iTerm 中使用过)

插件自带的快捷键如果少量且方便记忆的, 我基本没有改过. 

以下是我觉得使用不便才修改或新加入的快捷键.
**\<Leader\> = ,**

| map mode		| keys			| func|
| ------------- |:-------------:| -----:|
| n | \<Leader\>,s | 新启 vim tab 快速编辑 .vimrc |
| n | \<Leader\>1 | 开启/关闭 NERDTree |
| n | \<Leader\>2 | 使用 vim split 从底部开启 terminal |
| n | \<Leader\>3 | 开启/关闭 tagbar 窗 |
| n | alt + z | 停用鼠标操作, 隐藏行号 |
| n | alt + m	| 启用鼠标操作, 启用行号 |
| n i| alt + s	 | 保存当前buffer |
| n i | alt + w | 关闭(可选保存) airline 的 tabline 中当前展示的 buffer |
| n i | alt + shift + w| 关闭当前 vim tab 页. 不推荐使用, 请使用 airline 替代 |
| v | alt + c | 复制选中文本 |
| n i v | alt + v| 粘贴 |
| n | alt + ] | 下一个 buffer |
| n | alt + [ | 上一个 buffer |
| n v | \<Leader\>f | 将 手动输入内容/选中的文本 进行全局内容搜索 |
| n | \<Leader\>F | 开启/关闭 全局内容搜索 窗 |
| n v | alt + / | 快速注解/取消注解 |
| - | - | **以下是 multiple-cursors 快捷键, 建议仅在 normal/visual 模式下使用** |
| n v | alt + shift + ] | multi_cursor_start_word_key 开始匹配 |
| n v | alt + shift + a | multi_cursor_select_all_word_key 直接匹配所有 |
| n v | alt + shift + - | multi_cursor_start_key g开始匹配 |
| n v | alt + shift + + | multi_cursor_select_all_key g直接匹配所有 |
| n v | alt + shift + ] | 匹配下一个 |
| n v | alt + shift + [ | 回到上一个 |
| n v | alt + shift + \ | 跳过当前匹配 |
| n v | esc | 退出多光标模式 |

## 已完成的整合

- vim-plug: 插件管理工具
- vim-devicons: 图标插件, 支持多个vim插件, 如:NERDTree
- NERDTree: 目录树
	- vim-nerdtree-tabs: 使 NERDTree 更像一个独立窗口
	- nerdtree-git-plugin: 显示文件的git状态
- vim-terminal: 基于 vim split 的终端
- ctrlp: 对路径/文件名等 模糊搜索, 并跳转
- vim-airline: 提供 status/tab line, 同时支持多个插件,例如: fugitive
- fugitive: git 的很多功能进行了封装
- CtrlSF: 全局文件内容搜索
- vim-multiple-cursors: 多光标编辑
- tagbar: 提供文件概览信息, 仅支持部分文件类型

部分插件名或重复, 请以vimrc内容为准


## 试用中或尝试整合的插件

- syntastic
- ale

- ultisnips
- snipMate


