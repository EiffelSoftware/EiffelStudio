/*
 * TBBUTTON.H
 */

#ifndef __WEL_TOOLBAR_BITMAP__
#define __WEL_TOOLBAR_BITMAP__

#ifndef __WEL_COMMONCONTROLS__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_tbaddbitmap_set_hinst(_ptr_,_value_) (((TBADDBITMAP *) _ptr_)->hInst = (HINSTANCE) (_value_))
#define cwel_tbaddbitmap_set_nid(_ptr_,_value_) (((TBADDBITMAP *) _ptr_)->nID = (UINT) (_value_))

#define cwel_tbaddbitmap_get_hinst(_ptr_) ((((TBADDBITMAP *) _ptr_)->hInst))
#define cwel_tbaddbitmap_get_nid(_ptr_) ((((TBADDBITMAP *) _ptr_)->nID))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_TOOLBAR_BITMAP__ */

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
