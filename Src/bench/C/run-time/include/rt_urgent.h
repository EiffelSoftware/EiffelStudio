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
	Declarations for urgent memory chunk allocation.
*/

#ifndef _eif_urgent_h_
#define _eif_urgent_h_

#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef VXWORKS
#define URGENT_CHUNK	1016	/* Size of urgent chunk (1K with overhead) */
#define URGENT_NBR		1		/* Number of urgent chunks allocated */
#else
#define URGENT_CHUNK	1016	/* Size of urgent chunk (1K with overhead) */
#define URGENT_NBR		10		/* Number of urgent chunks allocated */
#endif

rt_shared void ufill(void);			/* Get as many chunks as possible */
rt_shared char *uchunk(void);			/* Urgent allocation of a stack chunk */

#ifdef __cplusplus
}
#endif

#endif
