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
	Private data for option.c
*/

#ifndef _rt_option_h_
#define _rt_option_h_

#include "eif_option.h"
#include "rt_threads.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS
extern EIF_LW_MUTEX_TYPE *eif_trace_mutex;
#endif

extern void exitprf(void);				/* Saves table as textfile */

#ifdef __cplusplus
}
#endif

#endif

