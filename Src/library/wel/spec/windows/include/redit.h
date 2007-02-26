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

#ifndef __WEL_RICHEDIT__
#define __WEL_RICHEDIT__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifndef _RICHEDIT_
#	include <richedit.h>

/* Following statement is needed because it is defined in the above Microsoft header files
 * as being `wEffects'. However this is a breaking change in case you include `richedit.h'
 * as well as other Microsoft header files that happen to use `wReserved'.
 */
#ifdef wReserved
#undef wReserved
#endif
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_BORLAND
#define SCF_ALL			0x0004
#endif

	/* The following is to fix Microsoft continuous stories about messing up the declaration of PARAMFORMAT2
	 * among the various releases of their RichEdit.h include file. */
typedef struct _wel_paraformat2
{
	UINT	cbSize;
	DWORD	dwMask;
	WORD	wNumbering;
	WORD	wEffects;
	LONG	dxStartIndent;
	LONG	dxRightIndent;
	LONG	dxOffset;
	WORD	wAlignment;
	SHORT	cTabCount;
	LONG	rgxTabs[MAX_TAB_STOPS];
 	LONG	dySpaceBefore;			// Vertical spacing before para			
	LONG	dySpaceAfter;			// Vertical spacing after para			
	LONG	dyLineSpacing;			// Line spacing depending on Rule		
	SHORT	sStyle;					// Style handle							
	BYTE	bLineSpacingRule;		// Rule for line spacing (see tom.doc)	
	BYTE	bOutlineLevel;			// Outline Level						
	WORD	wShadingWeight;			// Shading in hundredths of a per cent	
	WORD	wShadingStyle;			// Byte 0: style, nib 2: cfpat, 3: cbpat
	WORD	wNumberingStart;		// Starting value for numbering				
	WORD	wNumberingStyle;		// Alignment, Roman/Arabic, (), ), ., etc.
	WORD	wNumberingTab;			// Space bet 1st indent and 1st-line text
	WORD	wBorderSpace;			// Border-text spaces (nbl/bdr in pts)	
	WORD	wBorderWidth;			// Pen widths (nbl/bdr in half twips)	
	WORD	wBorders;				// Border styles (nibble/border)		
} WEL_PARAFORMAT2;



#ifdef __cplusplus
}
#endif

#endif /* __WEL_RICHEDIT__ */
