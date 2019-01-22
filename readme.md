# pure-vim


#### 前言

在 0.1.3 发布时, 我正在尝试使用这个项目到工作环境 "java + maven + lombok". 不得不说, 非常头疼, 印证了大家说的, vim 不适合用于编辑 java 项目. 所以, 这个项目未来将会作为种子项目, 我会对于不同的工作环境配置不同的定制化vim.

## 简介

**pure-vim** 是一个 **docker化** 的 vim.

基于 alpine 的镜像, 使用脚本 build 完成的镜像, 只有 47.6MB.

**"docker化"**, **"习惯至上"**, **"核心而小巧"** 为原则.

## 我想要的 pure-vim

我想要的 **pure-vim** 是一个 **类IDE( IDE like )**, **不具有**一个完善的IDE的**所有**功能, 而是有着 IDE **最核心功能**的编辑器.

为选定一个技术栈之后定制 pure-vim 提供方便.
所以它不会像 [spacevim](https://spacevim.org/) 一样, 将数个流行编程语言的各种IDE集成功能都包含进去, 那样太大了. **我期望定制之后的版本也尽可能只引入非常核心的 IDE 编辑功能, 并将其定位于第二开发工具. 因为毕竟vim是基于终端的.**

同时, 因为 pure-vim 是 docker 化的, 基于 alpine 的. 所以, 其本身就是一个完整的 linux, 我在 /usr/local/bin 中加入以下脚本作为辅助命令
    
- clean_cache: 清除 alpine 的 apk 命令的缓存

```sh
#e.g. 
clean_cache
```

- hit: 不如 ag, 但是专注检索文件内容

```sh
#e.g.   
hit . "*.java" "String()"
```

- ll: 就是 ll

```sh
#e.g. 
ll
```


## 版本

#### 当前版本

0.1.3

#### 历史版本

0.1.2
0.1.1

## 使用它

#### 1. 运行 pure-vim 在容器中

先说一句, 我是中国人, 所以**默认**使用了**东八时区**. 如有需要, 自行修改 Dockerfile.

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
- ale: 异步语法检测插件, **这个我并没有真正完成整合, 因为不同语言需要不同的环境配置, 在尝试配合 [java + maven] 时, 我头疼不已.**
- vim-snipmate 与 vim-snippets

部分插件名或重复, 请以vimrc内容为准

## 版本更新说明

#### 0.1.3

追加整合插件

- vim-snipmate 与 vim-snippets
- ale(仅仅添加了插件, 没有对接任何语言的语法检测)

#### 0.1.2

追加整合插件

- CtrlSF
- vim-multiple-cursors
- tagbar
- nerdcommenter

追加整合命令

- the_silver_searcher(ag命令), 将其与 CtrlP, CtrlSF 整合. 因 ag 非常高效, 已关闭插件缓存功能.
- ctags(5.8), 支持 tagbar


追加 vim 快捷键

- **"alt + w"**: 原为 **"关闭 vim tab"**, 现为 **"关闭 vim buffer"**. 原因是 buffer 比 tab 高效, 而我在使用中给自己提出了一个关闭 tabline(由airline提供) 中的 tab页 的需求. 具体实现请参考我实现的function `CloseCurrentTabFromTabline()`
- **"alt + shift + w"**: 由于 "alt + w" 被 **"关闭 vim buffer"** 占用, 所以将 **"关闭 vim tab"** 快捷键调整为这个.

#### 0.1.1

整合了以下插件, 自定义了不喜欢的快捷键

- vim-plug
- vim-devicons
- NERDTree
- vim-nerdtree-tabs
- nerdtree-git-plugin
- vim-terminal
- ctrlp
- vim-airline
- vim-fugitive

## 感谢

我就不逐一提及了. 
在这里我感谢所有插件的 coder, 相关社区, 提问者, 回答者(讨论者), vim 8.x 文档的编写者/译者(虽然有些内容难找, 难懂, 小小的笔误. 就是吐槽一下. 😂).

## 以下是构建时, 我遭遇的问题

### vimrc 中 mouse 的值 ? vimrc 中 map 的各个模式 ?

决定 vim 在什么场合下会使用鼠标:
n 普通模式
v 可视模式
i 插入模式
c 命令行模式
h 在帮助文件里，以上所有的模式
a 以上所有的模式
r 跳过 |hit-enter| 提示
A 在可视模式下自动选择

这里我一般只考虑 "set mouse=" 与 "set mouse=a", 所有模式下禁用或启用鼠标

map的前缀模式 map nmap nnoremap ?

- nore
表示非递归。
递归的映射。其实很好理解，也就是如果键a被映射成了b，c又被映射成了a，如果映射是递归的，那么c就被映射成了b。
- n
表示在普通模式下生效
- v
表示在可视模式下生效
- i
表示在插入模式下生效
- c
表示在命令行模式下生效

### 键盘 key 与 vimrc 中表示该 key 的标识的对应关系 ?

key跟标识的对应关系，详情可见 **:help key-notation**

### Vim中无法用Alt键来映射

"<A+key>" 格式替换为 "^[key" 格式, 可以在 insert 模式下, Crtl+v 后再按下 Alt+key(你想设置的键). 我猜测是早期并没有很多特殊符号, "<A+key>"是可以生效的, 而现代键盘使用组合件 **alt + key** 时, 有些组合会输入特殊意义的字符, 例如 alt + t = †, alt + z = Ω

### 使用 vim-devicons 对 NERDTree 优化时, 图标显示为问号或方框

由于vimrc中, 我已经 "set encoding=utf-8", 所以一定不是编码的问题, 猜想是字体的问题. 以下贴子佐证了我的猜想 
[遇到同样问题的老外](https://github.com/ryanoasis/vim-devicons/issues/198)
[vim-devicons Q&A 解答](https://github.com/ryanoasis/nerd-fonts#option-1-download-and-install-manually)
问题是当前要做的, 是给基础镜像 alpine 增加一个字体, 还是给我使用的 iTerm2 设置一下字体呢 ?
当然是后者, vim 使用中, 文本最终的展现形式是用显示出来的那台电脑决定的, 难道ssh到别的主机, 别人安装好字体, 我的终端就可以使用 ? 显然是不行的.
iTerm2 -> Preferences -> Profiles -> Text -> Font -> Use a different font for non-ASCii text, 勾选后, 在 Non-ASCii Font -> Change Font -> Hack Nerd Font.

字体怎么来的 ? 上面的贴子写的很清楚, 你要安装在自己的电脑上, 我的是 Mac, 使用 homebrew 安装即可

```sh
brew tap caskroom/fonts
brew cask install font-hack-nerd-font
```

### airline 没有颜色, 美化字体powerline 已被包含在 nerd font 中, 怎么找到 ?

由于 vim 默认是 8 彩色, air-line 是 256 彩色, 所以, 需要在 .vimrc 中追加

```vim
set t_Co=256        "开启256彩色
```
字体在这里找
http://nerdfonts.com/

搜 -PL- -PLE-

特殊字体需要追加

```vim
set ambiwidth=double
```

### vim buffer

[vim buffers](https://blog.csdn.net/fudesign2008/article/details/7295138)

### airline 的 tabline 在切换 buffer 时 卡顿

实际上只有 .vimrc 会造成卡顿, 因为测试文件夹和 /root/ 一个是宿主机挂载, 一个是容器内


## License

[MIT License Copyright (c) 2018~2019 Gavin](https://github.com/GavinGuan24/pure-vim/blob/master/LICENSE)



