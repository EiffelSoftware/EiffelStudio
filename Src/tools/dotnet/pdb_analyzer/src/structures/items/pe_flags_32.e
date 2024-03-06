class
	PE_FLAGS_32

inherit
	PE_STRUCTURE_ITEM

create
	make

feature -- Read

	read (pe: PDB_FILE): PE_INTEGER_32_ITEM
		do
			Result := pe.read_flags_32 (label)
		end

end
