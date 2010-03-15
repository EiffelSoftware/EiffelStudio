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

#ifndef __WEL_HD_NOTIFY__
#define __WEL_HD_NOTIFY__

#ifndef __WEL__
#	include <wel.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_hd_notify_get_hdr(_ptr_) (&(((HD_NOTIFY *) _ptr_)->hdr))

#define cwel_hd_notify_set_i_item(_ptr_, _value_) (((HD_NOTIFY *) _ptr_)->iItem = (int) _value_)
#define cwel_hd_notify_get_i_item(_ptr_) ((EIF_INTEGER)(((HD_NOTIFY *) _ptr_)->iItem))

#define cwel_hd_notify_set_i_button(_ptr_, _value_) (((HD_NOTIFY *) _ptr_)->iButton = (int) _value_)
#define cwel_hd_notify_get_i_button(_ptr_) ((EIF_INTEGER)(((HD_NOTIFY *) _ptr_)->iButton))

#define cwel_hd_notify_set_p_item(_ptr_, _value_) (((HD_NOTIFY *) _ptr_)->pitem = (HD_ITEM FAR*) _value_)
#define cwel_hd_notify_get_p_item(_ptr_) ((EIF_POINTER)(((HD_NOTIFY *) _ptr_)->pitem))


#ifdef __cplusplus
}
#endif


#endif /* __WEL_HD_NOTIFY__ */
