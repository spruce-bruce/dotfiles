let mapleader="\<space>"
filetype plugin indent on
set tabstop=4                      " number of visual spaces per TAB
set shiftwidth=4
set softtabstop=4                  " number of spaces in tab when editing
set expandtab                      " tabs are spaces
set autoindent
set smartindent
set diffopt=vertical
set ic                             " case insensitive search by defaul
set incsearch                      " search as you type
set cursorline                     " highlight current line
set showmatch                      " highlight matching [{()}]
set hlsearch                       " highlight matches
autocmd BufWritePre * :%s/\s\+$//e " automatically remove trailing spaces before saving
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set backspace=indent,eol,start     " required to make backspace behave as expected

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" DOPE ASS VIMRC
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Color and Style
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

syntax on
set number
set background=dark
set guifont=Monaco:h12

" LINTING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = 'eslint'
let g:jsx_ext_required = 0


" FUGITIVE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>g :Git<space>
map <Leader>gg :Git<CR>
map <Leader>gs :Gstatus<CR>
map <Leader>gp :Git push<CR>
map <Leader>gca :Git commit -a<CR>
map <Leader>gcc :Git commit<CR>

" DISPATCH.VIM
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>d :Dispatch<space>
map <Leader>t :Dispatch yarn workspace api test:lab<CR>
map <Leader>dt :Dispatch docker-compose exec api npm run test:lab

" AIRLINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='bubblegum'
set laststatus=2
set ttimeoutlen=50

" NERDTREE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=40
let NERDSpaceDelims=1

" CTRLP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
nmap <Leader>p :CtrlPBuffer<CR>

" CODE FOLDING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set foldmethod=indent   " code folding
set foldlevel=1
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" SHORTCUTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>bd :bufdo bd<CR>
nnoremap <leader>bo :BufOnly<CR>
nnoremap <leader><space> :nohlsearch<CR>
nnoremap <leader>rni :silent ! cd HeliaConnect && react-native run-ios && cd ..<CR>
nnoremap <leader>rna :silent ! cd HeliaConnect && react-native run-android && cd ..<CR>
nnoremap <leader>rnm ! adb shell input keyevent 82<CR>

" EDITORCONFIG
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'

" WINDOW NAVIGATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>


" SEARCH (RIPGREP)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ --ignore-case
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

command -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
nnoremap \ :Rg<SPACE>

" NERDCOMMENTER
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" VIM-LSP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lsp_diagnostics_enabled = 0
" set foldmethod=expr
"   \ foldexpr=lsp#ui#vim#folding#foldexpr()
"   \ foldtext=lsp#ui#vim#folding#foldtext()

" Function to Watch for changes if buffer changed on disk
function! WatchForChanges(bufname, ...)
  " Figure out which options are in effect
  if a:bufname == '*'
    let id = 'WatchForChanges'.'AnyBuffer'
    " If you try to do checktime *, you'll get E93: More than one match for * is given
    let bufspec = ''
  else
    if bufnr(a:bufname) == -1
      echoerr "Buffer " . a:bufname . " doesn't exist"
      return
    end
    let id = 'WatchForChanges'.bufnr(a:bufname)
    let bufspec = a:bufname
  end
  if len(a:000) == 0
    let options = {}
  else
    if type(a:1) == type({})
      let options = a:1
    else
      echoerr "Argument must be a Dict"
    end
  end
  let autoread    = has_key(options, 'autoread')    ? options['autoread']    : 0
  let toggle      = has_key(options, 'toggle')      ? options['toggle']      : 0
  let disable     = has_key(options, 'disable')     ? options['disable']     : 0
  let more_events = has_key(options, 'more_events') ? options['more_events'] : 1
  let while_in_this_buffer_only = has_key(options, 'while_in_this_buffer_only') ? options['while_in_this_buffer_only'] : 0
  if while_in_this_buffer_only
    let event_bufspec = a:bufname
  else
    let event_bufspec = '*'
  end
  let reg_saved = @"
  "let autoread_saved = &autoread
  let msg = "\n"
  " Check to see if the autocommand already exists
  redir @"
    silent! exec 'au '.id
  redir END
  let l:defined = (@" !~ 'E216: No such group or event:')
  " If not yet defined...
  if !l:defined
    if l:autoread
      let msg = msg . 'Autoread enabled - '
      if a:bufname == '*'
        set autoread
      else
        setlocal autoread
      end
    end
    silent! exec 'augroup '.id
      if a:bufname != '*'
        "exec "au BufDelete    ".a:bufname . " :silent! au! ".id . " | silent! augroup! ".id
        "exec "au BufDelete    ".a:bufname . " :echomsg 'Removing autocommands for ".id."' | au! ".id . " | augroup! ".id
        exec "au BufDelete    ".a:bufname . " execute 'au! ".id."' | execute 'augroup! ".id."'"
      end
        exec "au BufEnter     ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHold   ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHoldI  ".event_bufspec . " :checktime ".bufspec
      " The following events might slow things down so we provide a way to disable them...
      " vim docs warn:
      "   Careful: Don't do anything that the user does
      "   not expect or that is slow.
      if more_events
        exec "au CursorMoved  ".event_bufspec . " :checktime ".bufspec
        exec "au CursorMovedI ".event_bufspec . " :checktime ".bufspec
      end
    augroup END
    let msg = msg . 'Now watching ' . bufspec . ' for external updates...'
  end
  " If they want to disable it, or it is defined and they want to toggle it,
  if l:disable || (l:toggle && l:defined)
    if l:autoread
      let msg = msg . 'Autoread disabled - '
      if a:bufname == '*'
        set noautoread
      else
        setlocal noautoread
      end
    end
    " Using an autogroup allows us to remove it easily with the following
    " command. If we do not use an autogroup, we cannot remove this
    " single :checktime command
    " augroup! checkforupdates
    silent! exec 'au! '.id
    silent! exec 'augroup! '.id
    let msg = msg . 'No longer watching ' . bufspec . ' for external updates.'
  elseif l:defined
    let msg = msg . 'Already watching ' . bufspec . ' for external updates'
  end
  "echo msg
  let @"=reg_saved
endfunction

let autoreadargs={'autoread':1}
execute WatchForChanges("*",autoreadargs)

