#include "wel_globals.h"
#include "wel_drawstate.h"

typedef struct tagDRAWTEXTCONTEXT
	{
	LPCTSTR lpString;
	int nCount;
	LPRECT lpRect;
	UINT uformat;
	} DRAWTEXTCONTEXT;

/*****************************************************************************/
/* DrawTextDrawStateCallBackProc                                             */
/*---------------------------------------------------------------------------*/
/* Callback function used with `cwin_draw_disabled_text'                     */
/*****************************************************************************/
BOOL CALLBACK DrawTextDrawStateCallBackProc(HDC hdc, LPARAM lpData,
		WPARAM wData, int cx, int cy)
	{
	DRAWTEXTCONTEXT* pContext = (DRAWTEXTCONTEXT*)lpData;
	return DrawText(
		hdc, 
		pContext->lpString, 
		pContext->nCount, 
		pContext->lpRect, 
		pContext->uformat);
	}

/*****************************************************************************/
/* cwin_draw_disabled_text                                                   */
/*---------------------------------------------------------------------------*/
/* Draw the formatted text `lpString' containing `nCount' characters in the  */
/* rectangle `lpRect'. It formats the text according to the specified method */
/* `uFormat' (expanding tabs, justifying characters, breaking lines, and so  */
/* forth).                                                                   */
/*****************************************************************************/
int cwin_draw_disabled_text(HDC hDC, LPCTSTR lpString, int nCount, LPRECT
		lpRect, UINT uFormat)
	{
	DRAWTEXTCONTEXT drawTextContext;
	RECT rect;
	
	rect.left = 0;
	rect.top = 0;
	rect.right = lpRect->right - lpRect->left;
	rect.bottom = lpRect->bottom - lpRect->top;
	
	drawTextContext.lpString = lpString;
	drawTextContext.nCount = nCount;
	drawTextContext.lpRect = &rect;
	drawTextContext.uformat = uFormat;

	return DrawState(
		hDC, NULL,
		&DrawTextDrawStateCallBackProc, 
		(LPARAM)(&drawTextContext),	0,
		lpRect->left, lpRect->top,
		rect.right, rect.bottom,
		DST_COMPLEX | DSS_DISABLED);
	}

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
