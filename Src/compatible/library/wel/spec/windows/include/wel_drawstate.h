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

/*****************************************************************************/
/* wel_drawtext.h  [ associated WEL class: WEL_DC ]                          */
/*                 [ associated C file: drawtext.c ]                         */
/*****************************************************************************/
/* Used to draw disabled text                                                */
/*****************************************************************************/

#ifndef _WEL_DRAWTEXT_H_
#define _WEL_DRAWTEXT_H_

#include "Windows.h"
#include "eif_portable.h"

#ifdef __cplusplus
extern "C" {
#endif

/*---------------------------------------------------------------------------*/
/* Draw formatted text in the specified rectangle in disabled mode. Format   */
/* the text according to the specified method (expanding tabs, justifying    */
/* characters, breaking lines, and so forth).                                */
/*---------------------------------------------------------------------------*/
int cwin_draw_disabled_text(HDC hDC, LPCTSTR lpString, int nCount, LPRECT lpRect, UINT uFormat);

#ifdef __cplusplus
}
#endif

#endif
