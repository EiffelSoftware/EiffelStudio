/*
 * ENUMLF.H
 */

#ifndef __WEL_ENUMLOGFONT__
#define __WEL_ENUMLOGFONT__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_enumlogfont_get_elflogfont(_ptr_) (&(((ENUMLOGFONT *) _ptr_)->elfLogFont))
#define cwel_enumlogfont_get_elffullname(_ptr_) ((((ENUMLOGFONT *) _ptr_)->elfFullName))
#define cwel_enumlogfont_get_elfstyle(_ptr_) ((((ENUMLOGFONT *) _ptr_)->elfStyle))


#ifdef __cplusplus
}
#endif

#endif /* __WEL_ENUMLOGFONT__ */

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
