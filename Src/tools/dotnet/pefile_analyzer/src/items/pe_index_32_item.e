note
	description: "[
			index using 4 bytes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_INDEX_32_ITEM

inherit
	PE_INDEX_ITEM
		rename
			make as make_item
		end

create
	make

convert
	value: {NATURAL_32}

feature {NONE} -- Initialization

	make (a_start_index: NATURAL_32; mp: MANAGED_POINTER; lab: like label)
		do
			make_item (a_start_index, a_start_index, a_start_index + 4, mp, lab) --{PLATFORM}.natural_32_bytes)
			value := mp.read_natural_32_le (0)
		end

feature -- Access

	value: NATURAL_32

feature -- Status report

	to_string: STRING_32
		do
			Result := "0x" + value.to_hex_string
			if original_value > 0 then
				Result := "0x" + original_value.to_hex_string + "->" + Result
			end
		end

feature -- Access

	index: NATURAL_32
		do
			Result := value
		end

feature -- Element change		

	update_index (idx: NATURAL_32)
		do
			original_value := value
			value := idx
		end

	original_value: like value


end
