note
	description: "Summary description for {PE_INTEGER_16_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_INTEGER_16_ITEM

inherit
	PE_ITEM
		rename
			make as make_item
		end

create
	make

convert
	value: {INTEGER_16}

feature {NONE} -- Initialization

	make (a_start_index: NATURAL_32; mp: MANAGED_POINTER; lab: like label)
		do
			make_item (a_start_index, a_start_index, a_start_index + 2, mp, lab) --{PLATFORM}.integer_16_bytes)
			value := mp.read_integer_16_le (0)
		end

feature -- Access

	value: INTEGER_16

feature -- Status report

	to_string: STRING_32
		do
			Result := "0x" + value.to_hex_string
		end

end
