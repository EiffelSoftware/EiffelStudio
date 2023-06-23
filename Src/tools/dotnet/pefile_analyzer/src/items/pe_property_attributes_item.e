note
	description: "[
			See II.23.1.14 PropertyAttributes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_PROPERTY_ATTRIBUTES_ITEM

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

			if has_flag (0x0, SpecialName,	v) then add_flag_to ("SpecialName", Result) end
			if has_flag (0x0, RTSpecialName,v) then add_flag_to ("RTSpecialName", Result) end
			if has_flag (0x0, HasDefault,	v) then add_flag_to ("HasDefault", Result) end
			if has_flag (0x0, Unused,		v) then add_flag_to ("Unused", Result) end
		end

--	to_string: STRING_32
--		do
--			Result := to_flags_string + Precursor
--		end

feature -- Flags

	SpecialName: NATURAL_16 = 0x0200	-- Property is special
	RTSpecialName: NATURAL_16 = 0x0400	-- Runtime(metadata internal APIs) should check name encoding
	HasDefault: NATURAL_16 = 0x1000	-- Property has default
	Unused: NATURAL_16 = 0xe9ff	-- Reserved: shall be zero in a conforming implementation

end
