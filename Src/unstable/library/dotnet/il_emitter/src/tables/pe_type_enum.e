note
	description: "these are standard type identifiers uses in signatures"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_TYPE_ENUM

feature -- Access: Simple Type

	ELEMENT_TYPE_END: INTEGER = 0x0

	ELEMENT_TYPE_VOID: INTEGER = 0x1
	ELEMENT_TYPE_bool: INTEGER = 0x2
	ELEMENT_TYPE_CHAR: INTEGER = 0x3
	ELEMENT_TYPE_I1: INTEGER = 0x4
	ELEMENT_TYPE_U1: INTEGER = 0x5

	ELEMENT_TYPE_I2: INTEGER = 0x6
	ELEMENT_TYPE_U2: INTEGER = 0x7
	ELEMENT_TYPE_I4: INTEGER = 0x8
	ELEMENT_TYPE_U4: INTEGER = 0x9
	ELEMENT_TYPE_I8: INTEGER = 0xa

	ELEMENT_TYPE_U8: INTEGER = 0xb
	ELEMENT_TYPE_R4: INTEGER = 0xc
	ELEMENT_TYPE_R8: INTEGER = 0xd
	ELEMENT_TYPE_STRING: INTEGER = 0xe

feature -- Access: Types

	ELEMENT_TYPE_PTR: INTEGER = 0xf
			-- PTR <type>

	ELEMENT_TYPE_BYREF: INTEGER = 0x10
			-- BYREF <type>

		-- Please use ELEMENT_TYPE_VALUETYPE.

		-- ELEMENT_TYPE_VALUECLASS is deprecated.

	ELEMENT_TYPE_VALUETYPE: INTEGER = 0x11
			-- VALUETYPE <class Token>

	ELEMENT_TYPE_CLASS: INTEGER = 0x12
			-- CLASS <class Token>

	ELEMENT_TYPE_VAR: INTEGER = 0x13
			-- a class type variable VAR <U1>

	ELEMENT_TYPE_ARRAY: INTEGER = 0x14
			-- MDARRAY <type> <rank> <bcount>
			-- <bound1> ... <lbcount> <lb1> ...

	ELEMENT_TYPE_GENERICINST: INTEGER = 0x15
			-- GENERICINST <generic type> <argCnt> <arg1> ... <argn>

	ELEMENT_TYPE_TYPEDBYREF: INTEGER = 0x16
			-- TYPEDREF  (it takes no args) a typed referece to some other type

	ELEMENT_TYPE_I: INTEGER = 0x18
			-- native integer size

	ELEMENT_TYPE_U: INTEGER = 0x19
			-- native DWord integer size

	ELEMENT_TYPE_FNPTR: INTEGER = 0x1B
			-- FNPTR <complete sig for the function
			-- including calling convention>

	ELEMENT_TYPE_OBJECT: INTEGER = 0x1C
			-- Shortcut for System.Object

	ELEMENT_TYPE_SZARRAY: INTEGER = 0x1D
			-- Shortcut for single dimension zero lower bound array
			-- SZARRAY <type>

	ELEMENT_TYPE_MVAR: INTEGER = 0x1e
			-- a method type variable MVAR <U1>

	ELEMENT_TYPE_CMOD_REQD: INTEGER = 0x1F
			-- This is only for binding
			-- required C modifier : E_T_CMOD_REQD <mdTypeRef/mdTypeDef>

	ELEMENT_TYPE_CMOD_OPT: INTEGER = 0x20
			-- optional C modifier : E_T_CMOD_OPT <mdTypeRef/mdTypeDef>

	ELEMENT_TYPE_INTERNAL: INTEGER = 0x21
			-- This is for signatures generated internally
			-- (which will not be persisted in any way).
			-- INTERNAL <typehandle>

	ELEMENT_TYPE_MAX: INTEGER = 0x22
			-- Note that this is the max of base type excluding modifiers

	ELEMENT_TYPE_MODIFIER: INTEGER = 0x40
			-- first invalid element type

	ELEMENT_TYPE_SENTINEL: INTEGER
			-- sentinel for varargs
		do
			Result := 0x01 | ELEMENT_TYPE_MODIFIER
		ensure
			instance_free: class
		end

	ELEMENT_TYPE_PINNED: INTEGER
		do
			Result := 0x05 | ELEMENT_TYPE_MODIFIER
		ensure
			instance_free: class
		end

	ELEMENT_TYPE_R4_HFA: INTEGER
			-- used only internally for R4 HFA types
		do
			Result := 0x01 | ELEMENT_TYPE_MODIFIER
		ensure
			instance_free: class
		end

	ELEMENT_TYPE_R8_HFA: INTEGER
			-- used only internally for R8 HFA types
		do
			Result := 0x07 | ELEMENT_TYPE_MODIFIER
		end

END
