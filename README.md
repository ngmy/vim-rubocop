# Vim RuboCop

The **Vim RuboCop** plugin runs [RuboCop](https://github.com/bbatsov/rubocop) and displays the results in Vim.

## Installation

- Obtain a copy of this plugin and place `rubocop.vim` in your Vim plugin.

## Usage

- You can use the `:RuboCop` command to run RuboCop and display the results.

- To run with specified config file add this line to your `.vimrc` file:

    ```
    let vimrubocop_config='/path/to/rubocop.yml'
    ```

### Keyboard Shortcuts ###
  Credit for Shortcuts: [ Ack.vim ]( git://github.com/mileszs/ack.vim.git )

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
