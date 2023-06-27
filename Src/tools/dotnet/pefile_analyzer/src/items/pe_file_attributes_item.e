note
	description: "[
			See II.23.1.6 FileAttributes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_FILE_ATTRIBUTES_ITEM

inherit
	PE_INTEGER_32_ITEM
		redefine
			make_from_item
		end

	PE_ATTRIBUTES_ITEM
		rename
			has_flag_32 as has_flag
		end

create
	make,
	make_from_item

convert
	value: {INTEGER_32}

feature {NONE} -- Initialization	

	make_from_item (a_item: PE_ITEM)
		do
			Precursor (a_item)
			value := pointer.read_integer_32_le (0)
		end

feature -- Status report

	to_flags_string: STRING_8
		local
			v: NATURAL_32
		do
			create Result.make (0)
			v := value.to_natural_32

			if has_flag (0x0, ContainsMetaData,	v) then add_flag_to ("ContainsMetaData", Result) end
			if has_flag (0x0, ContainsNoMetaData,	v) then add_flag_to ("ContainsMetaData", Result) end
		end

--	to_string: STRING_32
--		do
--			Result := to_flags_string + Precursor
--		end

feature -- Flags

	ContainsMetaData: NATURAL_16 = 0x0000
	ContainsNoMetaData: NATURAL_16 = 0x0001

end
