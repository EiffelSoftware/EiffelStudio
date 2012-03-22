#include "font.h"

EIF_POINTER xm_font_list_init_font_context (EIF_POINTER a_font_list)
{
		/* 
		 * Initialize the font context from `a_font_list'
		 */

	XmFontContext fontCont;

	if (XmFontListInitFontContext (&fontCont, (XmFontList) a_font_list))
		return (EIF_POINTER) fontCont;

	return NULL;
}

EIF_POINTER x_build_font_from_set (EIF_POINTER p)
{
	int result;
	XFontStruct **font_list;
	char **name_list;

	result = XFontsOfFontSet ((XFontSet) p, &font_list, &name_list);	
	
	return (EIF_POINTER) font_list [0];
}

