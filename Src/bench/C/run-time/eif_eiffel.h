/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
	Some configured inclusions/definitions.
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

/* defined in pattern.c */
RT_LNK EIF_INTEGER str_str(char *text, char *pattern, int tlen, int plen, int start, int fuzzy);

#ifdef __cplusplus
}
#endif

#endif

