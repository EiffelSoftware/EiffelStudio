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
