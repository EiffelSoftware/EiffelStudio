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
