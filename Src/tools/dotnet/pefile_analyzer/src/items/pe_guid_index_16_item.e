note
	description: "[
			GUID index using 2 bytes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_GUID_INDEX_16_ITEM

inherit
	PE_GUID_INDEX_ITEM
		rename
			make as make_item
		end

	PE_INDEX_16_ITEM

create
	make

convert
	value: {NATURAL_16}

end
