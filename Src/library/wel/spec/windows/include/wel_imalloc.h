/*
 * WEL_IMALLOC.H
 */

#ifndef __WEL_IMALLOC__
#define __WEL_IMALLOC__

#include <objidl.h>

#ifndef __cplusplus

	#define cwel_imalloc_alloc(_ptr_, _value_) (((*(LPMALLOC*) _ptr_)->lpVtbl->Alloc(_ptr_,_value_)))
	#define cwel_imalloc_realloc(_ptr_, _value1_, _value2_) ((((LPMALLOC) _ptr_)->lpVtbl->Realloc(_ptr_,_value1_, _value2_)))
	#define cwel_imalloc_did_alloc(_ptr_, _value_) (((*(LPMALLOC*) _ptr_)->lpVtbl->DidAlloc(_ptr_,_value_)))
	#define cwel_imalloc_get_size(_ptr_, _value_) (((*(LPMALLOC*) _ptr_)->lpVtbl->GetSize(_ptr_,_value_)))
	#define cwel_imalloc_free(_ptr_, _value_) (((*(LPMALLOC*) _ptr_)->lpVtbl->Free(_ptr_,_value_)))
	#define cwel_imalloc_release(_ptr_) (((*(LPMALLOC*) _ptr_)->lpVtbl->Release(_ptr_)))

#else

	#define cwel_imalloc_alloc(_ptr_, _value_) (((*(LPMALLOC*) _ptr_)->Alloc(_value_)))
	#define cwel_imalloc_realloc(_ptr_, _value1_, _value2_) ((((LPMALLOC) _ptr_)->Realloc(_value1_, _value2_)))
	#define cwel_imalloc_did_alloc(_ptr_, _value_) (((*(LPMALLOC*) _ptr_)->DidAlloc(_value_)))
	#define cwel_imalloc_get_size(_ptr_, _value_) (((*(LPMALLOC*) _ptr_)->GetSize(_value_)))
	#define cwel_imalloc_free(_ptr_, _value_) (((*(LPMALLOC*) _ptr_)->Free(_value_)))
	#define cwel_imalloc_release(_ptr_) (((*(LPMALLOC*) _ptr_)->Release()))

#endif /* __cplusplus */
#endif /* __WEL_IMALLOC__ */

/*
--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1999, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
*/
