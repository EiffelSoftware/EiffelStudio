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
