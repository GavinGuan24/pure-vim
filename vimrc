"========= 工具应该为使用习惯而生, 而不是人们尽可能地去习惯工具 ========="
"========================================================================"
"=========================== Gavin's settings ==========================="
"========================================================================"


"========= vim necessary setting - vim 的必要设置
set nocompatible    "禁用vim对vi的兼容模式
set encoding=utf-8  "使用UTF-8
let mapleader=","   "leader键, 避免快捷键冲突

"========= visible item - 可视组件 
set showmode        "显示当前vim模式
set ruler           "右下角显示当前光标的位置
set number          "显示行号


"========= find - 查找
set hlsearch        "查找时, 高亮所有匹配项
set ignorecase      "查找时忽略大小写
set incsearch       "查找框输入时即时高亮
set wrapscan        "找到文件结尾后折返开头


"========= coding - 编程
syntax on           "开启语法检测
filetype on         "自动判定文件类型


"========= edit - 编辑
set tabstop=4       "显示tab的空白符个数
set softtabstop=4   "键入tab时, 空白符个数
set shiftwidth=4    "级别间的tab, 空白符个数差
set expandtab       "使用空格替代tab
"set autoindent      "新行随上一行自动缩进
set smartindent
set mouse=a         "所有模式下均开启鼠标操作


"========= map - 基础快捷键
"可参考
"https://blog.csdn.net/lym152898/article/details/52171494
"https://www.jianshu.com/p/8ae25a680ed7
"alt + z 停用鼠标操作
nmap Ω :set mouse=<CR>:set nonu<CR>
"alt + m 启用鼠标操作
nmap µ :set mouse=a<CR>:set nu<CR>
"alt + s 快速保存当前buffer
imap ß <Esc>:w<CR>i<Right>
nmap ß :w<CR>
"alt + w 关闭当前tab页
imap ∑ ß<Esc>:tabc<CR>
nmap ∑ ß:tabc<CR> 
"========= beta - 试用功能

"========================================================
"===================== vim-plug 管理器 ==================
"========================================================
call plug#begin('~/.vim/plugged')
"NERDTree : 树目录, 树形结构的文件(夹)浏览窗
Plug 'https://github.com/scrooloose/nerdtree.git'
"NERDTree tab : 统一 vim tab页的树目录, 使NERDTree更像一个独立窗口
Plug 'jistr/vim-nerdtree-tabs'
"NERDTree git : 提供有限的文件git状态展示功能
Plug 'Xuyuanp/nerdtree-git-plugin'
"vim terminal : 中快速开启一个 vim split 来使用 terminal
Plug 'PangPangPangPangPang/vim-terminal'
"CtrlP : 搜索vim中的一切file, buffer, mru, tag, ...
Plug 'ctrlpvim/ctrlp.vim'
"vim 图标插件, 支持多个vim插件, 如:NERDTree. 该插件需要最后一个加载
Plug 'ryanoasis/vim-devicons'

call plug#end()

"==================================
"========= vim 插件详细配置 =======
"==================================

"************************ NERDTree
"跟随vim启动, 已被 NERDTree tabs 替代
"autocmd vimenter * NERDTree
"=== 快捷键
"快速开关 NERDTree, 已被 NERDTree tabs 替代
"nmap ,1 :NERDTreeToggle<CR>
"=== 图标
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'


"************************ NERDTree tabs
"跟随vim启动
let g:nerdtree_tabs_open_on_console_startup=1
"=== 快捷键
"快速开关 NERDTree
nmap <Leader>1 :NERDTreeTabsToggle<CR>

"************************ vim-devicons
"启用文件夹图标, default = , 我是用了📂(这里default如果显示为问号之类的,
"因为没有对应的 Hack Nerd Font 字体)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = '📂'


"************************ nerdtree-git-plugin
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✎ )",
    \ "Staged"    : "+ )",
    \ "Untracked" : "? )",
    \ "Renamed"   : "R )",
    \ "Unmerged"  : "um)",
    \ "Deleted"   : "✖ )",
    \ "Dirty"     : "✗ )",
    \ "Clean"     : "✔︎ )",
    \ 'Ignored'   : "ig)",
    \ "Unknown"   : "?!)"
    \ }


"************************ vim-terminal
"F2, 快速开启vim内窗口terminal
nmap <Leader>2 :VSTerminalToggle<CR>

"************************ CtrlP
"优先按文件名搜索, ctrl + d 或者 ctrl + r 启用全路径或正则表达式
let g:ctrlp_by_filename = 1
"搜索框选项
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:15,results:15'
"不忽略隐藏文件(夹)
let g:ctrlp_show_hidden = 1
"忽略特定文件(夹)
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|idea)$',
    \ 'file': '\v\.(exe|so|dll|iws|iml|ipr|swp|DS_Store)$'
    \ }
"扫描文件数上限
let g:ctrlp_max_files = 10000
"递归目录树上限
let g:ctrlp_max_depth = 40




