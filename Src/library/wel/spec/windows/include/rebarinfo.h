/*
 * REBARINFO.H
 */

#ifndef __WEL_REBARINFO__
#define __WEL_REBARINFO__

#ifndef __WEL__
#	include <cctrl.h>
#endif


#define cwel_rebarinfo_set_cbsize(_ptr_, _value_) (((REBARINFO *) _ptr_)->cbSize = (UINT) (_value_))
#define cwel_rebarinfo_set_fmask(_ptr_, _value_) (((REBARINFO *) _ptr_)->fMask = (UINT) (_value_))
#define cwel_rebarinfo_set_himl(_ptr_, _value_) (((REBARINFO *) _ptr_)->himl = (HIMAGELIST) (_value_))

#define cwel_rebarinfo_get_cbsize(_ptr_) ((((REBARINFO *) _ptr_)->cbSize))
#define cwel_rebarinfo_get_fmask(_ptr_) ((((REBARINFO *) _ptr_)->fMask))
#define cwel_rebarinfo_get_himl(_ptr_) ((((REBARINFO *) _ptr_)->himl))

#endif /* __WEL_REBARINFO__ */

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
