/*
 * WEL_THR_INIT.H
 */


#ifndef __WEL_THR_INIT__
#define __WEL_THR_INIT__

#ifndef __WEL_GLOBALS__
#	include "wel_globals.h"
#endif

#ifdef EIF_THREADS
	EIF_BOOLEAN is_wel_global_key_created;
	extern void wel_init_context(wel_global_context_t *wel_globals);
	extern void wel_thr_register(void);
#endif

#endif /* __WEL_THR_INIT__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
