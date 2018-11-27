" PHP Auto Namespacer
" Author:     Serhii Yaniuk <serhiiyaniuk@gmail.com>
" Repository: github.com/d3jn/php-auto-namespacer.vim
" Version:    0.1
" License:    MIT License

if !exists('g:php_auto_namespacer_map')
    let g:php_auto_namespacer_map = {
\       'app/': 'App\',
\       'src/': ''
\   }
endif

function! s:addTrailingSeparator(string, separator)
    if a:string !~ '\' . a:separator . '$'
        return a:string . a:separator
    endif

    return a:string
endfunction

function! s:removeTrailingSeparators(string)
    return substitute(a:string, '[\\\/]\+$', '', '')
endfunction

function! php_auto_namespacer#SubstitutePart(part, map)
    for [from_value, to_value] in items(a:map)
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

function! php_auto_namespacer#ConvertPathToPSR4(path, map)
    if expand('%:t') == a:path
        return ''
    endif

    let namespace = substitute(substitute(a:path, '/', '\', 'g'), '\\[^\\]\+$', '', 'g')
    for [from_dir, to_namespace] in items(a:map)
        let from_dir = s:addTrailingSeparator(from_dir, '/')
        let to_namespace = s:removeTrailingSeparators(to_namespace)

        if a:path =~ '^' . from_dir
            let namespace = strpart(namespace, strlen(from_dir))
            if to_namespace != ''
                let namespace = namespace == '' ? to_namespace : to_namespace . '\' . namespace
            endif
        endif
    endfor

    return namespace
endfunction

function! php_auto_namespacer#PastePSR4Namespace()
    let path = expand('%')
    if line('$') == 1 && getline(1) == ''
        let namespace = php_auto_namespacer#ConvertPathToPSR4(path, g:php_auto_namespacer_map)
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
