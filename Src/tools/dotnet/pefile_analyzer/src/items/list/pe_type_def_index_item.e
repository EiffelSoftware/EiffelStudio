note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_TYPE_DEF_INDEX_ITEM

inherit
	PE_INDEX_ITEM_WITH_TABLE

feature -- Relation

	associated_table_id: NATURAL_8
		once
			Result := {PE_TABLES}.ttypedef
		end


end
