/*
 * HD_HIT_TEST_INFO.H
 */

#ifndef __WEL_HD_HIT_TEST_INFO__
#define __WEL_HD_HIT_TEST_INFO__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_hd_hit_test_info_set_pt_x(_ptr_, _value_) (((HD_HITTESTINFO *) _ptr_)->pt.x = (LONG) _value_)
#define cwel_hd_hit_test_info_get_pt_x(_ptr_) ((EIF_INTEGER)(((HD_HITTESTINFO *) _ptr_)->pt.x))

#define cwel_hd_hit_test_info_set_pt_y(_ptr_, _value_) (((HD_HITTESTINFO *) _ptr_)->pt.y = (LONG) _value_)
#define cwel_hd_hit_test_info_get_pt_y(_ptr_) ((EIF_INTEGER)(((HD_HITTESTINFO *) _ptr_)->pt.y))

#define cwel_hd_hit_test_info_set_flags(_ptr_, _value_) (((HD_HITTESTINFO *) _ptr_)->flags = (UINT) _value_)
#define cwel_hd_hit_test_info_get_flags(_ptr_) ((EIF_INTEGER)(((HD_HITTESTINFO *) _ptr_)->flags))

#define cwel_hd_hit_test_info_set_i_item(_ptr_, _value_) (((HD_HITTESTINFO *) _ptr_)->iItem = (int) _value_)
#define cwel_hd_hit_test_info_get_i_item(_ptr_) ((EIF_INTEGER)(((HD_HITTESTINFO *) _ptr_)->iItem))


#ifdef __cplusplus
}
#endif


#endif /* __WEL_HD_HIT_TEST_INFO__ */

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
