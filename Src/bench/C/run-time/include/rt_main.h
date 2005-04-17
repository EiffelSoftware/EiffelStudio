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

#ifndef _rt_main_h_
#define _rt_main_h_

#include "eif_main.h"

#ifdef __cplusplus
extern "C" {
#endif

#if defined(WORKBENCH) || defined (EIF_THREADS)
extern BODY_INDEX * EIF_once_indexes; /* Code indexes of registered once routines */
#endif

#ifdef EIF_THREADS
extern BODY_INDEX * EIF_process_once_indexes; /* Code indexes of registered process-relative once routines */
#endif

extern void once_init (void);		/* Initialization and creation of once keys */
extern char dinterrupt(void);
extern void dserver(void);
extern int eif_no_reclaim;		/* Call reclaim ion termination? */
extern int cc_for_speed;		/* Optimized for speed or for memory */
extern char *starting_working_directory;

RT_LNK int debug_mode;
RT_LNK unsigned TIMEOUT;		/* Time out on reads */

#ifdef EIF_WIN32
/* Console management for Windows */
extern void eif_console_cleanup (EIF_BOOLEAN);
extern void eif_show_console (void);					/* Show the DOS console if needed */
#endif

RT_LNK void dexit(int);

#ifdef __cplusplus
}
#endif

#endif
