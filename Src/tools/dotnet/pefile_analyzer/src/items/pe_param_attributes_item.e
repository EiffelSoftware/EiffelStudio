note
	description: "[
			See II.23.1.13 ParamAttributes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_PARAM_ATTRIBUTES_ITEM

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
		do
			create Result.make (0)
			v := value.to_natural_16

			if has_flag (0x0, In,	v) then add_flag_to ("In", Result) end
			if has_flag (0x0, Out_,	v) then add_flag_to ("Out", Result) end
			if has_flag (0x0, Optional,	v) then add_flag_to ("Optional", Result) end
			if has_flag (0x0, HasDefault,	v) then add_flag_to ("HasDefault", Result) end
			if has_flag (0x0, HasFieldMarshal,	v) then add_flag_to ("HasFieldMarshal", Result) end
			if has_flag (0x0, Unused,	v) then add_flag_to ("Unused", Result) end
		end

--	to_string: STRING_32
--		do
--			Result := to_flags_string + Precursor
--		end

feature -- Flags

	In: NATURAL_16 = 0x0001	-- Param is [In]
	Out_: NATURAL_16 = 0x0002	-- Param is [out]
	Optional: NATURAL_16 = 0x0010	-- Param is optional
	HasDefault: NATURAL_16 = 0x1000	-- Param has default value
	HasFieldMarshal: NATURAL_16 = 0x2000	-- Param has FieldMarshal
	Unused: NATURAL_16 = 0xcfe0	-- Reserved: shall be zero in a conforming implementatio

end
