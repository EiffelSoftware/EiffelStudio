/*
 * WEL_FIND_ARGUMENT.H
 */

#ifndef __WEL_FIND_ARGUMENT__
#define __WEL_FIND_ARGUMENT__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifndef __WEL_RICHEDIT__
#   include <redit.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_findargument_set_range(_ptr_, _value_) (((FINDTEXTEX *) _ptr_)->chrg = *((CHARRANGE*) (_value_)))
#define cwel_findargument_set_string_to_find(_ptr_, _value_) (((FINDTEXTEX *) _ptr_)->lpstrText = (LPTSTR) (_value_))
#define cwel_findargument_initialize_range_out_min(_ptr_) (((FINDTEXTEX *) _ptr_)->chrgText.cpMin = (LONG)0)
#define cwel_findargument_initialize_range_out_max(_ptr_) (((FINDTEXTEX *) _ptr_)->chrgText.cpMax = (LONG)0)

#define cwel_findargument_get_range(_ptr_) (&(((FINDTEXTEX *) _ptr_)->chrg))
#define cwel_findargument_get_string_to_find(_ptr_) ((((FINDTEXTEX *) _ptr_)->lpstrText))
#define cwel_findargument_get_range_out(_ptr_) (&(((FINDTEXTEX *) _ptr_)->chrgText))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_FIND_ARGUMENT__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, ISE Building, second floor, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
