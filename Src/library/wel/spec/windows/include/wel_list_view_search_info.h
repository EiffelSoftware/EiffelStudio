/*
 * WEL_LIST_VIEW_SEARCH_INFO.H
 */

#ifndef __WEL_LIST_VIEW_SEARCH_INFO__
#define __WEL_LIST_VIEW_SEARCH_INFO__

#define cwel_list_view_search_info_flags(_ptr_) (((LV_FINDINFO*) _ptr_)->flags)
#define cwel_list_view_search_info_target(_ptr_) (((LV_FINDINFO*) _ptr_)->psz)
#define cwel_list_view_search_info_lparam(_ptr_) (((LV_FINDINFO*) _ptr_)->lParam)
#define cwel_list_view_search_info_starting_position(_ptr_) (((LV_FINDINFO*) _ptr_)->pt)
#define cwel_list_view_search_info_direction(_ptr_) (((LV_FINDINFO*) _ptr_)->vkDirection)

#define cwel_list_view_search_info_set_flags(_ptr_, _value_) (((LV_FINDINFO *) _ptr_)->flags = (UINT) (_value_))
#define cwel_list_view_search_info_set_target(_ptr_, _value_) (((LV_FINDINFO *) _ptr_)->psz = (LPCTSTR) (_value_))
#define cwel_list_view_search_info_set_lparam(_ptr_, _value_) (((LV_FINDINFO *) _ptr_)->lParam = (LPARAM) (_value_))
#define cwel_list_view_search_info_set_starting_position(_ptr_, _value_) (((LV_FINDINFO *) _ptr_)->pt = (POINT ) (_value_))
#define cwel_list_view_search_info_set_direction(_ptr_, _value_) (((LV_FINDINFO *) _ptr_)->vkDirection = (UINT) (_value_))

#endif /* __WEL_LIST_VIEW_SEARCH_INFO__ */

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
