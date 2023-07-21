note
	description: "Summary description for {PE_NATURAL_16_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_NATURAL_16_ITEM

inherit
	PE_ITEM
		rename
			make as make_item
		end

create
	make

convert
	value: {NATURAL_16}

feature {NONE} -- Initialization

	make (a_start_index: NATURAL_32; mp: MANAGED_POINTER; lab: like label)
		do
			make_item (a_start_index, a_start_index, a_start_index + 2, mp, lab) --{PLATFORM}.natural_16_bytes)
			value := mp.read_natural_16_le (0)
		end

feature -- Access

	value: NATURAL_16

	binary_byte_size: NATURAL_32 = 2

feature -- Status report

	to_string: STRING_32
		do
			Result := value.out
		end

end
