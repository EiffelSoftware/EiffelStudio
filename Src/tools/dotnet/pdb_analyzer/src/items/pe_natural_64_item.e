note
	description: "Summary description for {PE_NATURAL_64_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_NATURAL_64_ITEM

inherit
	PE_ITEM
		rename
			make as make_item
		end

create
	make

convert
	value: {NATURAL_64}

feature {NONE} -- Initialization

	make (a_start_index: NATURAL_32; mp: MANAGED_POINTER; lab: like label)
		do
			make_item (a_start_index, a_start_index, a_start_index + 8, mp, lab) --{PLATFORM}.natural_64_bytes)
			value := mp.read_natural_64_le (0)
		end

feature -- Access

	value: NATURAL_64

	binary_byte_size: NATURAL_32 = 8

feature -- Status report

	to_string: STRING_32
		do
			Result := "0x" + value.to_hex_string
		end

	to_binary_string: STRING_8
		do
			Result := value.to_binary_string
		end

end
