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

	index: NATURAL_32
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
			Result := index < other.index
		end

feature -- Element change

	update_index (idx: NATURAL_32)
		deferred
		end

end
