/*
 * TRACKMOUSEEVENT.H
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

#define cwel_trackmouseevent_set_hwndtrack(_ptr_, _value_) (((TRACKMOUSEEVENT *) _ptr_)->hwndTrack = (HWND) (_value_))
#define cwel_trackmouseevent_set_cbsize(_ptr_, _value_) (((TRACKMOUSEEVENT *) _ptr_)->cbSize = (HWND) (_value_))
#define cwel_trackmouseevent_set_dwflags(_ptr_, _value_) (((TRACKMOUSEEVENT *) _ptr_)->dwFlags = (UINT) (_value_))
#define cwel_trackmouseevent_set_dwhovertime(_ptr_, _value_) (((TRACKMOUSEEVENT *) _ptr_)->dwHoverTime = (UINT) (_value_))


#ifdef __cplusplus
}
#endif

#endif /* __WEL_TRACK_MOUSE_EVENT__ */

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
