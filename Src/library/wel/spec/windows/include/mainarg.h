/*
 * MAIN_ARG.H
 */

#ifndef __WEL_MAINARG__
#define __WEL_MAINARG__


#ifndef __WEL__
#include <wel.h>
#endif

#include "eif_main.h"

#ifdef __cplusplus
extern "C" {
#endif


/* Eiffel run-time global variables */
#define cwel_hinstance eif_hInstance
#define cwel_previous_hinstance eif_hPrevInstance
#define cwel_command_line eif_lpCmdLine
#define cwel_command_show eif_nCmdShow

#ifdef __cplusplus
}
#endif

#endif /* __WEL_MAINARG__ */

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
