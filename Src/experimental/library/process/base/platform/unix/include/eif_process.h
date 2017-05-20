/*
indexing
	description: "[	
		]"
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _EIF_PROCESS
#define _EIF_PROCESS

#ifndef EIF_WINDOWS_MINGW
	// Include normal Unix process functions
#include <sys/wait.h>
#include <termios.h>
#else
	// Provide dummy functions for compilation on mingw.
#define WIFEXITED(x) 1
#define WIFSIGNALED(x) 0
#define WEXITSTATUS(x) ((x) & 0xff)
#define WNOHANG 1
#define WUNTRACED 2

#define F_SETFD 2

#define WIFSTOPPED(x) 0
#define setpgid(x, y)
#define pipe(x) 0
#define kill(x, y) 0
#define waitpid(x, y, z) 0
#define fork() 0
#define getdtablesize() 20
#define fcntl(x, y, z) 1
#define getpgid(x) 1
#define tcsetpgrp(x, y)

#endif


#endif
