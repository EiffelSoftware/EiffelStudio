/*
	description: "VMS specific routines."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _ipcvmsdef_h_
#define _ipcvmsdef_h_

#if defined(__vms)

/*  Private definitions file for special IPC/VMS facility  */

#ifndef DEBUG	/* if not already defined */
#define DEBUG	/* force debug for now */
//#define DEBUG 2	/* this one generates a warning */
#endif

#define WRITE_ASYNC 1	/* 1 = always, 2 = if O_NDELAY in pipe() call */


#include <assert.h>
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#ifndef USE_VARARGS	/* default = USE_STDARG */
#define USE_STDARG
#endif
#ifdef USE_STDARG
#include <stdarg.h>
#define VA_START(ap, start)  va_start(ap, start)
#else
#include <varargs.h>
#define VA_START(ap, start)  va_start(ap)
#endif

#include "ipcvms.h"	    /* sys public definitions */

/* These are probably included by ipcvms.h, but what the hey... */
#include <processes.h>	    /* pipe, exec, vfork... */
#include <unixio.h>	    /* open, close, read, write, dup, ... */
#include <file.h>	    /* O_RDWR, O_NDELAY, ... */

#define CONST const
typedef int FD;

/* int ipcvms_pipe(int fd[2], ...); */



#endif /* __vms */
#endif /* _ipcvmsdef_h_ */
