class
	PE_STRING_INDEX

inherit
	PE_STRUCTURE_ITEM

create
	make

feature -- Read

	read (pe: PDB_FILE): PE_ITEM
		do
			Result := pe.read_string_index (label)		
		end

end
