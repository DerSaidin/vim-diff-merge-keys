if exists('g:loaded_diff_merge_keys')
  finish
endif
let g:loaded_diff_merge_keys = 1

function! diff_merge_keys#diff_mappings()
    if &diff
        " Only setup keys if we are in diff mode.
        " This indirection is to maximize autoload.
        call diff_merge_keys#setup_diff_mappings()
    endif
endfunction

" Trigger when run as vimdiff
call diff_merge_keys#diff_mappings()

" Trigger when opened by :diffsplit
autocmd FilterWritePost * call diff_merge_keys#diff_mappings()
