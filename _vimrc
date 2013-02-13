" syncdot's _vimrc

" This must be first, because it changes other options as side effect
set nocompatible 

" Pathogen plugin helper 
execute pathogen#infect()
filetype plugin indent on

" Change leader key from default \ to (something)
let mapleader="," 

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Select all keyboard mapping
nmap <leader>sa gg<S-v><S-g>

" Visual Settings
colorscheme twilight2
"colorscheme railscasts
set guifont=DejaVu\ Sans\ Mono:h10
set guioptions-=T "Hide top toolbar in GVIM
set guioptions+=b "Horizontal scrollbar enabled
syntax on

set hidden
set laststatus=2
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set ruler
set nowrap        " don't wrap lines
set whichwrap+=h,l "cursor h,l set to beginning/end of each line
set tabstop=2     " a tab is four spaces
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftwidth=2  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set novb                 " don't flash
set noerrorbells         " don't beep
set expandtab

" Don't create backup file or swapfile
set nobackup
set noswapfile

" Highlight whitespaces
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Highlight cursorline
set cursorline

" Set pastemode for pasting large amounts of text into Vim w/o auto indenting
set pastetoggle=<F2>

" Set : to ;
nnoremap ; :

nnoremap j gj
nnoremap k gk

" Clear search buffer by pressing ,/
nmap <silent> ,/ :nohlsearch<CR>

" Automatically append closing characters
  " Curly braces {}
  inoremap {      {}<Left>
  inoremap {<CR>  {<CR>}<Esc>O
  inoremap {{     {
  inoremap {}     {}

  " Brackets ()
  inoremap (      ()<Left>
  inoremap (<CR>  (<CR>)<Esc>O
  inoremap ((     (
  inoremap ()     ()

  " Square brackets []
  inoremap [      []<Left>
  inoremap [<CR>  [<CR>]<Esc>O
  inoremap [[     [
  inoremap []     []

  " Double quotes "" 
  inoremap "      ""<Left>
  inoremap "<CR>  "<CR>"<Esc>O
  inoremap ""     "

  " Single quote ''
  inoremap '      ''<Left>
  inoremap '<CR>  '<CR>'<Esc>O
  inoremap ''     '

  " Embedded Ruby <% 
  inoremap <%     <%%><Left><Left>


" ----------PLUGIN SETTINGS----------
" autocmd VimEnter * NERDTree  " Load NERDTree when Vim starts
map <Leader>nt :NERDTree %:p:h<CR>
map <C-n> :NERDTreeToggle<CR>
" mappings for FuzzyFinder
nmap <Leader>f :FufFile<CR>
nmap <Leader>b :FufBuffer<CR>
" mappings for CtrlP
nmap <Leader>c :CtrlP<CR>

" ----------EASIER SPLIT NAVIGATION----------
" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ----------RESTORE WINDOW SIZE AND POSITION----------
" To enable the saving and restoring of screen positions.
let g:screen_size_restore_pos = 1

" To save and restore screen for each Vim instance.
" This is useful if you routinely run more than one Vim instance.
" For all Vim to use the same settings, change this to 0.
let g:screen_size_by_vim_instance = 1

if has("gui_running")
  function! ScreenFilename()
    if has('amiga')
      return "s:.vimsize"
    elseif has('win32')
      return $HOME.'\_vimsize'
    else
      return $HOME.'/.vimsize'
    endif
  endfunction

  function! ScreenRestore()
    " Restore window size (columns and lines) and position
    " from values stored in vimsize file.
    " Must set font first so columns and lines are based on font size.
    let f = ScreenFilename()
    if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      for line in readfile(f)
        let sizepos = split(line)
        if len(sizepos) == 5 && sizepos[0] == vim_instance
          silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
          silent! execute "winpos ".sizepos[3]." ".sizepos[4]
          return
        endif
      endfor
    endif
  endfunction

  function! ScreenSave()
    " Save window size and position.
    if has("gui_running") && g:screen_size_restore_pos
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
            \ (getwinposx()<0?0:getwinposx()) . ' ' .
            \ (getwinposy()<0?0:getwinposy())
      let f = ScreenFilename()
      if filereadable(f)
        let lines = readfile(f)
        call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
        call add(lines, data)
      else
        let lines = [data]
      endif
      call writefile(lines, f)
    endif
  endfunction

  if !exists('g:screen_size_restore_pos')
    let g:screen_size_restore_pos = 1
  endif
  if !exists('g:screen_size_by_vim_instance')
    let g:screen_size_by_vim_instance = 1
  endif
  autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
  autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
endif
