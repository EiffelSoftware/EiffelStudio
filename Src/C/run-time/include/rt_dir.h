/*
	description: "Private declaration of public directory functions."
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

#ifndef _rt_dir_h_
#define _rt_dir_h_

#include "eif_dir.h"

#ifdef I_DIRENT
#include <dirent.h>
#define DIRENTRY struct dirent
#elif defined(I_SYS_DIR)
#include <sys/dir.h>
#define DIRENTRY struct direct
#elif defined(I_SYS_NDIR)
#include <sys/ndir.h>
#define DIRENTRY struct direct
#elif defined(EIF_VMS_V6_ONLY)
#include <descrip.h>
#include "eif_vmsdirent.h"		/* local to run-time */
#define DIRENTRY struct dirent
#elif defined EIF_WINDOWS
#else
	Sorry! You have to find a directory package...
#endif

#ifdef EIF_WINDOWS
#include <windows.h>
#include <direct.h>	/* In order to use chdir and getcwd */
#else
#include <unistd.h>	/* In order to use chdir and getcwd */
#endif

#endif
