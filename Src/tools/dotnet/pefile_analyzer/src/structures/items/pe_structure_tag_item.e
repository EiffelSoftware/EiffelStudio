note
	description: "Summary description for {PE_STRUCTURE_TAGTI_TABLE_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_STRUCTURE_TAG_ITEM

inherit
	PE_STRUCTURE_ITEM

feature -- Access

	tagbit: INTEGER
		deferred
		end

	tag_and_index (idx: PE_INDEX_ITEM): TUPLE [table, index: NATURAL_32]
			-- See ECMA 335 6th edition II.24.2.6	
		local
			i: NATURAL_32
			index: NATURAL_32
			tag: NATURAL_32
		do
			i := idx.index

				-- Compute the index and tag values
			index := i |>> tagbit
			tag := i & ({NATURAL_32} 1 |<< tagbit - 1).to_natural_32

			Result := [tag, index]
		end

end
