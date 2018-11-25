"========= 工具应该为使用习惯而生, 而不是人们尽可能地去习惯工具 ========="
"========================================================================"
"=========================== Gavin's settings ==========================="
"========================================================================"


"========= vim necessary setting - vim 的必要设置
set nocompatible    "禁用vim对vi的兼容模式
set encoding=utf-8  "使用UTF-8
let mapleader = ","   "leader键, 避免快捷键冲突
set t_Co=256        "开启256彩色


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
set smartindent     "自动缩进
set mouse=a         "所有模式下均开启鼠标操作


"========= map - 基础快捷键

"alt + z 停用鼠标操作, 同时停用行号
nmap Ω :set mouse=<CR>:set nonu<CR>

"alt + m 启用鼠标操作, 同时开启行号
nmap µ :set mouse=a<CR>:set nu<CR>

"alt + s 快速保存当前buffer
imap ß <Esc>:w<CR>i<Right>
nmap ß :w<CR>

"alt + w 关闭当前 vim tab 页 - 不推荐使用, 请使用 airline 替代
imap ∑ ß<Esc>:tabc<CR>
nmap ∑ ß:tabc<CR>

"alt + c 使用鼠标的复制, alt + v 不依赖鼠标的粘贴, 注意 p/P会粘贴在光标右/左
vnoremap ç y
inoremap √ <Esc>pi<Right>
nnoremap √ P  


" 快速编辑我的 vimrc
nmap <Leader>,s :e $MYVIMRC<CR>
"========= beta - 试用功能

"========================================================
"===================== vim-plug 管理器 ==================
"========================================================
call plug#begin('~/.vim/plugged')

"NERDTree
"   树目录, 树形结构的文件(夹)浏览窗
Plug 'https://github.com/scrooloose/nerdtree.git'

"NERDTree tab
"   统一 vim tab页的树目录, 使NERDTree更像一个独立窗口(不建议重度使用该插
"   件的功能, vim tab 的效率明显低于 vim buffer. 推荐习惯 airline 的 tabline
"   功能
Plug 'jistr/vim-nerdtree-tabs'

"NERDTree git
"   提供有限的文件git状态展示功能
Plug 'Xuyuanp/nerdtree-git-plugin'

"vim terminal
"   在 vim 中快速开启一个 vim split 来使用 terminal(该插件功能有限,
"   不推荐重度使用)
Plug 'PangPangPangPangPang/vim-terminal'

"CtrlP
"   按文件路径, 文件名搜索
Plug 'ctrlpvim/ctrlp.vim'

"airline
"   提供 status/tab line, 同时支持多个插件,例如: fugitive
Plug 'vim-airline/vim-airline'
"airline theme
"   提供多种 airline 主题配色, 如不喜欢 airline 默认集成的 dark 主题,
"   可使用该插件更换
"Plug 'vim-airline/vim-airline-themes'

"vim 图标插件, 支持多个vim插件, 如:NERDTree. 该插件需要最后一个加载
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
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
"跟随vim启动 NerdTree
let g:nerdtree_tabs_open_on_console_startup = 1
"当仅剩 NerdTree 窗口时, 自动关闭(最常见的情形就是没有活动的buffer时, 自动关闭)
let g:nerdtree_tabs_autoclose = 1
"=== 快捷键
"快速开关 NERDTree
nmap <Leader>1 :NERDTreeTabsToggle<CR>

"************************ vim-devicons
"启用文件夹图标, default = , 我是用了📂(这里default如果显示为问号之类的,
"因为没有对应的 Hack Nerd Font 字体<http://nerdfonts.com/>)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = '📂' 
"let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = nr2char(62541) 

"************************ nerdtree-git-plugin, f91a, fc44
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : " ",
    \ "Staged"    : " )",
    \ "Untracked" : "ﱄ )",
    \ "Renamed"   : "R )",
    \ "Unmerged"  : "!)",
    \ "Deleted"   : " )",
    \ "Dirty"     : " )",
    \ "Clean"     : "✔︎ )",
    \ 'Ignored'   : " )",
    \ "Unknown"   : " )"
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
let g:ctrlp_show_hidden = 0
"忽略特定文件(夹)
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|idea)$',
    \ 'file': '\v\.(exe|so|dll|iws|iml|ipr|swp|DS_Store)$'
    \ }
"扫描文件数上限
let g:ctrlp_max_files = 10000
"递归目录树上限
let g:ctrlp_max_depth = 40


"************************ air-line
"顶部tabline显示(tabline是管理vim buffer的, 比 vim tab 高效)
let g:airline#extensions#tabline#enabled = 1
"airline 当前主题
let g:airline_theme='dark'
"airline特殊字体需要开启该项, 不推荐
"set ambiwidth=double
"=== 快捷键
"alt + ] 下一个buffer
nmap ‘ :bn<CR>
"alt + [ 上一个buffer
nmap “ :bp<CR>
"=== 图标
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#close_symbol = nr2char(57869)

