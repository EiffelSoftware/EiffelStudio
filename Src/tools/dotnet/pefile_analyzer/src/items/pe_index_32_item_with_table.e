note
	description: "[
			index using 4 bytes
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_INDEX_32_ITEM_WITH_TABLE

inherit
	PE_INDEX_32_ITEM
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

--	token: NATURAL_32
--		do
--			Result := (associated_table_id.to_natural_32 |<< 24) | index
--		end

	sorting_index: NATURAL_32
		do
			if original_value > 0 then
				Result := original_value
			else
				Result := index
			end
		end

end
