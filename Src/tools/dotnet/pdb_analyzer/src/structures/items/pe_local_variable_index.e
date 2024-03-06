class
	PE_LOCAL_VARIABLE_INDEX

inherit
	PE_STRUCTURE_ITEM

create
	make

feature -- Read

	read (pe: PDB_FILE): PE_LOCAL_VARIABLE_INDEX_ITEM
		do
			Result := pe.read_local_variable_index (label)
		end


end
