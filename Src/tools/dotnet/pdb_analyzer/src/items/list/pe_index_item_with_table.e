note
	description: "Summary description for {PE_INDEX_ITEM_WITH_TABLE}."
	author: ""
	datem: "$Date$"
	revision: "$Revision$"

deferred class
	PE_INDEX_ITEM_WITH_TABLE

inherit
	PE_INDEX_ITEM
		redefine
			token
		end

feature -- Access

	token: NATURAL_32
		do
			Result := (associated_table_id.to_natural_32 |<< 24) | index
		end

--	sorting_index: NATURAL_32
--		do
--			Result := (index |<< 0) + associated_table_id.to_natural_32
--		end

	associated_table_id: NATURAL_8
		deferred
		ensure
			valid_table_id: {PDB_TABLES}.valid (Result) or {PE_TABLES}.valid (Result)
		end

end
