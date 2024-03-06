note
	description: "[
			index using 4 bytes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_LOCAL_CONSTANT_INDEX_32_ITEM

inherit
	PE_LOCAL_CONSTANT_INDEX_ITEM
		rename
			make as make_item
		end

	PE_INDEX_32_ITEM_WITH_TABLE

create
	make

convert
	value: {NATURAL_32}

feature -- Resolver

	replace_index (idx: NATURAL_32)
		do
			set_replaced_index (index)
			value := idx
		end

end
