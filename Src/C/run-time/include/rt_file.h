/*
	description: "Private declaration for CECIL."
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

#ifndef _rt_file_h
#define _rt_file_h

#include "eif_file.h"

#ifdef __cplusplus
extern "C" {
#endif

/* The following macros may not exist on all platforms. And we are simply defining them
 * in case they are not. We rely on the presence of the S_IFMT mask for all our platforms. */
#ifndef S_ISDIR
#	define S_ISDIR(mode)	(((mode) & S_IFMT) == S_IFDIR)
#endif

#ifndef S_ISCHR
#	define S_ISCHR(mode)	(((mode) & S_IFMT) == S_IFCHR)
#endif

#ifndef S_ISREG
#	define S_ISREG(mode)	(((mode) & S_IFMT) == S_IFREG)
#endif

#ifdef S_IFBLK
#	ifndef S_ISBLK
#		define S_ISBLK(mode)	(((mode) & S_IFMT) == S_IFBLK)
#	endif
#else
#	define S_ISBLK(mode)	0
#endif

#ifdef S_IFIFO
#	ifndef S_ISFIFO
#		define S_ISFIFO(mode)	(((mode) & S_IFMT) == S_IFIFO)
#	endif
#else
#	define S_ISFIFO(mode)	0
#endif

#ifdef S_IFLNK
#	ifndef S_ISLNK
#		define S_ISLNK(mode)	(((mode) & S_IFMT) == S_IFLNK)
#	endif
#else
#	define S_ISLNK(mode)	0
#endif

#ifdef S_IFSOCK
#	ifndef S_ISSOCK
#		define S_ISSOCK(mode)	(((mode) & S_IFMT) == S_IFSOCK)
#	endif
#else
#	define S_ISSOCK(mode)	0
#endif

#ifndef NAME_MAX
#define NAME_MAX	10			/* Maximum length for user/group name */
#endif

/* The following access constants seems to be universally accepeted. And
 * anyway, it's only after BSD 4.1 that the symbolic constants appeared.
 */

#ifndef R_OK
#define R_OK	4
#define W_OK	2
#define X_OK	1
#define F_OK	0
#endif


#ifdef __cplusplus
}
#endif

#endif

