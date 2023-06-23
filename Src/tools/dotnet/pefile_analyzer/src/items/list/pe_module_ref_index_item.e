note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_MODULE_REF_INDEX_ITEM

inherit
	PE_INDEX_ITEM_WITH_TABLE

feature -- Relation

	associated_table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tmoduleref
		end


end
