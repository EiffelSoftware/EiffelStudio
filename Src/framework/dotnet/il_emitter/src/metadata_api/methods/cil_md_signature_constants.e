note
	description: "Constants used in signature definition."
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_MD_SIGNATURE_CONSTANTS


feature -- Access

	has_current: INTEGER_8 = 0x20
	explicit_current: INTEGER_8 = 0x40
	default_sig: INTEGER_8 = 0
	vararg_sig: INTEGER_8 = 0x05
			-- Flags for signature description of methods.

	field_sig: INTEGER_8 = 0x06
			-- Flag for signature description of a field.

	local_sig: INTEGER_8 = 0x07
			-- Flag for a signature description of all locals in
			-- a method body.

	property_sig: INTEGER_8 = 0x08
			-- Flag for signature description of a property.

	ca_prolog: INTEGER_16 = 0x0001
			-- Prolog for Custom Attribute blob.

feature -- Types

	element_type_end: INTEGER_8 = 0x0
	element_type_void: INTEGER_8 = 0x1
	element_type_boolean: INTEGER_8 = 0x2
	element_type_char: INTEGER_8 = 0x3
	element_type_i1: INTEGER_8 = 0x4
	element_type_u1: INTEGER_8 = 0x5
	element_type_i2: INTEGER_8 = 0x6
	element_type_u2: INTEGER_8 = 0x7
	element_type_i4: INTEGER_8 = 0x8
	element_type_u4: INTEGER_8 = 0x9
	element_type_i8: INTEGER_8 = 0xa
	element_type_u8: INTEGER_8 = 0xb
	element_type_r4: INTEGER_8 = 0xc
	element_type_r8: INTEGER_8 = 0xd
	element_type_string: INTEGER_8 = 0xe
		 -- Basic types.

	element_type_ptr: INTEGER_8 = 0xf
		-- PTR <type>
		-- type is a simple type.

	element_type_byref: INTEGER_8 = 0x10
		-- BYREF <type>
		-- type is a simple type.

	element_type_valuetype: INTEGER_8 = 0x11
		-- VALUETYPE <class Token>.

	element_type_class: INTEGER_8 = 0x12
		-- CLASS <class Token>.

	element_type_array: INTEGER_8 = 0x14
		-- MDARRAY <type> <rank> <bcount> <bound1> ... <lbcount> <lb1> ...

	element_type_typedbyref: INTEGER_8 = 0x16
		-- This is a simple type.

	element_type_i: INTEGER_8 = 0x18
		-- native integer size.

	element_type_u: INTEGER_8 = 0x19
		-- native unsigned integer size.

	element_type_fnptr: INTEGER_8 = 0x1B
		-- FNPTR <complete sig for the function including calling convention>.

	element_type_object: INTEGER_8 = 0x1C
		-- Shortcut for System.Object.

	element_type_szarray: INTEGER_8 = 0x1D
		-- Shortcut for single dimension zero lower bound array
		-- SZARRAY <type>

	element_type_cmod_reqd: INTEGER_8 = 0x1F
		-- required C modifier : E_T_CMOD_REQD <mdTypeRef/mdTypeDef>

	element_type_cmod_opt: INTEGER_8 = 0x20
		-- optional C modifier : E_T_CMOD_OPT <mdTypeRef/mdTypeDef>

	element_type_internal: INTEGER_8 = 0x21
		-- INTERNAL <typehandle>
		-- This is for signatures generated internally (which will not be persisted in any way).

	element_type_max: INTEGER_8 = 0x22
		-- first invalid element type
		-- Note that this is the max of base type excluding modifiers

	element_type_modifier: INTEGER_8 = 0x40
	element_type_sentinel: INTEGER_8 = 0x01
		-- ELEMENT_TYPE_MODIFIER, sentinel for varargs

	element_type_pinned: INTEGER_8 = 0x05
		-- ELEMENT_TYPE_MODIFIER

feature -- Custom attribute flags

	element_type_type: INTEGER_8 = 0x50
		-- No name in CLI standard. Used for custom attributes representing
		-- a System.Type instance.

	element_type_boxed: INTEGER_8 = 0x51
		-- No name in CLI standard. Used for custom attributes representing
		-- a boxed object.

	element_type_field: INTEGER_8 = 0x53
		-- No name in CLI standard. Used for custom attributes representing
		-- a field setting.

	element_type_property: INTEGER_8 = 0x54
		-- No name in CLI standard. Used for custom attributes representing
		-- a property setting.

	element_type_enum: INTEGER_8 = 0x55
		-- No name in CLI standard. Used for custom attributes representing
		-- an enum type instance.

feature -- Native types

	native_type_end: INTEGER_8 = 0x0
			-- DEPRECATED

	native_type_void: INTEGER_8 = 0x1
			-- DEPRECATED

	native_type_boolean: INTEGER_8 = 0x2
			-- (4 byte boolean value: TRUE = non-zero, FALSE = 0)

	native_type_i1: INTEGER_8 = 0x3

	native_type_u1: INTEGER_8 = 0x4

	native_type_i2: INTEGER_8 = 0x5

	native_type_u2: INTEGER_8 = 0x6

	native_type_i4: INTEGER_8 = 0x7

	native_type_u4: INTEGER_8 = 0x8

	native_type_i8: INTEGER_8 = 0x9

	native_type_u8: INTEGER_8 = 0xa

	native_type_r4: INTEGER_8 = 0xb

	native_type_r8: INTEGER_8 = 0xc

	native_type_syschar: INTEGER_8 = 0xd
			-- DEPRECATED

	native_type_variant: INTEGER_8 = 0xe
			-- DEPRECATED

	native_type_currency: INTEGER_8 = 0xf

	native_type_ptr: INTEGER_8 = 0x10
			-- DEPRECATED

	native_type_decimal: INTEGER_8 = 0x11
			-- DEPRECATED

	native_type_date: INTEGER_8 = 0x12
			-- DEPRECATED

	native_type_bstr: INTEGER_8 = 0x13

	native_type_lpstr: INTEGER_8 = 0x14

	native_type_lpwstr: INTEGER_8 = 0x15

	native_type_lptstr: INTEGER_8 = 0x16

	native_type_fixedsysstring: INTEGER_8 = 0x17

	native_type_objectref: INTEGER_8 = 0x18
			-- DEPRECATED

	native_type_iunknown: INTEGER_8 = 0x19

	native_type_idispatch: INTEGER_8 = 0x1a

	native_type_struct: INTEGER_8 = 0x1b

	native_type_intf: INTEGER_8 = 0x1c

	native_type_safearray: INTEGER_8 = 0x1d

	native_type_fixedarray: INTEGER_8 = 0x1e

	native_type_int: INTEGER_8 = 0x1f

	native_type_uint: INTEGER_8 = 0x20

	native_type_nestedstruct: INTEGER_8 = 0x21
			-- DEPRECATED (use NATIVE_TYPE_STRUCT)	

	native_type_byvalstr: INTEGER_8 = 0x22

	native_type_ansibstr: INTEGER_8 = 0x23

	native_type_tbstr: INTEGER_8 = 0x24
			-- select BSTR or ANSIBSTR depending on platform

	native_type_variantbool: INTEGER_8 = 0x25
			-- (2-byte boolean value: TRUE = -1, FALSE = 0)

	native_type_func: INTEGER_8 = 0x26

	native_type_asany: INTEGER_8 = 0x28

	native_type_array: INTEGER_8 = 0x2a

	native_type_lpstruct: INTEGER_8 = 0x2b

	native_type_custommarshaler: INTEGER_8 = 0x2c
			--	Custom marshaler native type. This must be followed
			-- by a string of the following format:
			-- "Native type name/0Custom marshaler type name/0Optional cookie/0"
			-- Or
			-- "{Native type GUID}/0Custom marshaler type name/0Optional cookie/0"

	native_type_error: INTEGER_8 = 0x2d
			-- This native type coupled with ELEMENT_TYPE_I4 will map to VT_HRESULT

	native_type_max: INTEGER_8 = 0x50;
			-- first invalid element type

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CIL_MD_SIGNATURE_CONSTANTS
