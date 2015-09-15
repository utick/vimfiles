let @b="0fBi:fTld$a,j0fD"
let @d="0fDi:fEld$a,j0fD"

noremap <A-b> @b
noremap <A-d> @d
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
let yankring_min_element_length=4
" NeoComplCache{
    let g:NeoComplCache_EnableAtStartup=1   
    let g:NeoComplCache_DisableAutoComplete=1
"}
"ĞŞ¸ÄvimrcÖ®ºóÁ¢¼´ÉúĞ§
autocmd BufWritePost vimrc so %
"mapleader
let mapleader=","
"¹Ø±Õswapfile"
set noswapfile
set cpt=.,w,b,u
set completeopt=menu,longest
"acp×Ô¶¯²¹È«
""let g:acp_enableAtStartup = 0
""let g:acp_behaviorKeywordCommand = "\<C-n>"
""let g:acp_behaviorKeywordLength=3
"×Ö·û±àÂë
set fileencodings=ucs-bom,utf-8,cp936,gbk
"ÅĞ¶Ï²Ù×÷ÏµÍ³ÀàĞÍ
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
  "½â¾öconsleÊä³öÂÒÂë   
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
"ALTÉÏÏÂ×óÓÒÒÆ¶¯¹â±ê
imap <A-h> <LEFT>
imap <A-j> <DOWN>
imap <A-k> <UP>
imap <A-l> <RIGHT>
"·Ö¸î´°¿Ú¶¨Î»
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"Éè¶¨windowsÏÂ gvim Æô¶¯Ê±×î´ó»¯
"autocmd GUIEnter * simalt ~x
"»ù±¾ÅäÖÃ
set wildmenu
"ÊäÈëÎÄ×ÖÊÇÒş²ØÊó±ê
set mousehide  
" Òş²Øµô²Ëµ¥ºÍ¹¤¾ßÌõ¡£
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
" Æô¶¯µÄÊ±ºò²»ÏÔÊ¾ÄÇ¸öÔ®ÖúË÷ÂíÀï¶ùÍ¯µÄÌáÊ¾
set shortmess=atI
" ¼ôÇĞ°å
set clipboard+=unnamed
"map <c-v> "+p
"ÉèÖÃÈ«Ñ¡¿ì½İ¼ü
map <C-a> ggVG
"¸´ÖÆ
vmap <C-c> "+y
"Õ³Ìù
inoremap <C-v> <ESC>"+pa
"ÉèÖÃ¿ìËÙ²»±£´æÍË³ö¿ì½İ¼ü
map <S-q><S-q> :q!<CR>:q!<CR>:q!<CR>
"Ìæ»»
"map <C-H> :L1,L2s/src/tar/g
"imap <C-H> <Esc><C-H>
" browsedirÉèÖÃ
set browsedir=buffer
" ÔØÈëÎÄ¼şÀàĞÍ²å¼ş
filetype plugin on
" ×Ô¶¯¸ñÊ½»¯ÉèÖÃ
filetype indent on
"SuperTab
let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="context"  
let g:SuperTabContextDefaultCompletionType="<c-n>"
" ´øÓĞÈçÏÂ·ûºÅµÄµ¥´Ê²»Òª±»»»ĞĞ·Ö¸î
set iskeyword+=_,$,@,%,#,-
" µ±buffer±»¶ªÆúÊ±Òş²Ø
set bufhidden=hide
" C++Í·ÎÄ¼şÊ¶±ğ
au BufEnter /usr/include/c++/* setf cpp
au BufEnter /usr/include/g++-3/* setf cpp
" GNU±ê×¼
"au BufEnter /usr/* call GnuIndent()
" ´°¿Ú×î´ó»¯
"autocmd GUIEnter * simalt ~x
" ¿ÉÒÔÔÚbufferµÄÈÎºÎµØ·½Ê¹ÓÃÊó±ê£¨ÀàËÆofficeÖĞÔÚ¹¤×÷ÇøË«»÷Êó±ê¶¨Î»£©
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" ÔÊĞíbackspaceºÍ¹â±ê¼ü¿çÔ½ĞĞ±ß½ç
set whichwrap+=<,>,h,l
" Ê¹»Ø¸ñ¼ü£¨backspace£©Õı³£´¦Àíindent, eol, startµÈ
set backspace=eol,start,indent
" ×Ô¶¯²¹È«À¨ºÅ£¬°üÀ¨´óÀ¨ºÅ
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i<CR><CR><UP><TAB>
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap < <><ESC>i
:inoremap > <c-r>=ClosePair('>')<CR>
:inoremap " ""<ESC>i
" ´ò¿ªÎÄ¼şÊ±£¬×ÜÊÇÌøµ½ÍË³öÖ®Ç°µÄ¹â±ê´¦
 autocmd BufReadPost *
			 \if line("'\"") > 0 && line("'\"") <= line("$") |
			 \  exe "normal! g`\"" |
			 \endif
if has("gui_running")
    set showtabline=1
    nmap tn :tabnew<CR>
" ÓÃÇ³É«¸ßÁÁµ±Ç°±à¼­ĞĞ
   autocmd InsertLeave * se nocul
   autocmd InsertEnter * se cul
"½â¾ö²Ëµ¥ÂÒÂë   
    source $VIMRUNTIME/delmenu.vim   
    source $VIMRUNTIME/menu.vim   
endif
" ±êÇ©Ò³Ö»ÏÔÊ¾ÎÄ¼şÃû
function! ShortTabLabel ()
    let bufnrlist = tabpagebuflist (v:lnum)
   let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
     let filename = fnamemodify (label, ':t')
    return filename
endfunction
"ÉèÖÃ= + - * Ç°ºó×Ô¶¯¿Õ¸ñ
"ÉèÖÃ,ºóÃæ×Ô¶¯Ìí¼Ó¿Õ¸ñ
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
"ÊµÏÖÀ¨ºÅµÄ×Ô¶¯Åä¶Ôºó·ÀÖ¹ÖØ¸´ÊäÈë£©£¬ÊÊÓÃpython
 function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
      return a:char
   endif
endf
"ÔöÇ¿Ä£Ê½ÖĞµÄÃüÁîĞĞ×Ô¶¯Íê³É²Ù×÷
set foldmethod=manual
"Éè¶¨ÕÛµş·½Ê½ÎªÊÖ¶¯
set helplang=cn
"ÉèÖÃ°ïÖúµÄÓïÑÔÎªÖĞÎÄ
set cin   
"ÊµÏÖC³ÌĞòµÄËõ½ø
set sw=4  
"Éè¼Æ(×Ô¶¯) Ëõ½øÊ¹ÓÃ4¸ö¿Õ¸ñ
set sta   
"²åÈë<tab>Ê±Ê¹ÓÃ'shiftwidth'
set backspace=2
"Ö¸Ã÷ÔÚ²åÈëÄ£Ê½ÏÂ¿ÉÒÔÊ¹ÓÃ<BS>É¾³ı¹â±êÇ°ÃæµÄ×Ö·û
set number
"ÏÔÊ¾ĞĞºÅ
filetype on
"¼ì²âÎÄ¼şµÄÀàĞÍ
set history=1000
""¼ÇÂ¼ÀúÊ·µÄĞĞÊı
" ÔÚËÑË÷µÄÊ±ºòºöÂÔ´óĞ¡Ğ´
set ignorecase
"±³¾°Ê¹ÓÃºÚÉ«
syntax on
"Óï·¨¸ßÁÁ¶ÈÏÔÊ¾
set autoindent
set smartindent
"ÉÏÃæÁ½ĞĞÔÚ½øĞĞ±àĞ´´úÂëÊ±£¬ÔÚ¸ñÊ½¶ÔÆğÉÏºÜÓĞÓÃ£»
"µÚÒ»ĞĞ£¬vimÊ¹ÓÃ×Ô¶¯¶ÔÆë£¬Ò²¾ÍÊÇ°Ñµ±Ç°ĞĞµÄ¶ÔÆğ¸ñÊ½Ó¦ÓÃµ½ÏÂÒ»ĞĞ£»
"µÚ¶şĞĞ£¬ÒÀ¾İÉÏÃæµÄ¶ÔÆğ¸ñÊ½£¬ÖÇÄÜµÄÑ¡Ôñ¶ÔÆğ·½Ê½£¬¶ÔÓÚÀàËÆCÓïÑÔ±àĞ´ÉÏºÜÓĞÓÃ
" ÔÚ±»·Ö¸îµÄ´°¿Ú¼äÏÔÊ¾¿Õ°×£¬±ãÓÚÔÄ¶Á
set fillchars=vert:\ ,stl:\ ,stlnc:\
"µÚÒ»ĞĞÉèÖÃtab¼üÎª4¸ö¿Õ¸ñ£¬µÚ¶şĞĞÉèÖÃµ±ĞĞÖ®¼ä½»´íÊ±Ê¹ÓÃ4¸ö¿Õ¸ñ
set expandtab
set tabstop=4
set smarttab
set shiftwidth=4
set showmatch
" ¸ßÁÁ×Ö·û£¬ÈÃÆä²»ÊÜ100ÁĞÏŞÖÆ
":highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
":match OverLength '\%101v.*'
" ×ÜÊÇÏÔÊ¾×´Ì¬ĞĞ
set laststatus=2
highlight StatusLine guifg=SlateBlue guibg=Yellow
"highlight StatusLine guifg=Black guibg=White
"highlight StatusLineNC guifg=Gray guibg=White
" ÎÒµÄ×´Ì¬ĞĞÏÔÊ¾µÄÄÚÈİ£¨°üÀ¨ÎÄ¼şÀàĞÍºÍ½âÂë£©
"set statusline=[%n]%<%f%y%h%m%r%=[%b\ 0x%B]\ Line\:%l\/%L\ Col\:%c%V\ %P
" Æ¥ÅäÀ¨ºÅ¸ßÁÁµÄÊ±¼ä£¨µ¥Î»ÊÇÊ®·ÖÖ®Ò»Ãë£©
set matchtime=3
" ÉèÖÃÃüÁîĞĞ¸ß¶ÈÎª2ĞĞ
set cmdheight=1
"ÔÚ±à¼­¹ı³ÌÖĞ£¬ÔÚÓÒÏÂ½ÇÏÔÊ¾¹â±êÎ»ÖÃµÄ×´Ì¬ĞĞ
set incsearch
set hlsearch
"²éÑ¯Ê±·Ç³£·½±ã£¬ÈçÒª²éÕÒbookµ¥´Ê£¬µ±ÊäÈëµ½/bÊ±£¬»á×Ô¶¯ÕÒµ½µÚÒ»
"¸öb¿ªÍ·µÄµ¥´Ê£¬µ±ÊäÈëµ½/boÊ±£¬»á×Ô¶¯ÕÒµ½µÚÒ»¸öbo¿ªÍ·µÄµ¥´Ê£¬ÒÀ
"´ÎÀàÍÆ£¬½øĞĞ²éÕÒÊ±£¬Ê¹ÓÃ´ËÉèÖÃ»á¿ìËÙÕÒµ½´ğ°¸£¬µ±ÄãÕÒÒªÆ¥ÅäµÄµ¥´Ê
"Ê±£¬±ğÍü¼Ç»Ø³µ¡£
" ÔöÇ¿¼ìË÷¹¦ÄÜ
"½«µ±Ç°µÄ¹¤³ÌµÄtagsµ¼Èë
set tags=./tags,./../tags,./**/tags
"Alt×éºÏ¼ü²»Ó³Éäµ½²Ëµ¥ÉÏ
set winaltkeys=no
 
"½ûÖ¹×Ô¶¯¸Ä±äµ±Ç°Vim´°¿ÚµÄ´óĞ¡
let Tlist_Inc_Winwidth=0
"°Ñ·½·¨ÁĞ±í·ÅÔÚÆÁÄ»µÄÓÒ²à
let Tlist_Use_Right_Window=1
"ÈÃµ±Ç°²»±»±à¼­µÄÎÄ¼şµÄ·½·¨ÁĞ±í×Ô¶¯ÕÛµşÆğÀ´£¬ ÕâÑù¿ÉÒÔ½ÚÔ¼Ò»Ğ©ÆÁÄ»¿Õ¼ä
let Tlist_File_Fold_Auto_Close=1
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
"Ó³ÉäF4Îª¹¦ÄÜ¼üµ÷³ötagesä¯ÀÀÆ÷
"Ó³ÉäF3Îª¹¦ÄÜ¼üµ÷³öwinmanagerµÄÎÄ¼şä¯ÀÀÆ÷
let g:winManagerWindowLayout='FileExplorer|TagList' "ÄãÒªÊÇÏ²»¶ÕâÖÖ²¼¾Ö¿ÉÒÔ×¢ÊÍµôÕâÒ»ĞĞ
map <F4> :TlistToggle<cr>
map <F3> :NERDTreeToggle<cr>
map <F10> :call Do_CsTag()<CR>" °´F10½¨Á¢tagsË÷Òı
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
"¶¨ÒåÔ´´úÂë¸ñÊ½»¯
map <F11> :call FormartSrc()<CR><CR>
"¶¨ÒåFormartSrc()
function! FormartSrc()
exec "w"
"C³ÌĞò,Perl³ÌĞò,Python³ÌĞò
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
"Java³ÌĞò
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
"½áÊø¶¨ÒåFormartSrc
 
"ÉèÖÃtabµÄ¿ì½İ¼ü
"Shift+tÎªĞÂ½¨Ò»¸ö±êÇ©£¬°´Á½´ÎShirt+tÎªÌø×ª±êÇ©
map <S-t> :tabnew .<CR>
map <S-t><S-t> <ESC>:tabnext<CR>
 
"ÉèÖÃ½¨Á¢ĞÂĞĞµ«ÊÇ²»²åÈë
"map <S-o> o<ESC><CR>
"ÉèÖÃ¿ìËÙ×¢ÊÍ¼ü
"ÏêÏ¸×¢ÊÍ
"F12ÊÇÔÚ¸ÃĞĞºó±ßÌí¼Ó×¢ÊÍ£¬Shift+F12Îª×¢ÊÍµô¸ÃĞĞ£¬Á½´ÎShift+F12ÊÇÈ¥µô¸ÄĞĞµÄ×¢ÊÍ,È»ºó½«¹â±êÖÃÓÚÏÂÒ»ĞĞ
nnoremap <silent> <S-F9> :A<CR>
map <S-F12> <ESC>I//<ESC><CR>
map! <S-F12> <ESC>I//<ESC><CR>
map <S-F12><S-F12> 02x<ESC><CR>
map! <S-F12><S-F12> <ESC>02x<ESC><CR>
map <F12> <ESC>$a//
map! <F12> <ESC>$a//

"ÉèÖÃ±àÒë¿ì½İ¼ü
"F5Îªmake£¬Á½´ÎF5Îªmake clean
"F6Îªquickfix£¬²é¿´ÏêÏ¸ĞÅÏ¢, Á½´ÎF6¹Ø±ÕÏêÏ¸ĞÅÏ¢
"F7ÎªÏÂÒ»¸ö½á¹û£¬Á½´ÎF7ÎªÉÏÒ»¸ö½á¹û
"F8Îª±àÒëºÍÔËĞĞµ¥¸ö³ÌĞò¡¢Á½´ÎF8Îªµ÷ÊÔ
""map <F5> :Do_make<CR>
""map <F5><F5> :make clean<CR>
map <F6> :cw<CR>
map <F6><F6> :ccl<CR>
map <F7> :cn<CR>
map <F7><F7> :cp<CR>
map <F8> :call Compile()<CR>:call Run()<CR>
map <F8><F8> :call Run()<CR>
map <leader>cd :cd %:p:h<cr>
""autocmd FileType cpp map <F8> <Esc>:w!<CR>:!compile_cpp.bat %<CR>//Õâ¸öµØ·´ÊÇÖµµÃ×¢ÒâµÄ Òª¸ù¾İ×Ô¼ºµÄ»úÆ÷Çé¿ö¸ü¸Ä
"¶¨ÒåCompileº¯Êı£¬ÓÃÀ´¶Ô²»ÓÃÍâ½Ó¿âµÄĞ¡³ÌĞò½øĞĞ±àÒëºÍÔËĞĞ,×Ô¼º¿ÉÒÔ¸ù¾İÎÄ¼şÃûÀ©Õ¹»òÊµ¼ÊÇé¿öĞŞ¸Ä²ÎÊı
set autochdir
"±àÒë
function! Compile()
exec "w"
"C³ÌĞò   
if &filetype == "c"
exec "!gcc -Wl,-enable-auto-import % -g -o %<.exe"
"c++³ÌĞò
elseif &filetype == "cpp"
exec "!g++ -Wl,-enable-auto-import % -g -o %<.exe"
"java³ÌĞò
elseif &filetype == 'java'
exec "!javac %"
"python³ÌĞò
elseif &filetype =='python'
exec "!python %"
endif
endfunction

"¶¨ÒåRunº¯Êı
function! Run()
exec "w"
"C³ÌĞò
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
"½áÊø¶¨ÒåRun

"¶¨ÒåDebugº¯Êı£¬ÓÃÀ´µ÷ÊÔĞ¡³ÌĞò
function! Debug()
exec "w"
"C³ÌĞò
if &filetype == 'c'
exec "!rm %<"
exec "!gcc % -g -o %<"
exec "!gdb %<"
elseif &filetype == 'cpp'
exec "!rm %<"
exec "!g++ % -g -o %<"
exec "!gdb %<"
"Java³ÌĞò
exec "!rm %<.class"
elseif &filetype == 'java'
exec "!javac %"
exec "!jdb %<"
endif
endfunction
"¶¨Òådubug½áÊø
 
"autocmd BufNewFile *.cc,*.sh,*.java exec ":call SetTitle()"
"ĞÂ½¨.cc,.java,.sh,
"×Ô¶¯½«shell½Å±¾ÉèÖÃÎª¿ÉÖ´ĞĞÈ¨ÏŞ
au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod a+x <afile> | endif | endif
if has("autocmd")
autocmd BufRead *.txt set tw=78
autocmd BufReadPost *
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\   exe "normal g'\"" |
\ endif
endif
" Ê¹ÓÃÉÏÏÂÀ´µ÷½Ú´°¿Ú´óĞ¡
nmap <silent> <UP> <C-W>+:let t:flwwinlayout = winrestcmd()<CR>
nmap <silent> <DOWN> <C-W>-:let t:flwwinlayout = winrestcmd()<CR>
" ÃüÁîÄ£Ê½ÏÂ·½±ãÒÆ¶¯¹â±ê
if (!has ("gui_win32"))
  cmap <C-A> <Home>
  cmap <C-E> <End>
endif
" ´ò¿ªÒ»¸öÁÙÊ±µÄ»º³åÇøËæ±ã¼Ç¶«Î÷
"nmap <Leader>s :Scratch<cr>
"javacomplete
""autocmd Filetype java setlocal omnifunc=javacomplete#Complete
""autocmd Filetype java setlocal completefunc=javacomplete#CompleteParamsInfo 
""inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P>
""inoremap <buffer> <C-S-Space> <C-X><C-U><C-P>
"autocmd Filetype java,javascript,jsp,cpp,c inoremap <buffer>  .  .<C-X><C-O><C-P>
"vim-markdown
let g:vim_markdown_folding_disabled=1
