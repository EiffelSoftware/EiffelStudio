note
	description: "[
			index using 2 bytes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_INDEX_16_ITEM_WITH_TABLE

inherit
	PE_INDEX_16_ITEM
		undefine
			token
		redefine
			sorting_index
		end

	PE_INDEX_ITEM_WITH_TABLE
		rename
			make as make_item
		undefine
			make_item
		end

feature -- Sorting

	sorting_index: NATURAL_32
		do
			if original_value > 0 then
				Result := original_value.to_natural_32
			else
				Result := index.to_natural_32
			end
		end

end
