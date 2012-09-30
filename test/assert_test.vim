function! s:assert(bool)
  if a:bool
    echon '.'
  else
    echon 'F'
  endif
endfunction

function! s:assertNot(bool)
  call s:assert(!a:bool)
endfunction

" equals
call s:assert(vimtest#assert#new().equals(1, 1))
call s:assertNot(vimtest#assert#new().equals(1, 0))
call s:assert(vimtest#assert#new().equals('a', 'a'))
call s:assertNot(vimtest#assert#new().equals('a', 0))
call s:assertNot(vimtest#assert#new().equals('a', 'A'))
call s:assertNot(vimtest#assert#new().equals('a', 'b'))
call s:assert(vimtest#assert#new().equals([], []))
call s:assert(vimtest#assert#new().equals([1], [1]))
call s:assert(vimtest#assert#new().equals(['a'], ['a']))
call s:assertNot(vimtest#assert#new().equals(['a'], ['b']))

" not_equals
call s:assertNot(vimtest#assert#new().not_equals(1, 1))
call s:assert(vimtest#assert#new().not_equals(1, 0))
call s:assertNot(vimtest#assert#new().not_equals('a', 'a'))
call s:assert(vimtest#assert#new().not_equals('a', 'A'))
call s:assert(vimtest#assert#new().not_equals('a', 'b'))
call s:assertNot(vimtest#assert#new().not_equals([], []))
call s:assertNot(vimtest#assert#new().not_equals([1], [1]))
call s:assertNot(vimtest#assert#new().not_equals(['a'], ['a']))
call s:assert(vimtest#assert#new().not_equals(['a'], ['b']))

" true
call s:assert(vimtest#assert#new().true(1))
call s:assertNot(vimtest#assert#new().true(0))
call s:assertNot(vimtest#assert#new().true('a'))
call s:assertNot(vimtest#assert#new().true(1 == 0))
call s:assertNot(vimtest#assert#new().true('a' == 'b'))

" false
call s:assertNot(vimtest#assert#new().false(1))
call s:assert(vimtest#assert#new().false(0))
call s:assert(vimtest#assert#new().false('a'))
call s:assert(vimtest#assert#new().false(1 == 0))
call s:assert(vimtest#assert#new().false('a' == 'b'))

