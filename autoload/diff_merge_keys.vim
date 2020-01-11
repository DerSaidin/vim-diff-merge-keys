" diff_merge_keys

" Take hunk from win_source, apply hunk to win_destination.
" Leave cursor where it started.
function! diff_merge_keys#diff_take(win_source, win_destination)
    " Based on http://vim.wikia.com/wiki/Selecting_changes_in_diff_mode
    let l:old = winnr()
    " Move to source window
    exec "wincmd ".a:win_source
    " Assumption: just 2 windows side by side.
    if (winnr() == l:old)
        diffput
    else
        wincmd p
        diffget
        exec "wincmd ".a:win_destination
    endif
endfunction

function! diff_merge_keys#take_left()
    " take change from left window, and apply to right window
    call diff_merge_keys#diff_take("h", "l")
endfunction

function! diff_merge_keys#take_right()
    " take change from right window, and apply to left window
    call diff_merge_keys#diff_take("l", "h")
endfunction

" Bind CTRL + arrow key to manipulate hunks.
" Up and down are previous and next.
" Left and right apply hunks from one side to the other.
" These binds ignore what window we are currently in.
function! diff_merge_keys#setup_diff_mappings()
    " This function should have only been called if in diff mode.
    " Check again, just to make sure.
    if &diff
        " zz to vertically center on diff.
        " next diff
        noremap <C-down> ]czz
        " previous diff
        noremap <C-up> [czz

        noremap <C-right> :call diff_merge_keys#take_left()<CR>
        noremap <C-left> :call diff_merge_keys#take_right()<CR>
    endif
endfunction
