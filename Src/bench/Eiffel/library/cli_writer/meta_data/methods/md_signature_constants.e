indexing
	description: "Constants used in signature definition."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_SIGNATURE_CONSTANTS

feature -- Access

	has_current: INTEGER_8 is 0x20
	explicit_current: INTEGER_8 is 0x40
	default_sig: INTEGER_8 is 0
	vararg_sig: INTEGER_8 is 0x05
			-- Flags for signature description of methods.
			
	field_sig: INTEGER_8 is 0x06
			-- Flag for signature description of a field.
			
	local_sig: INTEGER_8 is 0x07
			-- Flag for a signature description of all locals in
			-- a method body.

	ca_prolog: INTEGER_16 is 0x0001
			-- Prolog for Custom Attribute blob.

feature -- Types

	element_type_end: INTEGER_8 is 0x0
	element_type_void: INTEGER_8 is 0x1
	element_type_boolean: INTEGER_8 is 0x2
	element_type_char: INTEGER_8 is 0x3
	element_type_i1: INTEGER_8 is 0x4
	element_type_u1: INTEGER_8 is 0x5
	element_type_i2: INTEGER_8 is 0x6
	element_type_u2: INTEGER_8 is 0x7
	element_type_i4: INTEGER_8 is 0x8
	element_type_u4: INTEGER_8 is 0x9
	element_type_i8: INTEGER_8 is 0xa
	element_type_u8: INTEGER_8 is 0xb
	element_type_r4: INTEGER_8 is 0xc
	element_type_r8: INTEGER_8 is 0xd
	element_type_string: INTEGER_8 is 0xe
		 -- Basic types.

	element_type_ptr: INTEGER_8 is 0xf
		-- PTR <type>
		-- type is a simple type.

	element_type_byref: INTEGER_8 is 0x10
		-- BYREF <type>
		-- type is a simple type.

	element_type_valuetype: INTEGER_8 is 0x11
		-- VALUETYPE <class Token>.

	element_type_class: INTEGER_8 is 0x12
		-- CLASS <class Token>.

	element_type_array: INTEGER_8 is 0x14
		-- MDARRAY <type> <rank> <bcount> <bound1> ... <lbcount> <lb1> ...

	element_type_typedbyref: INTEGER_8 is 0x16
		-- This is a simple type.

	element_type_i: INTEGER_8 is 0x18
		-- native integer size.

	element_type_u: INTEGER_8 is 0x19
		-- native unsigned integer size.

	element_type_fnptr: INTEGER_8 is 0x1B
		-- FNPTR <complete sig for the function including calling convention>.

	element_type_object: INTEGER_8 is 0x1C
		-- Shortcut for System.Object.

	element_type_szarray: INTEGER_8 is 0x1D
		-- Shortcut for single dimension zero lower bound array
		-- SZARRAY <type>

	element_type_cmod_reqd: INTEGER_8 is 0x1F
		-- required C modifier : E_T_CMOD_REQD <mdTypeRef/mdTypeDef>

	element_type_cmod_opt: INTEGER_8 is 0x20
		-- optional C modifier : E_T_CMOD_OPT <mdTypeRef/mdTypeDef>

	element_type_internal: INTEGER_8 is 0x21
		-- INTERNAL <typehandle>
		-- This is for signatures generated internally (which will not be persisted in any way).

	element_type_max: INTEGER_8 is 0x22
		-- first invalid element type
		-- Note that this is the max of base type excluding modifiers

	element_type_modifier: INTEGER_8 is 0x40
	element_type_sentinel: INTEGER_8 is 0x01
		-- ELEMENT_TYPE_MODIFIER, sentinel for varargs

	element_type_pinned: INTEGER_8 is 0x05
		-- ELEMENT_TYPE_MODIFIER,

end -- class MD_SIGNATURE_CONSTANTS
