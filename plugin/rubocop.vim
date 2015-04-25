" The "Vim RuboCop" plugin runs RuboCop and displays the results in Vim.
"
" Author:    Yuta Nagamiya
" URL:       https://github.com/ngmy/vim-rubocop
" Version:   0.4
" Copyright: Copyright (c) 2013 Yuta Nagamiya
" License:   MIT
" ----------------------------------------------------------------------------

if exists('g:loaded_vimrubocop') || &cp
  finish
endif
let g:loaded_vimrubocop = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:vimrubocop_rubocop_cmd')
  let g:vimrubocop_rubocop_cmd = 'rubocop '
endif

" Options
if !exists('g:vimrubocop_config')
  let g:vimrubocop_config = ''
endif

if !exists('g:vimrubocop_extra_args')
  let g:vimrubocop_extra_args = ''
endif

if !exists('g:vimrubocop_keymap')
  let g:vimrubocop_keymap = 1
endif

let s:rubocop_switches = ['-l', '--lint', '-R', '--rails', '-a', '--auto-correct']

function! s:RuboCopSwitches(...)
  return join(s:rubocop_switches, "\n")
endfunction

function! s:RuboCop(current_args)
  let l:extra_args     = g:vimrubocop_extra_args
  let l:filename       = @%
  let l:rubocop_cmd    = g:vimrubocop_rubocop_cmd
  let l:rubocop_opts   = ' '.a:current_args.' '.l:extra_args.' --format emacs'
  if g:vimrubocop_config != ''
    let l:rubocop_opts = ' '.l:rubocop_opts.' --config '.g:vimrubocop_config
  endif

  let l:rubocop_output  = system(l:rubocop_cmd.l:rubocop_opts.' '.l:filename)
  if !empty(matchstr(l:rubocop_opts, '--auto-correct\|-\<a\>'))
    "Reload file if using auto correct
    edit
  endif
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

command! -complete=custom,s:RuboCopSwitches -nargs=? RuboCop :call <SID>RuboCop(<q-args>)

" Shortcuts for RuboCop
if g:vimrubocop_keymap == 1
  nmap <Leader>ru :RuboCop<CR>
endif

let &cpo = s:save_cpo
