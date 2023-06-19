note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_INDEX_ERROR

inherit
	PE_ERROR

create
	make

feature {NONE} -- Initialization

	make (idx: PE_INDEX_ITEM)
			-- Initialize `Current'.
		do
			index := idx
		end

	index: PE_INDEX_ITEM

feature -- Access

	to_string: STRING_8
		do
			Result := index.label + ":(" + index.index.to_hex_string + " not found)"
		end

end
