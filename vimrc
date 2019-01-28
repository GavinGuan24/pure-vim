"========= 工具应该为使用习惯而生, 而不是人们尽可能地去习惯工具 ========="
"========================================================================"
"=========================== Gavin's settings ==========================="
"========================================================================"


"========= vim necessary setting - vim 的必要设置
set nocompatible            "禁用vim对vi的兼容模式
set encoding=utf-8          "使用UTF-8
set backspace=2
let mapleader = ","         "leader键, 避免快捷键冲突
set t_Co=256                "开启256彩色


"========= visible item - 可视组件 
set showmode        "显示当前vim模式
set ruler           "右下角显示当前光标的位置
set number          "显示行号


"========= find - 查找
set hlsearch                "查找时, 高亮所有匹配项
set ignorecase              "查找时忽略大小写
set incsearch               "查找框输入时即时高亮
set wrapscan                "找到文件结尾后折返开头
set grepprg=ag\ --vimgrep   "使用 The Silver Searcher (ag) 替换 vim 默认的 grep
"高亮的前景色与背景色
hi Search term=standout ctermfg=0 ctermbg=3


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

"alt + w 关闭(同时保存)当前 airline 的 tabline 中的 tab 页, 即 关闭当前 buffer
imap ∑ :call CloseCurrentTabFromTabline()<CR>
nmap ∑ :call CloseCurrentTabFromTabline()<CR>

"shift + alt + w 关闭当前 vim tab 页 - 不推荐使用, 请使用 airline 替代
imap „ ß<Esc>:tabc<CR>
nmap „ ß:tabc<CR>

"alt + c 复制, alt + v 粘贴, 注意 p/P会粘贴在光标右/左
vnoremap ç y
inoremap √ <Esc>pi<Right>
nnoremap √ P
vnoremap √ P


" 快速编辑我的 vimrc
nmap <Leader>,s :tabnew<CR>:e $MYVIMRC<CR>

" 打开终端
nmap <Leader>2 :sh<CR>

"====================== Gavin 自定义命令 start =====================
"关闭(同时保存) airline 的 tabline 中当前展示的buffer
function! CloseCurrentTabFromTabline() 
    let a:sumOfListedBufs = len(getbufinfo({'buflisted':1}))
    "buffers size == 1 ? 询问唯一的buffer如何处理 : 多buffer时如何处理
    if a:sumOfListedBufs <= 1
        try
            :q
        catch /E37:/
            "unsaved changes
            let a:forcequit = confirm("\033[31mUnsaved changes. Continue Quit Vim ?\033[0m", "&Yes, Quit.\n&No, Handle it now.", 1)
            if a:forcequit == 1
                :q!
            endif
        endtry
    else
        let a:currentBufNr = str2nr(winbufnr(winnr()))
        let a:currentBufName = bufname(a:currentBufNr)
        try
            bp
        catch /E37:/
            if "" == a:currentBufName
                let a:fileSuffix = string(localtime())
                let a:howToDealUntitledBuf = confirm("\033[31mUnsaved [No Name] Buffer.\033[0m", "&Drop it.\n&Save it and named \"Untitled.".a:fileSuffix."\"", 1)
                if a:howToDealUntitledBuf == 1
                    :bp!
                else
                    execute "w "."Untitled.".a:fileSuffix
                    :bp
                endif
            endif
        endtry
        execute 'bd! '.a:currentBufNr
    endif
endfunction

"====================== Gavin 自定义命令 end =====================


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

"airline
"   提供 status/tab line, 同时支持多个插件,例如: fugitive
Plug 'vim-airline/vim-airline'
"airline theme
"   提供多种 airline 主题配色, 如不喜欢 airline 默认集成的 dark 主题,
"   可使用该插件更换
"Plug 'vim-airline/vim-airline-themes'

"fugitive 
"   git 的很多功能进行了封装, 我暂时不重度使用它
"   只是rangta配合airline显示当前的git分支状态
Plug 'tpope/vim-fugitive'

"CtrlSF 
"   全局文件片段搜索器, 配合ag使用
Plug 'dyng/ctrlsf.vim'

"multiple-cursors
"   多光标编辑, 可配合CtrlSF使用
"   我依旧有些使用上的疑问, 该插件的没有完整的防
"   误操作, 按键要生效就离手别搞出一些神奇的事情
"   建议仅在 normal, visual 模式下使用该插件
Plug 'terryma/vim-multiple-cursors'

"nerdcommenter
"   快速多行注释
Plug 'scrooloose/nerdcommenter'

"tagbar
"   提供文件概览信息
Plug 'majutsushi/tagbar'

"vim-snipmate 与 vim-snippets
"   代码片段工具
"   vim-snipmate 基于 vim script, 提供片段补全功能, 自定义片段功能
"   vim-snippets 一个代码片段库, 自身支持多种语言的常用片段
"   vim-addon-mw-utils 与 tlib_vim 都是 snipmate 的依赖
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
"ale
"   语法检测框架, 实际的校验器, 需要自己配置到系统, 例: javac
Plug 'w0rp/ale'

"devicons
"   vim 图标插件, 支持多个vim插件, 如:NERDTree. 该插件
"   应是最后一个加载的UI插件
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
"跟随vim启动 NerdTree
let g:nerdtree_tabs_open_on_console_startup = 1
"当仅剩 NerdTree 窗口时, 自动关闭(最常见的情形就是没有活动的buffer时, 自动关闭)
let g:nerdtree_tabs_autoclose = 1
"=== 快捷键
"快速开关 NERDTree
nmap <Leader>1 :NERDTreeTabsToggle<CR>


"************************ vim-devicons
"启用文件夹图标, default = , 你可以使用📂(这里default如果显示为问号之类的,
"因为没有对应的 Hack Nerd Font 字体<http://nerdfonts.com/>)
"手动没法输入的符号, 可以使用nr2char()实现输入, 参数是十进制的,
"nerdfonts.com 中的字体码是十六进制的, 需要转换一下
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = nr2char(58878) 
"let g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = nr2char(58878) 


"************************ nerdtree-git-plugin
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

"************************ air-line
"顶部tabline显示(tabline是管理vim buffer的, 比 vim tab 高效)
let g:airline#extensions#tabline#enabled = 1
"airline 当前主题, 默认dark, 如需切换主体, 请先启用插件vim-airline-themes
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


"************************ctrlsf.vim
"=== 快捷键
"手动输入内容进行搜索
nmap <Leader>f :CtrlSF<Space>
"开关搜索窗
nmap <Leader>F :CtrlSFToggle<CR>
vmap <Leader>f <Plug>CtrlSFVwordExec


"************************vim-multiple-cursors
"使用自定义快捷键. 前四个功能两两一组的区别貌似不大
let g:multi_cursor_use_default_mapping = 0
"=== 快捷键
let g:multi_cursor_start_word_key      = '’'            "alt + shift + ]
let g:multi_cursor_select_all_word_key = 'Å'            "alt + shift + a
let g:multi_cursor_start_key           = '—'            "alt + shift + -
let g:multi_cursor_select_all_key      = '±'            "alt + shift + +
"---
let g:multi_cursor_next_key            = '’'            "alt + shift + ]
let g:multi_cursor_prev_key            = '”'            "alt + shift + [
let g:multi_cursor_skip_key            = '»'            "alt + shift + \
let g:multi_cursor_quit_key            = '<Esc>'        "esc


"************************ nerd commenter
"=== 快捷键
" alt + / 快速注解与取消注解
nmap ÷ <Leader>c<Space>
vmap ÷ <Leader>c<Space>

"************************ tagbar
"=== 快捷键
"快速开关文件概览窗, 仅支持部分文件
nmap <Leader>3 :TagbarToggle<CR>


"************************ vim-snipmate
"--------------------------------------------------------------
"因为插件管理是基于git的, 所以我们假定
"~/.vim/plugged/vim-snippets/snippets 文件夹在使
"用vim中, 随时会被更新. 解决方案是将snippets文件放
"在~/.vim/after/snippets下, 命名方式如下:
"
"   _.snippets              全局, 不区分文件类型
"   java_gavin.snippets     扩展java文件的代码块, '_'后面
"                           的'gavin'可以替换成你喜欢的任何名字
"--------------------------------------------------------------
"使用vim的作者的名字
let g:snips_author = 'Vimer'
"开启可选项
let g:snipMate = {}
"---文件类型别名, e.g. key:md value:md, markdown
let g:snipMate.scope_aliases = {}
"---使用新版解析器
let g:snipMate.snippet_version = 1
"---若两个代码片段重名, 使用后加载的那个
"---(这里保证了.vim/after/snippets下的片段为最终值)
let g:snipMate.override = 1
"---显示代码片段描述信息
let g:snipMate.description_in_completion = 1


"************************ ale
" 总是显示语法报错标记栏
" let g:ale_sign_column_always = 1
" 使用 javac 对java 进行语法检测时, 使用的javac 命令所在路径
let g:ale_java_javac_executable = 'javac'

