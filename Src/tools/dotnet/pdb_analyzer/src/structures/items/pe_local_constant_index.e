class
	PE_LOCAL_CONSTANT_INDEX

inherit
	PE_STRUCTURE_ITEM

create
	make

feature -- Read

	read (pe: PDB_FILE): PE_LOCAL_CONSTANT_INDEX_ITEM
		do
			Result := pe.read_local_constant_index (label)
		end


end
