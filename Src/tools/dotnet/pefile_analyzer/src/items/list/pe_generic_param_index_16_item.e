note
	description: "[
			index using 2 bytes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_GENERIC_PARAM_INDEX_16_ITEM

inherit
	PE_GENERIC_PARAM_INDEX_ITEM
		rename
			make as make_item
		end

	PE_INDEX_16_ITEM_WITH_TABLE

create
	make

convert
	value: {NATURAL_16}

end
