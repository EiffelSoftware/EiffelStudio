/*
 * WEL_SECURITY_ATTRIBUTES.H
 */

#ifndef __WEL_SECURITY_ATTRIBUTES__
#define __WEL_SECURITY_ATTRIBUTES__

#define cwel_security_attributes_set_length(_ptr_, _value_) (((SECURITY_ATTRIBUTES *) _ptr_)->nLength = (DWORD) (_value_))
#define cwel_security_attributes_set_security_descriptor(_ptr_, _value_) (((SECURITY_ATTRIBUTES *) _ptr_)->lpSecurityDescriptor = (LPVOID) (_value_))
#define cwel_security_attributes_set_inherit_handle(_ptr_, _value_) (((SECURITY_ATTRIBUTES *) _ptr_)->bInheritHandle = (BOOL) (_value_))

#define cwel_security_attributes_get_inherit_handle(_ptr_) ((((SECURITY_ATTRIBUTES *) _ptr_)->bInheritHandle))

#endif /* __WEL_SECURITY_ATTRIBUTES__ */

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