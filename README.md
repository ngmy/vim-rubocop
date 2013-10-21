# Vim RuboCop

The **Vim RuboCop** plugin runs [RuboCop](https://github.com/bbatsov/rubocop) and displays the results in Vim.

## Requirements

- Please note that the current version of the Vim RuboCop plugin requires RuboCop 0.12.0 or later.

## Installation

- Obtain a copy of this plugin and place `rubocop.vim` in your Vim plugin.

## Usage

- You can use the `:RuboCop` command to run RuboCop and display the results.

- To run with specified config file add this line to your `.vimrc` file:

    ```viml
    let g:vimrubocop_config = '/path/to/rubocop.yml'
    ```

### Keyboard Shortcuts ###
  Credit for Shortcuts: [Ack.vim](https://github.com/mileszs/ack.vim)

In the quickfix window, you can use:

    o    to open (same as enter)
    go   to preview file (open but maintain focus on ack.vim results)
    t    to open in new tab
    T    to open in new tab silently
    h    to open in horizontal split
    H    to open in horizontal split silently
    v    to open in vertical split
    gv   to open in vertical split silently
    q    to close the quickfix window

Additionally, the plugin registers `<Leader>ru` in normal mode
for triggering it easily. You can disable these default mappings by setting
`g:vimrubocop_keymap` in your `.vimrc` file, and then remap them differently.

For instance, to trigger RuboCop by pressing `<Leader>r` you can put the following in
your `.vimrc`:

```viml
let g:vimrubocop_keymap = 0
nmap <Leader>r :RuboCop<CR>
```
