
#ifndef __WEX_CLIB__
#	include "cwex.h"
#endif

struct CToolBarData
{
	WORD wVersion;
	WORD wWidth;
	WORD wHeight;
	WORD wItemCount;

	WORD* items()
		{ return (WORD*)(this+1); }
};

EIF_INTEGER cwex_tool_bar_data_version (EIF_POINTER item)
{
	CToolBarData* pData = (CToolBarData*) item;
	return (EIF_INTEGER) (pData->wVersion);
}
EIF_INTEGER cwex_tool_bar_data_width (EIF_POINTER item)
{
	CToolBarData* pData = (CToolBarData*) item;
	return (EIF_INTEGER) (pData->wWidth);
}

EIF_INTEGER cwex_tool_bar_data_height (EIF_POINTER item)
{
	CToolBarData* pData = (CToolBarData*) item;
	return (EIF_INTEGER) (pData->wHeight);
}
EIF_INTEGER cwex_tool_bar_data_item_count (EIF_POINTER item)
{
	CToolBarData* pData = (CToolBarData*) item;
	return (EIF_INTEGER) (pData->wItemCount);
}
EIF_INTEGER cwex_tool_bar_data_items (EIF_POINTER item, EIF_INTEGER index)
{
	CToolBarData* pData = (CToolBarData*) item;
	return (EIF_INTEGER) (pData->items()[index]);
}



