if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set fileencodings=utf-8,cp936,gbk,utf-16le
set mouse=a
let g:powerline_pycmd="py3"
set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set showtabline=2 " Always display the tabline, even if there is only one tab

" Copies what was just pasted.
xnoremap p pgvy


com! -bar MAINTAIN call s:maintenance_tasks()

fu! s:update_all() abort
    PlugUpdate
    q
    PlugUpgrade
    q
    " This always exits.
endfu

fu! s:save_snapshot() abort
    if !isdirectory($HOME.'/.vim/tmp/snapshot')
        call mkdir($HOME.'/.vim/tmp/snapshot', 'p')
    endif
    exe 'PlugSnapshot! '.fnameescape($HOME.'/.vim/tmp/snapshot/'.strftime('%d-%m_%H:%M').'.vim')
    close
endfu

fu! s:snapshot_and_update() abort
    call s:save_snapshot()
    call s:update_all()
endfu

fu! s:install_missing() abort
    set ma
    PlugInstall
    set noma
    q
endfu

fu! s:check_installed(plugname) abort
    let plugname=a:plugname
    if !isdirectory($HOME.'/.vim/plugged/'.plugname)
        call s:install_missing()
    endif
endfu

fu! s:maintenance_tasks() abort
    call s:snapshot_and_update()
endfu

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
" Plug 'junegunn/seoul256.vim'
" Plug 'junegunn/vim-easy-align'

" Group dependencies, vim-snippets depends on ultisnips
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using git URL
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

Plug 'scrooloose/nerdtree'
call s:check_installed('nerdtree')

Plug 'tpope/vim-sleuth'
call s:check_installed('vim-sleuth')

Plug 'tpope/vim-sensible'
call s:check_installed('vim-sensible')

Plug 'dylanaraps/wal.vim'
call s:check_installed('wal.vim')

call plug#end()


colorscheme wal

