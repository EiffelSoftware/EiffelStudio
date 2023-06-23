note
	description: "[
			See II.23.1.5 FieldAttributes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_FIELD_ATTRIBUTES_ITEM

inherit
	PE_INTEGER_16_ITEM
		redefine
			make_from_item
		end

	PE_ATTRIBUTES_ITEM
		rename
			has_flag_16 as has_flag
		end

create
	make,
	make_from_item

convert
	value: {INTEGER_16}

feature {NONE} -- Initialization	

	make_from_item (a_item: PE_ITEM)
		do
			Precursor (a_item)
			value := pointer.read_integer_16_le (0)
		end

feature -- Status report

	to_flags_string: STRING_8
		local
			v: NATURAL_16
			t: NATURAL_16
		do
			create Result.make (0)
			v := value.to_natural_16

			if has_flag (FieldAccessMask, Private,	v) then Result.append ("Private") end
			if has_flag (FieldAccessMask, Private,	v) then add_flag_to ("Private", Result) end
			if has_flag (FieldAccessMask, Assembly,	v) then add_flag_to ("Assembly", Result) end
			if has_flag (FieldAccessMask, Public,	v) then add_flag_to ("Public", Result) end
			if has_flag (FieldAccessMask, Static,	v) then add_flag_to ("Static", Result) end
			if has_flag (FieldAccessMask, Literal,	v) then add_flag_to ("Literal", Result) end
		end

--	to_string: STRING_32
--		do
--			Result := to_flags_string + Precursor
--		end

feature -- Flags

	FieldAccessMask: NATURAL_16 = 0x0007	-- These 3 bits contain one of the following values:

	CompilerControlled: NATURAL_16 = 0x0000	-- Member not referenceable
	Private: NATURAL_16 = 0x0001	-- Accessible only by the parent type
	FamANDAssem: NATURAL_16 = 0x0002	-- Accessible by sub-types only in this Assembly
	Assembly: NATURAL_16 = 0x0003	-- Accessibly by anyone in the Assembly
	Family: NATURAL_16 = 0x0004	-- Accessible only by type and sub-types
	FamORAssem: NATURAL_16 = 0x0005	-- Accessibly by sub-types anywhere, plus anyone in assembly
	Public: NATURAL_16 = 0x0006	-- Accessibly by anyone who has visibility to this scope field contract attributes
	Static: NATURAL_16 = 0x0010	-- Defined on type, else per instance
	InitOnly: NATURAL_16 = 0x0020	-- Field can only be initialized, not written to after init
	Literal: NATURAL_16 = 0x0040	-- Value is compile time constant
	NotSerialized: NATURAL_16 = 0x0080	-- Reserved (to indicate this field should not be serialized when type is remoted)
	SpecialName: NATURAL_16 = 0x0200	-- Field is special

feature -- Interop Attributes
	PInvokeImpl: NATURAL_16 = 0x2000	-- Implementation is forwarded through PInvoke.

feature -- Additional flags
	RTSpecialName: NATURAL_16 = 0x0400	-- CLI provides 'special' behavior, depending upon the name of the field
	HasFieldMarshal: NATURAL_16 = 0x1000	-- Field has marshalling information
	HasDefault: NATURAL_16 = 0x8000	-- Field has default
	HasFieldRVA: NATURAL_16 = 0x0100	-- Field has RVA


end
