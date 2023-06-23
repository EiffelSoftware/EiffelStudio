class
	PE_METHOD_DEF_INDEX

inherit
	PE_STRUCTURE_ITEM

	PE_INDEX_ITEM_WITH_TABLE

create
	make

feature -- Read

	read (pe: PE_FILE): PE_METHOD_DEF_INDEX_ITEM
		do
			Result := pe.read_method_def_index (label)
		end

feature -- Access

	associated_table_id: NATURAL_32
		once
			Result := {PE_TABLES}.tmethoddef
		end

end
