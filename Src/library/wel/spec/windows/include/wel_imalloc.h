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

#ifndef __WEL_IMALLOC__
#define __WEL_IMALLOC__

#include <objbase.h>

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
