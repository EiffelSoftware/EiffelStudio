note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_FIELD_INDEX_ITEM

inherit
	PE_INDEX_ITEM

	PE_INDEX_ITEM_WITH_TABLE

feature -- Access

	associated_table_id: NATURAL_32
		once
			Result := {PE_TABLES}.tfield
		end

end
