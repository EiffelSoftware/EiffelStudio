note
	description: "Summary description for {PE_INTEGER_32_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_INTEGER_32_ITEM

inherit
	PE_ITEM
		rename
			make as make_item
		end

create
	make

convert
	value: {INTEGER_32}

feature {NONE} -- Initialization

	make (a_start_index: NATURAL_32; mp: MANAGED_POINTER; lab: like label)
		do
			make_item (a_start_index, a_start_index, a_start_index + 2, mp, lab) --{PLATFORM}.integer_32_bytes)
			value := mp.read_integer_32_le (0)
		end

feature -- Access

	value: INTEGER_32

	binary_byte_size: NATURAL_32 = 4

feature -- Status report

	to_string: STRING_32
		do
			Result := "0x" + value.to_hex_string
		end

end
