/*
 * MINMAXI.H
 */

#ifndef __WEL_MINMAXINFO__
#define __WEL_MINMAXINFO__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_minmaxinfo_set_maxsize(_ptr_, _value_) (((MINMAXINFO *) _ptr_)->ptMaxSize = (*(POINT *) (_value_)))
#define cwel_minmaxinfo_set_maxposition(_ptr_, _value_) (((MINMAXINFO *) _ptr_)->ptMaxPosition = (*(POINT *) (_value_)))
#define cwel_minmaxinfo_set_mintracksize(_ptr_, _value_) (((MINMAXINFO *) _ptr_)->ptMinTrackSize = (*(POINT *) (_value_)))
#define cwel_minmaxinfo_set_maxtracksize(_ptr_, _value_) (((MINMAXINFO *) _ptr_)->ptMaxTrackSize = (*(POINT *) (_value_)))

#define cwel_minmaxinfo_get_maxsize(_ptr_) (&(((MINMAXINFO *) _ptr_)->ptMaxSize))
#define cwel_minmaxinfo_get_maxposition(_ptr_) (&(((MINMAXINFO *) _ptr_)->ptMaxPosition))
#define cwel_minmaxinfo_get_mintracksize(_ptr_) (&(((MINMAXINFO *) _ptr_)->ptMinTrackSize))
#define cwel_minmaxinfo_get_maxtracksize(_ptr_) (&(((MINMAXINFO *) _ptr_)->ptMaxTrackSize))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_MINMAXINFO__ */

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
