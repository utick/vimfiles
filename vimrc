" Environment {

    " Identify platform {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return  (has('win16') || has('win32') || has('win64'))
        endfunction
    " }

    " Basics {
        set nocompatible        " Must be first line
        if !WINDOWS()
            set shell=/bin/sh
        endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if WINDOWS()
          set runtimepath=$HOME/vimfiles,$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
        endif
    " }
    
    " Arrow Key Fix {
        " https://github.com/spf13/spf13-vim/issues/780
        if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
            inoremap <silent> <C-[>OC <RIGHT>
        endif
    " }

" }

" use vim by default
set nocompatible
filetype off

" vundle {{{
if WINDOWS()
    set rtp+=$HOME/vimfiles/bundle/Vundle.vim/
    call vundle#begin('$HOME/vimfiles/bundle/')
else
    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#begin()
endif
"}}}

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

" Editing
Plugin 'YankRing.vim'
Plugin 'matchit.zip'
Plugin 'repeat.vim'
Plugin 'surround.vim'
"Plugin 'vim-indent-object'
"Plugin 'terryma/vim-multiple-cursors'

" File explore
"Plugin 'The-NERD-Commenter'
Plugin 'The-NERD-tree'
" Both ctrlp and yankring use ctrl-p, the second one will work
Plugin 'kien/ctrlp.vim'
"Plugin 'majutsushi/tagbar'
Plugin 'bling/vim-airline'

" Auto complete
"Plugin 'mattn/emmet-vim'
Plugin 'ervandew/supertab'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'SirVer/ultisnips'
"Plugin 'guoqiao/django-snippets'

" Colorscheme
Plugin 'molokai'
"Plugin 'peaksea'

" Syntax Highlight
Plugin 'colorizer'

" Programming
"Plugin 'python.vim'
"Plugin 'pyflakes.vim'

" Others
Plugin 'tpope/vim-fugitive'
Plugin 'matrix.vim'
call vundle#end()

filetype plugin indent on     " required!
"
" Brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install (update) bundles
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.

syntax on
syntax enable
set so=10
set ruler
set number
set hidden
set nowrap
set autoread
set wildignore=*.o,*~,*.pyc
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git etc.
"set nowb
"set nobackup
set noswapfile

" No annoying sound on errors
set noerrorbells
set visualbell
set t_vb=
set tm=500

set ignorecase
set smartcase
let loaded_matchparen = 1 " disable math parenthiese

noremap ; :
noremap 0 ^
noremap <space> $
noremap Y y$

" Treat long lines as break lines (useful when moving around in them)
noremap j gj
noremap k gk

" Smart way to move between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

let mapleader = ","
nnoremap <leader>h :noh<CR>

nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

autocmd! bufwritepost vimrc source %
map <leader>pp :setlocal paste!<cr>
map <leader>ss :setlocal spell!<cr>

try
    colorscheme molokai
catch
    colorscheme desert
endtry
set background=dark

" plugin settings
" NerdTree {
        if isdirectory(expand("$HOME/vimfiles/bundle/The-NERD-tree/"))
            map <C-e> :NERDTreeToggle<CR>
            map <leader>nf :NERDTreeFind<CR>
            nmap <leader>nt :NERDTreeFind<CR>

            let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1
            let NERDTreeKeepTreeInNewTab=1
            let g:nerdtree_tabs_open_on_gui_startup=0
        endif
    " }
" TagBar {
        if isdirectory(expand("$HOME/vimfiles/bundle/tagbar/"))
            nnoremap <silent> <leader>tt :TagbarToggle<CR>
        endif
    "}
" Fugitive {
        if isdirectory(expand("$HOME/vimfiles/bundle/vim-fugitive/"))
            nnoremap <silent> <leader>gs :Gstatus<CR>
            nnoremap <silent> <leader>gd :Gdiff<CR>
            nnoremap <silent> <leader>gc :Gcommit<CR>
            nnoremap <silent> <leader>gb :Gblame<CR>
            nnoremap <silent> <leader>gl :Glog<CR>
            nnoremap <silent> <leader>gp :Git push<CR>
            nnoremap <silent> <leader>gr :Gread<CR>
            nnoremap <silent> <leader>gw :Gwrite<CR>
            nnoremap <silent> <leader>ge :Gedit<CR>
            " Mnemonic _i_nteractive
            nnoremap <silent> <leader>gi :Git add -p %<CR>
            nnoremap <silent> <leader>gg :SignifyToggle<CR>
        endif
    "}
" ctrlp {
        if isdirectory(expand("$HOME/vimfiles/bundle/ctrlp.vim/"))
            let g:ctrlp_working_path_mode = 'ra'
            nnoremap <silent> <D-t> :CtrlP<CR>
            nnoremap <silent> <D-r> :CtrlPMRU<CR>
            let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

            if executable('ag')
                let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
            elseif executable('ack-grep')
                let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
            elseif executable('ack')
                let s:ctrlp_fallback = 'ack %s --nocolor -f'
            " On Windows use "dir" as fallback command.
            elseif WINDOWS()
                let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
            else
                let s:ctrlp_fallback = 'find %s -type f'
            endif
            if exists("g:ctrlp_user_command")
                unlet g:ctrlp_user_command
            endif
            let g:ctrlp_user_command = {
                \ 'types': {
                    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': s:ctrlp_fallback
            \ }

            if isdirectory(expand("$HOME/vimfiles/bundle/ctrlp-funky/"))
                " CtrlP extensions
                let g:ctrlp_extensions = ['funky']

                "funky
                nnoremap <Leader>fu :CtrlPFunky<Cr>
            endif
        endif
    "}
" Airline
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1
" the separator used on the left side 
let g:airline_left_sep='>'
let g:airline_right_sep='<'
" YankRing
map <leader>p :YRShow<CR>
let yankring_min_element_length=4
" NeoComplCache{
    let g:NeoComplCache_EnableAtStartup=1   
    let g:NeoComplCache_DisableAutoComplete=1
"}
"修改vimrc之后立即生效
autocmd BufWritePost vimrc so %
"mapleader
let mapleader=","
"关闭swapfile"
set noswapfile
set cpt=.,w,b,u,t,i
set completeopt=menu,longest
"acp自动补全
""let g:acp_enableAtStartup = 0
""let g:acp_behaviorKeywordCommand = "\<C-n>"
""let g:acp_behaviorKeywordLength=3
"字符编码
set fileencodings=ucs-bom,utf-8,cp936,gbk
"判断操作系统类型
if (has("win32")||has("win64"))
  let $VIMFILES = $HOME.'/vimfiles'
  let $MYVIMRC = $VIMFILES.'/vimrc'
  let g:iswindows=1
  set fileencoding=gbk
  try
    "http://www.fontriver.com/f/bitstream_vera_sans_mono.zip
    set guifont=Bitstream_Vera_Sans_Mono:h11:cANSI
    "http://nchc.dl.sourceforge.net/project/yaheimono/yahei_mono.ttf
    set gfw=Yahei_Mono:h11:cGB2312
  catch
    set guifont=Consolas:h11
  endtry
  "解决consle输出乱码   
  language messages zh_CN.utf-8
  set encoding=utf-8
  set termencoding=gbk
else  
  let $VIMFILES = $HOME.'/.vim'
  let $MYVIMRC = $VIMFILES.'/vimrc'
  let g:iswindows=0
  set encoding=utf-8
  set fileencoding=utf-8   
  set guifont=Consolas:h11
  language messages zh_CN.utf-8
endif   
"ALT上下左右移动光标
imap <A-h> <LEFT>
imap <A-j> <DOWN>
imap <A-k> <UP>
imap <A-l> <RIGHT>
"分割窗口定位
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"设定windows下 gvim 启动时最大化
"autocmd GUIEnter * simalt ~x
"基本配置
set wildmenu
"输入文字是隐藏鼠标
set mousehide  
" 隐藏掉菜单和工具条。
set guioptions-=M
set guioptions-=T
set guioptions-=F
map <silent> <F1> :if &guioptions =~# 'T' <Bar>
         \set guioptions-=T <Bar>
          \set guioptions-=m <bar>
     \else <Bar>
     \set guioptions+=T <Bar>
     \set guioptions+=m <Bar>
     \endif<CR>
" 启动的时候不显示那个援助索马里儿童的提示
set shortmess=atI
" 剪切板
set clipboard+=unnamed
"map <c-v> "+p
"设置全选快捷键
map <C-a> ggVG
"复制
vmap <C-c> "+y
"粘贴
inoremap <C-v> <ESC>"+pa
"设置快速不保存退出快捷键
map <S-q><S-q> :q!<CR>:q!<CR>:q!<CR>
"替换
"map <C-H> :L1,L2s/src/tar/g
"imap <C-H> <Esc><C-H>
" browsedir设置
set browsedir=buffer
" 载入文件类型插件
filetype plugin on
" 自动格式化设置
filetype indent on
"SuperTab
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="context"  
let g:SuperTabContextDefaultCompletionType="<c-n>"
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 当buffer被丢弃时隐藏
set bufhidden=hide
" C++头文件识别
au BufEnter /usr/include/c++/* setf cpp
au BufEnter /usr/include/g++-3/* setf cpp
" GNU标准
"au BufEnter /usr/* call GnuIndent()
" 窗口最大化
"autocmd GUIEnter * simalt ~x
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=eol,start,indent
" 自动补全括号，包括大括号
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i<CR><CR><UP><TAB>
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap < <><ESC>i
:inoremap > <c-r>=ClosePair('>')<CR>
:inoremap " ""<ESC>i
" 打开文件时，总是跳到退出之前的光标处
 autocmd BufReadPost *
			 \if line("'\"") > 0 && line("'\"") <= line("$") |
			 \  exe "normal! g`\"" |
			 \endif
if has("gui_running")
    set showtabline=1
    nmap tn :tabnew<CR>
" 用浅色高亮当前编辑行
   autocmd InsertLeave * se nocul
   autocmd InsertEnter * se cul
"解决菜单乱码   
    source $VIMRUNTIME/delmenu.vim   
    source $VIMRUNTIME/menu.vim   
endif
" 标签页只显示文件名
function! ShortTabLabel ()
    let bufnrlist = tabpagebuflist (v:lnum)
   let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
     let filename = fnamemodify (label, ':t')
    return filename
endfunction
"设置= + - * 前后自动空格
"设置,后面自动添加空格
au FileType python inoremap <buffer>= <c-r>=EqualSign('=')<CR>
au FileType python inoremap <buffer>+ <c-r>=EqualSign('+')<CR>
au FileType python inoremap <buffer>- <c-r>=EqualSign('-')<CR>
au FileType python inoremap <buffer>* <c-r>=EqualSign('*')<CR>
au FileType python inoremap <buffer>/ <c-r>=EqualSign('/')<CR>
au FileType python inoremap <buffer>> <c-r>=EqualSign('>')<CR>
au FileType python inoremap <buffer>< <c-r>=EqualSign('<')<CR>
au FileType python inoremap <buffer>, ,<space>

func! EqualSign(char)
if getline('.')[col('.') - 3] =~ "[\*-=+\/]"
return "\<ESC>xa".a:char."\<SPACE>"
else
return "\<SPACE>".a:char."\<SPACE>\<ESC>a"
endif
endfunc
"实现括号的自动配对后防止重复输入），适用python
 function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
      return a:char
   endif
endf
"增强模式中的命令行自动完成操作
set foldmethod=manual
"设定折叠方式为手动
set helplang=cn
"设置帮助的语言为中文
set cin   
"实现C程序的缩进
set sw=4  
"设计(自动) 缩进使用4个空格
set sta   
"插入<tab>时使用'shiftwidth'
set backspace=2
"指明在插入模式下可以使用<BS>删除光标前面的字符
set number
"显示行号
filetype on
"检测文件的类型
set history=1000
""记录历史的行数
" 在搜索的时候忽略大小写
set ignorecase
"背景使用黑色
syntax on
"语法高亮度显示
set autoindent
set smartindent
"上面两行在进行编写代码时，在格式对起上很有用；
"第一行，vim使用自动对齐，也就是把当前行的对起格式应用到下一行；
"第二行，依据上面的对起格式，智能的选择对起方式，对于类似C语言编写上很有用
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
"第一行设置tab键为4个空格，第二行设置当行之间交错时使用4个空格
set expandtab
set tabstop=4
set smarttab
set shiftwidth=4
set showmatch
" 高亮字符，让其不受100列限制
":highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
":match OverLength '\%101v.*'
" 总是显示状态行
set laststatus=2
highlight StatusLine guifg=SlateBlue guibg=Yellow
"highlight StatusLine guifg=Black guibg=White
"highlight StatusLineNC guifg=Gray guibg=White
" 我的状态行显示的内容（包括文件类型和解码）
"set statusline=[%n]%<%f%y%h%m%r%=[%b\ 0x%B]\ Line\:%l\/%L\ Col\:%c%V\ %P
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=3
" 设置命令行高度为2行
set cmdheight=1
"在编辑过程中，在右下角显示光标位置的状态行
set incsearch
set hlsearch
"查询时非常方便，如要查找book单词，当输入到/b时，会自动找到第一
"个b开头的单词，当输入到/bo时，会自动找到第一个bo开头的单词，依
"次类推，进行查找时，使用此设置会快速找到答案，当你找要匹配的单词
"时，别忘记回车。
" 增强检索功能
"将当前的工程的tags导入
set tags=./tags,./../tags,./**/tags
"Alt组合键不映射到菜单上
set winaltkeys=no
 
"禁止自动改变当前Vim窗口的大小
let Tlist_Inc_Winwidth=0
"把方法列表放在屏幕的右侧
let Tlist_Use_Right_Window=1
"让当前不被编辑的文件的方法列表自动折叠起来， 这样可以节约一些屏幕空间
let Tlist_File_Fold_Auto_Close=1
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
"映射F4为功能键调出tages浏览器
"映射F3为功能键调出winmanager的文件浏览器
let g:winManagerWindowLayout='FileExplorer|TagList' "你要是喜欢这种布局可以注释掉这一行
map <F4> :TlistToggle<cr>
map <F3> :NERDTreeToggle<cr>
map <F10> :call Do_CsTag()<CR>" 按F10建立tags索引
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-@>i :cs find i <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
function! Do_CsTag()
    let dir = getcwd()
    if filereadable("tags")
        if(g:iswindows==1)
            let tagsdeleted=delete(dir."\\"."tags")
        else
            let tagsdeleted=delete("./"."tags")
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        if(g:iswindows==1)
            let csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted=delete("./"."cscope.files")
        endif
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if(g:iswindows==1)
            let csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let csoutdeleted=delete("./"."cscope.out")
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        silent! execute "!ctags -R --c-types=+p --fields=+S ."
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    endif
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
        else
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
        endif
        silent! execute "!cscope -b"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endfunction
"定义源代码格式化
map <F11> :call FormartSrc()<CR><CR>
"定义FormartSrc()
function! FormartSrc()
exec "w"
"C程序,Perl程序,Python程序
if &filetype == 'c'
exec "!astyle --style=gnu --suffix=none %"
exec "e! %"
elseif &filetype == 'cpp'
exec "!astyle --style=gnu --suffix=none %"
exec "e! %"
elseif &filetype == 'perl'
exec "!astyle --style=gnu --suffix=none %"
exec "e! %"
elseif &filetype == 'py'
exec "!astyle --style=gnu --suffix=none %"
exec "e! %"
"Java程序
elseif &filetype == 'java'
exec "!astyle --style=java --suffix=none %"
exec "e! %"
elseif &filetype == 'jsp'
exec "!astyle --style=gnu --suffix=none %"
exec "e! %"
elseif &filetype == 'xml'
exec "!astyle --style=gnu --suffix=none %"
exec "e! %"
elseif &filetype == 'html'
exec "!astyle --style=gnu --suffix=none %"
exec "e! %"
elseif &filetype == 'htm'
exec "!astyle --style=gnu --suffix=none %"
exec "e! %"
endif
endfunction
"结束定义FormartSrc
 
"设置tab的快捷键
"Shift+t为新建一个标签，按两次Shirt+t为跳转标签
map <S-t> :tabnew .<CR>
map <S-t><S-t> <ESC>:tabnext<CR>
 
"设置建立新行但是不插入
"map <S-o> o<ESC><CR>
"设置快速注释键
"详细注释
"F12是在该行后边添加注释，Shift+F12为注释掉该行，两次Shift+F12是去掉改行的注释,然后将光标置于下一行
nnoremap <silent> <S-F9> :A<CR>
map <S-F12> <ESC>I//<ESC><CR>
map! <S-F12> <ESC>I//<ESC><CR>
map <S-F12><S-F12> 02x<ESC><CR>
map! <S-F12><S-F12> <ESC>02x<ESC><CR>
map <F12> <ESC>$a//
map! <F12> <ESC>$a//

"设置编译快捷键
"F5为make，两次F5为make clean
"F6为quickfix，查看详细信息, 两次F6关闭详细信息
"F7为下一个结果，两次F7为上一个结果
"F8为编译和运行单个程序、两次F8为调试
""map <F5> :Do_make<CR>
""map <F5><F5> :make clean<CR>
map <F6> :cw<CR>
map <F6><F6> :ccl<CR>
map <F7> :cn<CR>
map <F7><F7> :cp<CR>
map <F8> :call Compile()<CR>:call Run()<CR>
map <F8><F8> :call Run()<CR>
map <leader>cd :cd %:p:h<cr>
""autocmd FileType cpp map <F8> <Esc>:w!<CR>:!compile_cpp.bat %<CR>//这个地反是值得注意的 要根据自己的机器情况更改
"定义Compile函数，用来对不用外接库的小程序进行编译和运行,自己可以根据文件名扩展或实际情况修改参数
set autochdir
"编译
function! Compile()
exec "w"
"C程序   
if &filetype == "c"
exec "!gcc -Wl,-enable-auto-import % -g -o %<.exe"
"c++程序
elseif &filetype == "cpp"
exec "!g++ -Wl,-enable-auto-import % -g -o %<.exe"
"java程序
elseif &filetype == 'java'
exec "!javac %"
"python程序
elseif &filetype =='python'
exec "!python %"
endif
endfunction

"定义Run函数
function! Run()
exec "w"
"C程序
if &filetype == 'c'
exec "!%<.exe"
endif
if &filetype == 'cpp'
exec "!%<.exe"
endif
if &filetype == 'java'
exec "!java %<"
endif
if &filetype =='python'
exec "!python %"
endif
endfunction
"结束定义Run

"定义Debug函数，用来调试小程序
function! Debug()
exec "w"
"C程序
if &filetype == 'c'
exec "!rm %<"
exec "!gcc % -g -o %<"
exec "!gdb %<"
elseif &filetype == 'cpp'
exec "!rm %<"
exec "!g++ % -g -o %<"
exec "!gdb %<"
"Java程序
exec "!rm %<.class"
elseif &filetype == 'java'
exec "!javac %"
exec "!jdb %<"
endif
endfunction
"定义dubug结束
 
"autocmd BufNewFile *.cc,*.sh,*.java exec ":call SetTitle()"
"新建.cc,.java,.sh,
"自动将shell脚本设置为可执行权限
au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod a+x <afile> | endif | endif
if has("autocmd")
autocmd BufRead *.txt set tw=78
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal g'\"" |
\ endif
endif
" 使用上下来调节窗口大小
nmap <silent> <UP> <C-W>+:let t:flwwinlayout = winrestcmd()<CR>
nmap <silent> <DOWN> <C-W>-:let t:flwwinlayout = winrestcmd()<CR>
" 命令模式下方便移动光标
if (!has ("gui_win32"))
  cmap <C-A> <Home>
  cmap <C-E> <End>
endif
" 打开一个临时的缓冲区随便记东西
"nmap <Leader>s :Scratch<cr>
"javacomplete
""autocmd Filetype java setlocal omnifunc=javacomplete#Complete
""autocmd Filetype java setlocal completefunc=javacomplete#CompleteParamsInfo 
""inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>
""inoremap <buffer> <C-S-Space> <C-X><C-U><C-P>
"autocmd Filetype java,javascript,jsp,cpp,c inoremap <buffer>  .  .<C-X><C-O><C-P>
"vim-markdown
let g:vim_markdown_folding_disabled=1
