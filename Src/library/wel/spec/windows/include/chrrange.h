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

#ifndef __WEL_CHARRANGE__
#define __WEL_CHARRANGE__

#include "redit.h"

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_charrange_set_cpmin(_ptr_, _value_) (((CHARRANGE *) _ptr_)->cpMin = (LONG) (_value_))
#define cwel_charrange_set_cpmax(_ptr_, _value_) (((CHARRANGE *) _ptr_)->cpMax = (LONG) (_value_))

#define cwel_charrange_get_cpmin(_ptr_) (((CHARRANGE *) _ptr_)->cpMin)
#define cwel_charrange_get_cpmax(_ptr_) (((CHARRANGE *) _ptr_)->cpMax)

#ifdef __cplusplus
}
#endif

#endif /* __WEL_CHARRANGE__ */
