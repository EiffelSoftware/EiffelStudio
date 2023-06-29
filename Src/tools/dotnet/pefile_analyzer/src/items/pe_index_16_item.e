note
	description: "[
			index using 2 bytes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_INDEX_16_ITEM

inherit
	PE_INDEX_ITEM
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

feature -- Status report

	to_string: STRING_32
		do
			if attached {PE_INDEX_ITEM_WITH_TABLE} Current as with_table then
				Result := "0x" + ((with_table.associated_table_id.to_natural_32|<< 24) + value).to_hex_string
				Result.prepend ({STRING_32} "{"+ {PE_MD_TABLES}.table_name (with_table.associated_table_id) +"} ")
			else
				Result := "0x" + value.to_hex_string
			end
			if original_value > 0 then
				Result := "0x" + original_value.to_hex_string + "->" + Result
			end
		end

feature -- Access

	index: NATURAL_32
		do
			Result := value.to_natural_32
		end

	sorting_index: NATURAL_32
		do
			if original_value > 0 then
				Result := original_value.to_natural_32
			else
				Result := index
			end
		end

feature -- Element change		

	update_index (idx: NATURAL_32)
		do
			original_value := value
			value := idx.to_natural_16
		end

	original_value: NATURAL_16

end
