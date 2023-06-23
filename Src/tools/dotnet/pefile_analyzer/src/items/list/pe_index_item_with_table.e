note
	description: "Summary description for {PE_INDEX_ITEM_WITH_TABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_INDEX_ITEM_WITH_TABLE

inherit
	PE_INDEX_ITEM

feature -- Access

	associated_table_id: NATURAL_8
		deferred
		ensure
			valid_table_id: {PE_TABLES}.valid (Result)
		end

end
