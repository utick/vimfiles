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
"Plugin 'kien/ctrlp.vim'
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
"Plugin 'tpope/vim-fugitive'
"Plugin 'matrix.vim'
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
set ruler
set number
set hidden
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
"let g:airline_left_sep='>'
"let g:airline_right_sep='<'
" YankRing
map <leader>p :YRShow<CR>
let g:yankring_enabled=1
let g:yankring_min_element_length=4
" NeoComplCache{
let g:NeoComplCache_EnableAtStartup=1   
let g:NeoComplCache_DisableAutoComplete=1
"}
"�޸�vimrc֮��������Ч
autocmd BufWritePost vimrc so %
"mapleader
let mapleader=","
"�ر�swapfile"
set noswapfile
set cpt=.,w,b,u
set completeopt=menu,longest
"acp�Զ���ȫ
""let g:acp_enableAtStartup = 0
""let g:acp_behaviorKeywordCommand = "\<C-n>"
""let g:acp_behaviorKeywordLength=3
"�ַ�����
set fileencodings=ucs-bom,utf-8,cp936,gbk
"�жϲ���ϵͳ����
if (has("win32")||has("win64"))
    let $VIMFILES = $HOME.'/vimfiles'
    let $MYVIMRC = $VIMFILES.'/vimrc'
    let g:iswindows=1
    set fileencoding=gbk
"    try
        "http://www.fontriver.com/f/bitstream_vera_sans_mono.zip
"        set guifont=Bitstream_Vera_Sans_Mono:h11:cANSI
        "http://nchc.dl.sourceforge.net/project/yaheimono/yahei_mono.ttf
"        set gfw=Yahei_Mono:h11:cGB2312
"    catch
"        set guifont=Consolas:h11
"    endtry
    "���consle�������   
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
"ALT���������ƶ����
imap <A-h> <LEFT>
imap <A-j> <DOWN>
imap <A-k> <UP>
imap <A-l> <RIGHT>
"�ָ�ڶ�λ
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"�趨windows�� gvim ����ʱ���
"autocmd GUIEnter * simalt ~x
"��������
set wildmenu
"�����������������
set mousehide  
" ���ص��˵��͹�������
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
" ������ʱ����ʾ�Ǹ�Ԯ���������ͯ����ʾ
set shortmess=atI
" ���а�
set clipboard+=unnamed
"map <c-v> "+p
"����ȫѡ��ݼ�
map <C-a> ggVG
"����
vmap <C-c> "+y
"ճ��
inoremap <C-v> <ESC>"+pa
"���ÿ��ٲ������˳���ݼ�
map <S-q><S-q> :q!<CR>:q!<CR>:q!<CR>
"�滻
"map <C-H> :L1,L2s/src/tar/g
"imap <C-H> <Esc><C-H>
" browsedir����
set browsedir=buffer
" �����ļ����Ͳ��
filetype plugin on
" �Զ���ʽ������
filetype indent on
"SuperTab
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="context"  
let g:SuperTabContextDefaultCompletionType="<c-n>"
" �������·��ŵĵ��ʲ�Ҫ�����зָ�
set iskeyword+=_,$,@,%,#,-
" ��buffer������ʱ����
set bufhidden=hide
" C++ͷ�ļ�ʶ��
au BufEnter /usr/include/c++/* setf cpp
au BufEnter /usr/include/g++-3/* setf cpp
" GNU��׼
"au BufEnter /usr/* call GnuIndent()
" �������
"autocmd GUIEnter * simalt ~x
" ������buffer���κεط�ʹ����꣨����office���ڹ�����˫����궨λ��
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" ����backspace�͹�����Խ�б߽�
set whichwrap+=<,>,h,l
" ʹ�ظ����backspace����������indent, eol, start��
set backspace=eol,start,indent
" �Զ���ȫ���ţ�����������
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i<CR><CR><UP><TAB>
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap < <><ESC>i
:inoremap > <c-r>=ClosePair('>')<CR>
:inoremap " ""<ESC>i
" ���ļ�ʱ�����������˳�֮ǰ�Ĺ�괦
autocmd BufReadPost *
            \if line("'\"") > 0 && line("'\"") <= line("$") |
            \  exe "normal! g`\"" |
            \endif
if has("gui_running")
    set showtabline=1
    nmap tn :tabnew<CR>
    " ��ǳɫ������ǰ�༭��
    autocmd InsertLeave * se nocul
    autocmd InsertEnter * se cul
    "����˵�����   
    source $VIMRUNTIME/delmenu.vim   
    source $VIMRUNTIME/menu.vim   
endif
" ��ǩҳֻ��ʾ�ļ���
function! ShortTabLabel ()
    let bufnrlist = tabpagebuflist (v:lnum)
    let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
    let filename = fnamemodify (label, ':t')
    return filename
endfunction
"����= + - * ǰ���Զ��ո�
"����,�����Զ���ӿո�
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
"ʵ�����ŵ��Զ���Ժ��ֹ�ظ����룩������python
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf
"��ǿģʽ�е��������Զ���ɲ���
set foldmethod=manual
"�趨�۵���ʽΪ�ֶ�
set helplang=cn
"���ð���������Ϊ����
set cin   
"ʵ��C���������
set sw=4  
"���(�Զ�) ����ʹ��4���ո�
set sta   
"����<tab>ʱʹ��'shiftwidth'
set backspace=2
"ָ���ڲ���ģʽ�¿���ʹ��<BS>ɾ�����ǰ����ַ�
set number
"��ʾ�к�
filetype on
"����ļ�������
set history=1000
""��¼��ʷ������
" ��������ʱ����Դ�Сд
set ignorecase
"����ʹ�ú�ɫ
syntax on
"�﷨��������ʾ
set autoindent
set smartindent
"���������ڽ��б�д����ʱ���ڸ�ʽ�����Ϻ����ã�
"��һ�У�vimʹ���Զ����룬Ҳ���ǰѵ�ǰ�еĶ����ʽӦ�õ���һ�У�
"�ڶ��У���������Ķ����ʽ�����ܵ�ѡ�����ʽ����������C���Ա�д�Ϻ�����
" �ڱ��ָ�Ĵ��ڼ���ʾ�հף������Ķ�
set fillchars=vert:\ ,stl:\ ,stlnc:\
"��һ������tab��Ϊ4���ո񣬵ڶ������õ���֮�佻��ʱʹ��4���ո�
set expandtab
set tabstop=4
set smarttab
set shiftwidth=4
set showmatch
" �����ַ������䲻��100������
":highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
":match OverLength '\%101v.*'
" ������ʾ״̬��
set laststatus=2
highlight StatusLine guifg=SlateBlue guibg=Yellow
"highlight StatusLine guifg=Black guibg=White
"highlight StatusLineNC guifg=Gray guibg=White
" �ҵ�״̬����ʾ�����ݣ������ļ����ͺͽ��룩
"set statusline=[%n]%<%f%y%h%m%r%=[%b\ 0x%B]\ Line\:%l\/%L\ Col\:%c%V\ %P
" ƥ�����Ÿ�����ʱ�䣨��λ��ʮ��֮һ�룩
set matchtime=3
" ���������и߶�Ϊ2��
set cmdheight=1
"�ڱ༭�����У������½���ʾ���λ�õ�״̬��
set incsearch
set hlsearch
"��ѯʱ�ǳ����㣬��Ҫ����book���ʣ������뵽/bʱ�����Զ��ҵ���һ
"��b��ͷ�ĵ��ʣ������뵽/boʱ�����Զ��ҵ���һ��bo��ͷ�ĵ��ʣ���
"�����ƣ����в���ʱ��ʹ�ô����û�����ҵ��𰸣�������Ҫƥ��ĵ���
"ʱ�������ǻس���
" ��ǿ��������
"����ǰ�Ĺ��̵�tags����
set tags=./tags,./../tags,./**/tags
"Alt��ϼ���ӳ�䵽�˵���
set winaltkeys=no

"��ֹ�Զ��ı䵱ǰVim���ڵĴ�С
let Tlist_Inc_Winwidth=0
"�ѷ����б������Ļ���Ҳ�
let Tlist_Use_Right_Window=1
"�õ�ǰ�����༭���ļ��ķ����б��Զ��۵������� �������Խ�ԼһЩ��Ļ�ռ�
let Tlist_File_Fold_Auto_Close=1
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
"ӳ��F4Ϊ���ܼ�����tages�����
"ӳ��F3Ϊ���ܼ�����winmanager���ļ������
let g:winManagerWindowLayout='FileExplorer|TagList' "��Ҫ��ϲ�����ֲ��ֿ���ע�͵���һ��
map <F4> :TlistToggle<cr>
map <F3> :NERDTreeToggle<cr>
"����Դ�����ʽ��
map <F11> :call FormartSrc()<CR><CR>
"����FormartSrc()
function! FormartSrc()
    exec "w"
    "C����,Perl����,Python����
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
        "Java����
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
"��������FormartSrc

"����tab�Ŀ�ݼ�
"Shift+tΪ�½�һ����ǩ��������Shirt+tΪ��ת��ǩ
map <S-t> :tabnew .<CR>
map <S-t><S-t> <ESC>:tabnext<CR>

"���ý������е��ǲ�����
"map <S-o> o<ESC><CR>
"���ÿ���ע�ͼ�
"��ϸע��
"F12���ڸ��к�����ע�ͣ�Shift+F12Ϊע�͵����У�����Shift+F12��ȥ�����е�ע��,Ȼ�󽫹��������һ��
nnoremap <silent> <S-F9> :A<CR>
map <S-F12> <ESC>I//<ESC><CR>
map! <S-F12> <ESC>I//<ESC><CR>
map <S-F12><S-F12> 02x<ESC><CR>
map! <S-F12><S-F12> <ESC>02x<ESC><CR>
map <F12> <ESC>$a//
map! <F12> <ESC>$a//

"���ñ����ݼ�
"F5Ϊmake������F5Ϊmake clean
"F6Ϊquickfix���鿴��ϸ��Ϣ, ����F6�ر���ϸ��Ϣ
"F7Ϊ��һ�����������F7Ϊ��һ�����
"F8Ϊ��������е�����������F8Ϊ����
""map <F5> :Do_make<CR>
""map <F5><F5> :make clean<CR>
map <F6> :cw<CR>
map <F6><F6> :ccl<CR>
map <F7> :cn<CR>
map <F7><F7> :cp<CR>
map <F8> :call Compile()<CR>:call Run()<CR>
noremap <A-r> :call Compile()<CR>:call Run()<CR>
map <F8><F8> :call Run()<CR>
map <leader>cd :cd %:p:h<cr>
""autocmd FileType cpp map <F8> <Esc>:w!<CR>:!compile_cpp.bat %<CR>//����ط���ֵ��ע��� Ҫ�����Լ��Ļ����������
"����Compile�����������Բ�����ӿ��С������б��������,�Լ����Ը����ļ�����չ��ʵ������޸Ĳ���
set autochdir
"����
function! Compile()
    exec "w"
    "C����   
    if &filetype == "c"
        exec "!gcc -Wl,-enable-auto-import % -g -o %<.exe"
        "c++����
    elseif &filetype == "cpp"
        exec "!g++ -Wl,-enable-auto-import % -g -o %<.exe"
        "java����
    elseif &filetype == 'java'
        exec "!javac %"
        "python����
    elseif &filetype =='python'
        "exec "!python %"
    endif
endfunction

"����Run����
function! Run()
    exec "w"
    "C����
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
    if &filetype =='sh'
        exec "!bash %"
    endif
endfunction
"��������Run

"����Debug��������������С����
function! Debug()
    exec "w"
    "C����
    if &filetype == 'c'
        exec "!rm %<"
        exec "!gcc % -g -o %<"
        exec "!gdb %<"
    elseif &filetype == 'cpp'
        exec "!rm %<"
        exec "!g++ % -g -o %<"
        exec "!gdb %<"
        "Java����
        exec "!rm %<.class"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!jdb %<"
    endif
endfunction
"����dubug����

if has("autocmd")
    autocmd BufRead *.txt set tw=78
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                \   exe "normal g'\"" |
                \ endif
endif
" ʹ�����������ڴ��ڴ�С
nmap <silent> <UP> <C-W>+:let t:flwwinlayout = winrestcmd()<CR>
nmap <silent> <DOWN> <C-W>-:let t:flwwinlayout = winrestcmd()<CR>
" ����ģʽ�·����ƶ����
if (!has ("gui_win32"))
    cmap <C-A> <Home>
    cmap <C-E> <End>
endif
" ��һ����ʱ�Ļ��������Ƕ���
"nmap <Leader>s :Scratch<cr>
"javacomplete
""autocmd Filetype java setlocal omnifunc=javacomplete#Complete
""autocmd Filetype java setlocal completefunc=javacomplete#CompleteParamsInfo 
""inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>
""inoremap <buffer> <C-S-Space> <C-X><C-U><C-P>
"autocmd Filetype java,javascript,jsp,cpp,c inoremap <buffer>  .  .<C-X><C-O><C-P>
"vim-markdown
let g:vim_markdown_folding_disabled=1
"Exchange CapsLock&Ctrl"
""Windows Registry Editor Version 5.00
""[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout]
"""Scancode Map"=hex:00,00,00,00,00,00,00,00,02,00,00,00,1d,00,3a,00,00,00,00,00
