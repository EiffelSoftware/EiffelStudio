#ifndef __WEX_CLIB__
#define __WEX_CLIB__

#ifndef _eif_eiffel_h_
#	include <eif_eiffel.h>
#endif


extern "C" 
{
	EIF_INTEGER cwex_tool_bar_data_version (EIF_POINTER item);
	EIF_INTEGER cwex_tool_bar_data_width (EIF_POINTER item);
	EIF_INTEGER cwex_tool_bar_data_height (EIF_POINTER item);
	EIF_INTEGER cwex_tool_bar_data_item_count (EIF_POINTER item);
	EIF_INTEGER cwex_tool_bar_data_items (EIF_POINTER item, EIF_INTEGER index);
}

#endif