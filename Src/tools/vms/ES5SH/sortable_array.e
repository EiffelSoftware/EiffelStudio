indexing
	description: "Sortable_Array"
	author: "David Stevens"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SORTABLE_ARRAY [G]

inherit
	SORTABLE [G]
		undefine
			copy, is_equal
		redefine
			found_index
		end

	EXTENDABLE_BOUNDED_ARRAY [G]
		redefine
			found_index
		end

feature

	found_index: INTEGER
	
	found_item: G is
		do
			if found and found_index >= lower and found_index <= upper then
				Result := item (found_index)
			end
		end

end
