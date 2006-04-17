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

#ifndef __WEL_TRACK_MOUSE_EVENT__
#define __WEL_TRACK_MOUSE_EVENT__

#ifndef __WEL_COMMONCONTROLS__
#	include <cctrl.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_trackmouseevent_get_cbsize(_ptr_) ((((TRACKMOUSEEVENT *) _ptr_)->cbSize))
#define cwel_trackmouseevent_get_hwndtrack(_ptr_) ((((TRACKMOUSEEVENT *) _ptr_)->hwndTrack))
#define cwel_trackmouseevent_get_dwflags(_ptr_) ((((TRACKMOUSEEVENT *) _ptr_)->dwFlags))
#define cwel_trackmouseevent_get_dwhovertime(_ptr_) ((((TRACKMOUSEEVENT *) _ptr_)->dwHoverTime))

#define cwel_trackmouseevent_set_hwndtrack(_ptr_, _value_) (((TRACKMOUSEEVENT *) _ptr_)->hwndTrack = (_value_))
#define cwel_trackmouseevent_set_cbsize(_ptr_, _value_) (((TRACKMOUSEEVENT *) _ptr_)->cbSize = (_value_))
#define cwel_trackmouseevent_set_dwflags(_ptr_, _value_) (((TRACKMOUSEEVENT *) _ptr_)->dwFlags = (_value_))
#define cwel_trackmouseevent_set_dwhovertime(_ptr_, _value_) (((TRACKMOUSEEVENT *) _ptr_)->dwHoverTime = (_value_))


#ifdef __cplusplus
}
#endif

#endif /* __WEL_TRACK_MOUSE_EVENT__ */
