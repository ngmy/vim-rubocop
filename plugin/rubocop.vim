" The "Vim RuboCop" plugin runs RuboCop and displays the results in Vim.
"
" Author:  ngmy
" URL:     https://github.com/ngmy/vim-rubocop
" Version: 0.1
" ----------------------------------------------------------------------------

" Shortcuts for RuboCop
nmap <Leader>ru :RuboCop<CR>
imap <Leader>ru <ESC>:RuboCop<CR>

if exists('g:loaded_vimrubocop') || &cp
  finish
endif
let g:loaded_vimrubocop = 1

let s:save_cpo = &cpo
set cpo&vim

" Test for RuboCop
if !exists('vimrubocop_rubocop_cmd')
  if executable('rubocop')
    let vimrubocop_rubocop_cmd='rubocop '
  else
    " Unable to find the RuboCop executable
    echomsg 'Unable to find rubocop in the current PATH.'
    echomsg 'Plugin not loaded.'
    let &cpo = s:save_cpo
    finish
  endif
endif

" Options
if !exists('vimrubocop_config')
  let vimrubocop_config=''
endif

if !exists('vimrubocop_extra_args')
  let vimrubocop_extra_args=''
endif

function! s:RuboCop()
  let l:extra_args     = g:vimrubocop_extra_args
  let l:filename       = @%
  let l:rubocop_cmd    = g:vimrubocop_rubocop_cmd
  let l:rubocop_opts   = ' '.l:extra_args.' --format emacs --silent'
  if g:vimrubocop_config != ''
    let l:rubocop_opts = ' '.l:rubocop_opts.' --config '.g:vimrubocop_config
  endif
  let l:rubocop_output  = system(l:rubocop_cmd.l:rubocop_opts.' '.l:filename)
  let l:rubocop_output  = substitute(l:rubocop_output, '\\"', "'", 'g')
  let l:rubocop_results = split(l:rubocop_output, "\n")
  cexpr l:rubocop_results
  copen
  " Shortcuts taken from Ack.vim - git://github.com/mileszs/ack.vim.git
  exec "nnoremap <silent> <buffer> q :ccl<CR>"
  exec "nnoremap <silent> <buffer> t <C-W><CR><C-W>T"
  exec "nnoremap <silent> <buffer> T <C-W><CR><C-W>TgT<C-W><C-W>"
  exec "nnoremap <silent> <buffer> o <CR>"
  exec "nnoremap <silent> <buffer> go <CR><C-W><C-W>"
  exec "nnoremap <silent> <buffer> h <C-W><CR><C-W>K"
  exec "nnoremap <silent> <buffer> H <C-W><CR><C-W>K<C-W>b"
  exec "nnoremap <silent> <buffer> v <C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t"
  exec "nnoremap <silent> <buffer> gv <C-W><CR><C-W>H<C-W>b<C-W>J"
endfunction

command! RuboCop :call <SID>RuboCop()
