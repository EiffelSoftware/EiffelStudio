note
	description: "[
			index using 4 bytes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_GENERIC_PARAM_CONSTRAINT_INDEX_32_ITEM

inherit
	PE_GENERIC_PARAM_CONSTRAINT_INDEX_ITEM
		rename
			make as make_item
		end

	PE_INDEX_32_ITEM_WITH_TABLE

create
	make

convert
	value: {NATURAL_32}

end
