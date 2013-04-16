" The "Vim RuboCop" plugin runs RuboCop and displays the results in Vim.
"
" Author:  ngmy
" URL:     https://github.com/ngmy/vim-rubocop
" Version: 0.1
" ----------------------------------------------------------------------------

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
  let l:rubocop_opts   = ' '.l:extra_args.' --emacs --silent'
  if g:vimrubocop_config != ''
    let l:rubocop_opts = ' '.l:rubocop_opts.' --config '.g:vimrubocop_config
  endif
  let l:rubocop_output  = system(l:rubocop_cmd.l:rubocop_opts.' '.l:filename)
  let l:rubocop_output  = substitute(l:rubocop_output, '\\"', "'", 'g')
  let l:rubocop_results = split(l:rubocop_output, "\n")
  cexpr l:rubocop_results
  copen
endfunction

command! RuboCop :call <SID>RuboCop()
