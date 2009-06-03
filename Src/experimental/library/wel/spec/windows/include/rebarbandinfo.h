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

#ifndef __WEL_REBARBANDINFO__
#define __WEL_REBARBANDINFO__

#ifndef __WEL__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_rebarbandinfo_set_cbsize(_ptr_, _value_) (((REBARBANDINFO *) _ptr_)->cbSize = (UINT) (_value_))
#define cwel_rebarbandinfo_set_fmask(_ptr_, _value_) (((REBARBANDINFO *) _ptr_)->fMask = (UINT) (_value_))
#define cwel_rebarbandinfo_set_fstyle(_ptr_, _value_) (((REBARBANDINFO *) _ptr_)->fStyle = (UINT) (_value_))
#define cwel_rebarbandinfo_set_clrfore(_ptr_, _value_) (((REBARBANDINFO *) _ptr_)->clrFore = (COLORREF) (_value_))
#define cwel_rebarbandinfo_set_clrback(_ptr_, _value_) (((REBARBANDINFO *) _ptr_)->clrBack = (COLORREF) (_value_))
#define cwel_rebarbandinfo_set_lptext(_ptr_, _value_) (((REBARBANDINFO *) _ptr_)->lpText = (LPTSTR) (_value_))
#define cwel_rebarbandinfo_set_cch(_ptr_, _value_) (((REBARBANDINFO *) _ptr_)->cch = (UINT) (_value_))
#define cwel_rebarbandinfo_set_iimage(_ptr_, _value_) (((REBARBANDINFO *) _ptr_)->iImage = (int) (_value_))
#define cwel_rebarbandinfo_set_hwndchild(_ptr_, _value_) (((REBARBANDINFO *) _ptr_)->hwndChild = (HWND) (_value_))
#define cwel_rebarbandinfo_set_cxminchild(_ptr_, _value_) (((REBARBANDINFO *) _ptr_)->cxMinChild = (UINT) (_value_))
#define cwel_rebarbandinfo_set_cyminchild(_ptr_, _value_) (((REBARBANDINFO *) _ptr_)->cyMinChild = (UINT) (_value_))
#define cwel_rebarbandinfo_set_cx(_ptr_, _value_) (((REBARBANDINFO *) _ptr_)->cx = (UINT) (_value_))
#define cwel_rebarbandinfo_set_hbmback(_ptr_, _value_) (((REBARBANDINFO *) _ptr_)->hbmBack = (HBITMAP) (_value_))
#define cwel_rebarbandinfo_set_wid(_ptr_, _value_) (((REBARBANDINFO *) _ptr_)->wID = (UINT) (_value_))

#define cwel_rebarbandinfo_get_cbsize(_ptr_) ((((REBARBANDINFO *) _ptr_)->cbSize))
#define cwel_rebarbandinfo_get_fmask(_ptr_) ((((REBARBANDINFO *) _ptr_)->fMask))
#define cwel_rebarbandinfo_get_fstyle(_ptr_) (((REBARBANDINFO *) _ptr_)->fStyle)
#define cwel_rebarbandinfo_get_clrfore(_ptr_) (((REBARBANDINFO *) _ptr_)->clrFore)
#define cwel_rebarbandinfo_get_clrback(_ptr_) (((REBARBANDINFO *) _ptr_)->clrBack)
#define cwel_rebarbandinfo_get_lptext(_ptr_) (((REBARBANDINFO *) _ptr_)->lpText)
#define cwel_rebarbandinfo_get_cch(_ptr_) (((REBARBANDINFO *) _ptr_)->cch)
#define cwel_rebarbandinfo_get_iimage(_ptr_) (((REBARBANDINFO *) _ptr_)->iImage)
#define cwel_rebarbandinfo_get_hwndchild(_ptr_) (((REBARBANDINFO *) _ptr_)->hwndChild)
#define cwel_rebarbandinfo_get_cxminchild(_ptr_) (((REBARBANDINFO *) _ptr_)->cxMinChild)
#define cwel_rebarbandinfo_get_cyminchild(_ptr_) (((REBARBANDINFO *) _ptr_)->cyMinChild)
#define cwel_rebarbandinfo_get_cx(_ptr_) (((REBARBANDINFO *) _ptr_)->cx)
#define cwel_rebarbandinfo_get_hbmback(_ptr_) (((REBARBANDINFO *) _ptr_)->hbmBack)
#define cwel_rebarbandinfo_get_wid(_ptr_) (((REBARBANDINFO *) _ptr_)->wID)

#ifdef __cplusplus
}
#endif

#endif /* __WEL_REBARBANDINFO__ */
