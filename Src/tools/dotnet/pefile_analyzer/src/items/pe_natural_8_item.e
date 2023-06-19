note
	description: "Summary description for {PE_NATURAL_8_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_NATURAL_8_ITEM

inherit
	PE_ITEM
		rename
			make as make_item
		end

create
	make

convert
	value: {NATURAL_8}

feature {NONE} -- Initialization

	make (a_start_index: NATURAL_32; mp: MANAGED_POINTER; lab: like label)
		do
			make_item (a_start_index, a_start_index, a_start_index + 1, mp, lab) --{PLATFORM}.natural_8_bytes)
			value := mp.read_natural_8_le (0)
		end

feature -- Access

	value: NATURAL_8

feature -- Status report

	to_string: STRING_32
		do
			Result := "0x" + value.to_hex_string
		end

end
