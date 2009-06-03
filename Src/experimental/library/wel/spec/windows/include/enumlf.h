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
