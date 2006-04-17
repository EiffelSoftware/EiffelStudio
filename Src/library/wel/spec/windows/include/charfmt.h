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

#ifndef __WEL_CHARFORMAT__
#define __WEL_CHARFORMAT__

#ifndef __WEL_RICHEDIT__
#	include <redit.h>
#endif

#include <tchar.h>

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_charformat_set_cbsize(_ptr_, _value_) (((CHARFORMAT *) _ptr_)->cbSize = (UINT) (_value_))
#define cwel_charformat_set_dwmask(_ptr_, _value_) (((CHARFORMAT *) _ptr_)->dwMask = (DWORD) (_value_))
#define cwel_charformat_set_dweffects(_ptr_, _value_) (((CHARFORMAT *) _ptr_)->dwEffects = (DWORD) (_value_))
#define cwel_charformat_set_yheight(_ptr_, _value_) (((CHARFORMAT *) _ptr_)->yHeight = (LONG) (_value_))
#define cwel_charformat_set_yoffset(_ptr_, _value_) (((CHARFORMAT *) _ptr_)->yOffset = (LONG) (_value_))
#define cwel_charformat_set_crtextcolor(_ptr_, _value_) (((CHARFORMAT *) _ptr_)->crTextColor = (COLORREF) (_value_))
#define cwel_charformat_set_bcharset(_ptr_, _value_) (((CHARFORMAT *) _ptr_)->bCharSet = (BYTE) (_value_))
#define cwel_charformat_set_bpitchandfamily(_ptr_, _value_) (((CHARFORMAT *) _ptr_)->bPitchAndFamily = (BYTE) (_value_))
#define cwel_charformat_set_szfacename(_ptr_, _value_) (_tcsncpy(((CHARFORMAT *) _ptr_)->szFaceName, (TCHAR *) (_value_), LF_FACESIZE))

#define cwel_charformat_get_dwmask(_ptr_) ((((CHARFORMAT *) _ptr_)->dwMask))
#define cwel_charformat_get_dweffects(_ptr_) ((((CHARFORMAT *) _ptr_)->dwEffects))
#define cwel_charformat_get_yheight(_ptr_) ((((CHARFORMAT *) _ptr_)->yHeight))
#define cwel_charformat_get_yoffset(_ptr_) ((((CHARFORMAT *) _ptr_)->yOffset))
#define cwel_charformat_get_crtextcolor(_ptr_) ((((CHARFORMAT *) _ptr_)->crTextColor))
#define cwel_charformat_get_bcharset(_ptr_) ((((CHARFORMAT *) _ptr_)->bCharSet))
#define cwel_charformat_get_bpitchandfamily(_ptr_) ((((CHARFORMAT *) _ptr_)->bPitchAndFamily))
#define cwel_charformat_get_szfacename(_ptr_) ((((CHARFORMAT *) _ptr_)->szFaceName))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_CHARFORMAT__ */
