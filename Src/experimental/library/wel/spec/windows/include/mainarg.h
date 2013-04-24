/*
indexing
description: "WEL: library of reusable components for Windows."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
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
