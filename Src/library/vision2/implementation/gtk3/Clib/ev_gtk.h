/*
indexing
	description: "Include file for gtk and Eiffel runtime features"
	date: "$Date$"
	revision: "$Revision$"
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

#ifndef _EV_GTK_H_INCLUDED_
#define _EV_GTK_H_INCLUDED_

#include <gtk/gtk.h>
#ifdef GDK_WINDOWING_X11
#include <gdk/gdkx.h>
#include <X11/Xlib.h>
#endif

/* 
	For macOs GDB_BACKEND quarts maybe we need  
    to check GDK_WINDOWING_QUARTZ
*/
#ifdef EIF_MACOSX
	#include <TargetConditionals.h>
	#ifdef TARGET_OS_MAC
		#include <gdk/gdk.h>
		#include <gdk/gdkquartz.h>
	#endif
#endif


#include <eif_eiffel.h>

/* For dev/debug purpose, added output print statement */
#define EV_PRINTF(str) printf(str)
#define EV_PRINTF_1(str, p1) printf(str, p1)
#define EV_PRINTF_2(str, p1, p2) printf(str, p1, p1)

#ifdef EIF_IL_DLL
/* 
 * Uncomment the following definition when debugging .Net projects
 */
#define IL_EV_PRINTF(str) //EV_PRINTF(str)
#define IL_EV_PRINTF_1(str, p1) //EV_PRINTF_1(str, p1)
#define IL_EV_PRINTF_2(str, p1, p2) //EV_PRINTF_2(str, p1, p1)
#else
#define IL_EV_PRINTF(str)
#define IL_EV_PRINTF_1(str, p1)
#define IL_EV_PRINTF_2(str, p1, p2)
#endif

#endif
