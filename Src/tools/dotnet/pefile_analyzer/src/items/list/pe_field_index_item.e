note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_FIELD_INDEX_ITEM

inherit
	PE_INDEX_ITEM_WITH_TABLE

	PE_WITH_POINTER_TABLE_INDEX

feature -- Access

	associated_table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tfield
		end

end
