/*
 * WEL_STRING.H
 */

#ifndef __WEL_STRING__
#define __WEL_STRING__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

/* Macro mostly used for the EM_GETLINE message */
#define cwel_set_size_in_string(ptr,n) (*((WORD *) (ptr)) = (WORD) (n))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_STRING__ */

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
