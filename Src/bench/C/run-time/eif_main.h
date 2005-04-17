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

#ifndef _eif_main_h_
#define _eif_main_h_

#include "eif_portable.h"
#include "eif_globals.h"

#ifdef EIF_WIN32
#include <windows.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS
RT_LNK EIF_process_once_value_t *EIF_process_once_values; /* Once values for a process */
#else
RT_LNK EIF_once_value_t *EIF_once_values; /* Once values for a thread */
RT_LNK EIF_REFERENCE **EIF_oms;           /* Once manifest strings for a thread */
RT_LNK int in_assertion;                  /* Value of the assertion level */
#endif

RT_LNK long EIF_once_count;			/* Nr. of once routines */
#ifdef EIF_THREADS
RT_LNK long EIF_process_once_count;		/* Nr. of process-relative once routines */
#endif
RT_LNK int scount;					/* Maximum dtype */
RT_LNK void eif_alloc_init(void);

#ifdef EIF_WIN32
RT_LNK void get_argcargv (int *argc, char ***argv);
RT_LNK void free_argv (char ***argv);
RT_LNK HANDLE ghInstance;
RT_LNK HINSTANCE eif_hInstance;
RT_LNK HINSTANCE eif_hPrevInstance;
RT_LNK LPSTR eif_lpCmdLine;
RT_LNK int eif_nCmdShow;
#endif

#ifdef __cplusplus
}
#endif

#endif
