/*
 * TBBUTTON.H
 */

#ifndef __WEL_TOOLBAR_BUTTON__
#define __WEL_TOOLBAR_BUTTON__

#ifndef __WEL_COMMONCONTROLS__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_tbbutton_set_ibitmap(_ptr_,_value_) (((TBBUTTON *) _ptr_)->iBitmap = (int) (_value_))
#define cwel_tbbutton_set_idcommand(_ptr_,_value_) (((TBBUTTON *) _ptr_)->idCommand = (int) (_value_))
#define cwel_tbbutton_set_fsstate(_ptr_,_value_) (((TBBUTTON *) _ptr_)->fsState = (int) (_value_))
#define cwel_tbbutton_set_fsstyle(_ptr_,_value_) (((TBBUTTON *) _ptr_)->fsStyle = (int) (_value_))
#define cwel_tbbutton_set_dwdata(_ptr_,_value_) (((TBBUTTON *) _ptr_)->dwData = (int) (_value_))
#define cwel_tbbutton_set_istring(_ptr_,_value_) (((TBBUTTON *) _ptr_)->iString = (int) (_value_))

#define cwel_tbbutton_get_ibitmap(_ptr_) ((((TBBUTTON *) _ptr_)->iBitmap))
#define cwel_tbbutton_get_idcommand(_ptr_) ((((TBBUTTON *) _ptr_)->idCommand))
#define cwel_tbbutton_get_fsstate(_ptr_) ((((TBBUTTON *) _ptr_)->fsState))
#define cwel_tbbutton_get_fsstyle(_ptr_) ((((TBBUTTON *) _ptr_)->fsStyle))
#define cwel_tbbutton_get_dwdata(_ptr_) ((((TBBUTTON *) _ptr_)->dwData))
#define cwel_tbbutton_get_istring(_ptr_) ((((TBBUTTON *) _ptr_)->iString))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_TOOLBAR_BUTTON__ */

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
