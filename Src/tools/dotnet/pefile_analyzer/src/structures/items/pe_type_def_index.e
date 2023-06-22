class
	PE_TYPE_DEF_INDEX

inherit
	PE_STRUCTURE_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_TYPE_DEF_INDEX_ITEM
		do
			Result := pe.read_type_def_index (label)
		end

end
