note
	description: "[
			index using 2 bytes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_METHOD_DEF_INDEX_16_ITEM

inherit
	PE_METHOD_DEF_INDEX_ITEM
		rename
			make as make_item
		end

	PE_INDEX_16_ITEM

create
	make

convert
	value: {NATURAL_16}

feature -- Resolver

	replace_index (idx: NATURAL_32)
		do
			value := idx.to_natural_16
		end

end
