" Vim syntax file
" Language:	Upstart job files
" Maintainer:	Michael Biebl <biebl@debian.org>
"		James Hunt <james.hunt@ubuntu.com>
" Last Change:	2011 Dec 15
" License:	GPL v2
" Version:	0.5
" Remark:	Syntax highlighting for Upstart (init(8)) job files.
"
" It is inspired by the initng syntax file and includes sh.vim to do the
" highlighting of script blocks.

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

let is_bash = 1
syn include @Shell syntax/sh.vim

syn case match

syn match upstartComment /#.*$/ contains=upstartTodo
syn keyword upstartTodo TODO FIXME contained

syn region upstartString start=/"/ end=/"/ skip=/\\"/

syn region upstartScript matchgroup=upstartStatement start="script" end="end script" contains=@upstartShellCluster

syn cluster upstartShellCluster contains=@Shell

" one argument
syn keyword upstartStatement description author version instance expect
syn keyword upstartStatement pid kill normal console env exit export
syn keyword upstartStatement umask nice oom chroot chdir exec setuid setgid

" two arguments
syn keyword upstartStatement limit

" one or more arguments (events)
syn keyword upstartStatement emits

syn keyword upstartStatement on start stop

" flag, no parameter
syn keyword upstartStatement respawn service instance manual debug task

" prefix for exec or script 
syn keyword upstartOption pre-start post-start pre-stop post-stop

" option for kill
syn keyword upstartOption timeout signal
" option for oom
syn keyword upstartOption score never
" options for console
syn keyword upstartOption output owner none log
" options for expect
syn keyword upstartOption stop fork daemon none
" options for limit
syn keyword upstartOption unlimited core cpu data fsize memlock msgqueue nice
syn keyword upstartOption nofile nproc rss rtprio sigpending stack

" 'options' for start/stop on
syn keyword upstartOption and or

" Upstart itself and associated utilities
syn keyword upstartEvent runlevel
syn keyword upstartEvent started
syn keyword upstartEvent starting
syn keyword upstartEvent startup
syn keyword upstartEvent stopped
syn keyword upstartEvent stopping
syn match   upstartEvent /control-alt-delete/
syn match   upstartEvent /keyboard-request/
syn match   upstartEvent /power-status-changed/

" D-Bus
syn match   upstartEvent /dbus-activation/

" Display Manager (ie gdm/lightdm)
syn match   upstartEvent /desktop-session-start/
syn match   upstartEvent /login-session-start/
syn match   upstartEvent /desktop-shutdown/

" mountall
syn keyword upstartEvent filesystem
syn keyword upstartEvent mounted
syn keyword upstartEvent mounting
syn match   upstartEvent /device-not-ready/
syn match   upstartEvent /\(\<local\>\|\<virtual\>\|\<remote\>\)-filesystems/
syn match   upstartEvent /all-swaps/

" upstart-udev-bridge and ifup/down
syn match   upstartEvent /\<\i\{-1,}-device-\(\<added\>\|\<removed\>\|\<up\>\|\<down\>\)/
syn match   upstartEvent /static-network-up/

" SysV handling
syn match   upstartEvent /unmounted-remote-filesystems/
syn match   upstartEvent /deconfiguring-networking/

" misc
syn match   upstartEvent /failsafe-boot/
syn match   upstartEvent /recovery/

" upstart-socket-bridge
syn keyword upstartEvent socket

hi def link upstartComment   Comment
hi def link upstartTodo	     Todo
hi def link upstartString    String
hi def link upstartStatement Statement
hi def link upstartOption    Type
hi def link upstartEvent     Define

let b:current_syntax = "upstart"
