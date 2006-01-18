/*
	description: "Some configured inclusions/definitions."
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

#ifndef _eif_eiffel_h_
#define _eif_eiffel_h_

#include "eif_portable.h"

#ifndef VXWORKS
#include <string.h>
#endif

#include "eif_globals.h"

/* The following includes are needed only because Eiffel has no way to direct
 * the compiler to include specific files when using some externals routines.
 * Hence, to ensure a smooth C compilation, we have to include all of them--RAM.
 */

#include "eif_out.h"
#include <stdio.h>				/* For FILE routines */
#include <sys/types.h>			/* Needed for directory entries */
#include "eif_dir.h"				/* Directory routines */
#include "eif_file.h"				/* %%ss moved from 3 lines above */

#include "eif_macros.h"


#ifdef CONCURRENT_EIFFEL
#include "eif_curextern.h"
#endif

/* Platform definition */
/* Windows definition */
#ifdef EIF_WINDOWS
#define EIF_IS_WINDOWS EIF_TRUE
#else
#define EIF_IS_WINDOWS EIF_FALSE
#endif

#ifdef EIF_64_BITS
#define EIF_IS_64_BITS	EIF_TRUE
#else
#define EIF_IS_64_BITS	EIF_FALSE
#endif

/* VMS definition */
#ifdef EIF_VMS
#define EIF_IS_VMS EIF_TRUE
#else
#define EIF_IS_VMS EIF_FALSE
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
}
#endif

#endif

