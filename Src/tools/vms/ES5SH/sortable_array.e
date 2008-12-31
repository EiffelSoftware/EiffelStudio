note
	description: "Sortable_Array"
	author: "David Stevens"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SORTABLE_ARRAY [G]

inherit
	SORTABLE [G]
		undefine
			copy, is_equal, count, valid_index
		redefine
			found_index
		end

	EXTENDABLE_BOUNDED_ARRAY [G]
		redefine
			found_index
		end

feature

	found_index: INTEGER

end -- class SORTABLE_ARRAY
