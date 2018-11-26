" PHP Auto Namespacer
" Author:     Serhii Yaniuk <serhiiyaniuk@gmail.com>
" Repository: github.com/d3jn/php-auto-namespacer.vim
" Version:    1.0
" License:    MIT License

if exists('g:php_auto_namespacer_disable')
    if g:php_auto_namespacer_disable == 1
        finish
    endif
endif

if !exists('g:php_auto_namespacer_substitutes')
    let g:php_auto_namespacer_substitutes = {
\       'app': 'App',
\       'src': ''
\   }
endif

function! php_auto_namespacer#SubstitutePart(part, substitutes)
    for [from_value, to_value] in items(a:substitutes)
        if a:part == from_value
            if to_value == ''
                return ''
            else
                return to_value
            endif
        endif
    endfor

    return a:part
endfunction

function! php_auto_namespacer#ConvertPathToPSR4(path, substitutes)
    if expand('%:t') == a:path
        return ''
    endif

    let namespace = substitute(substitute(a:path, '/', '\', 'g'), '\\[^\\]\+$', '', 'g')
    echom namespace
    let parts = split(namespace, '\\')
    let final_parts = []

    for part in parts
        let final_part = php_auto_namespacer#SubstitutePart(part, a:substitutes)
        echom final_part
        if final_part == ''
            continue
        endif

        call add(final_parts, final_part)
    endfor

    let result = join(final_parts, '\')

    return result
endfunction

function! php_auto_namespacer#PastePSR4Namespace()
    let path = expand('%')
    if line('$') == 1 && getline(1) == ''
        let namespace = php_auto_namespacer#ConvertPathToPSR4(path, g:php_auto_namespacer_substitutes)
        let class_name = expand('%:t:r')

        if namespace == ''
            normal! cc<?phpclass =class_name{}gg
        else
            normal! cc<?phpnamespace =namespace;class =class_name{}gg
        endif
    endif
endfunction

augroup php_auto_namespacer_on_buf_read_group
    autocmd!
    autocmd BufRead * call php_auto_namespacer#PastePSR4Namespace()
augroup END
