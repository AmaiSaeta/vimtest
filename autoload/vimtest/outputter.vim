" AUTHOR: kanno <akapanna@gmail.com>
" License: This file is placed in the public domain.
let s:save_cpo = &cpo
set cpo&vim

function! vimtest#outputter#instance(name)
  let s:outputter = {'_name': a:name}

  function! s:outputter.init()
  endfunction

  " TODO messageの組み立てはこのファイルの責務じゃない
  function! s:outputter.create_progress_message(results)
    let lines = []
    for r in a:results
      call add(lines, r._runner_name)
      for testcase in keys(r._progress)
        call add(lines, vimtest#message#progress_line(r._progress[testcase], testcase))
      endfor
      call add(lines, '')
    endfor
    return join(lines, "\n")
  endfunction

  " TODO messageの組み立てはこのファイルの責務じゃない
  function! s:outputter.create_failed_message(results)
    let message = ''
    for r in a:results
      if !empty(r.failed_summary())
        let message .= r.failed_summary()
      endif
    endfor
    return message
  endfunction

  " TODO messageの組み立てはこのファイルの責務じゃない
  function! s:outputter.create_summary_message(results)
    let total_test_count   = 0
    let total_passed_count = 0
    let total_failed_count = 0
    for r in a:results
      let total_test_count   += len(r._progress)
      let total_passed_count += len(r._passed)
      let total_failed_count += len(r._failed)
    endfor
    return vimtest#message#summary(total_test_count, total_passed_count, total_failed_count)
  endfunction

  function! s:outputter.online_summary(results)
    let summary = self.create_summary_message(a:results)
    return substitute(summary, "\n", '', 'g')
  endfunction

  return s:outputter
endfunction

function! vimtest#outputter#get(type)
  if a:type ==? 'buffer'
    return vimtest#outputter#buffer#new()
  elseif a:type ==? 'stdout'
    return vimtest#outputter#stdout#new()
  elseif a:type ==? 'quickfix'
    return vimtest#outputter#quickfix#new()
  elseif a:type ==? 'string'
    return vimtest#outputter#string#new()
  else
    return vimtest#outputter#buffer#new()
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
