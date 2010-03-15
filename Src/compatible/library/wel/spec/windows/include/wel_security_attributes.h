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

#ifndef __WEL_SECURITY_ATTRIBUTES__
#define __WEL_SECURITY_ATTRIBUTES__

#ifdef __cplusplus
extern "C" {
#endif

#define cwel_security_attributes_set_length(_ptr_, _value_) (((SECURITY_ATTRIBUTES *) _ptr_)->nLength = (DWORD) (_value_))
#define cwel_security_attributes_set_security_descriptor(_ptr_, _value_) (((SECURITY_ATTRIBUTES *) _ptr_)->lpSecurityDescriptor = (LPVOID) (_value_))
#define cwel_security_attributes_set_inherit_handle(_ptr_, _value_) (((SECURITY_ATTRIBUTES *) _ptr_)->bInheritHandle = (BOOL) (_value_))

#define cwel_security_attributes_get_inherit_handle(_ptr_) ((((SECURITY_ATTRIBUTES *) _ptr_)->bInheritHandle))

#ifdef __cplusplus
}
#endif

#endif /* __WEL_SECURITY_ATTRIBUTES__ */
