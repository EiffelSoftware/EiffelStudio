note
	description: "Summary description for {PE_INDEX_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_INDEX_ITEM

inherit
	PE_ITEM

feature -- Access

	token: NATURAL_32
		do
			Result := index
		end

	sorting_index: NATURAL_32
		deferred
		end

	index: NATURAL_32
		deferred
		end

	original_index: NATURAL_32
		deferred
		end

	is_null_index: BOOLEAN
		do
			Result := index = 0x0
		end

feature -- Comparison

	is_less_than alias "<" (other: PE_INDEX_ITEM): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := sorting_index < other.sorting_index
		end

feature -- Element change

	update_index (idx: NATURAL_32)
		deferred
		ensure
			original_index = old index
		end

end
