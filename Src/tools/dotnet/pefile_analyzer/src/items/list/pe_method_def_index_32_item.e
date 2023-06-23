note
	description: "[
			index using 4 bytes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_METHOD_DEF_INDEX_32_ITEM

inherit
	PE_METHOD_DEF_INDEX_ITEM
		rename
			make as make_item
		end

	PE_INDEX_32_ITEM

create
	make

convert
	value: {NATURAL_32}

feature -- Resolver

	replace_index (idx: NATURAL_32)
		do
			value := idx
		end

end
