class
	PE_NATURAL_8

inherit
	PE_STRUCTURE_ITEM

create
	make

feature -- Read

	read (pe: PDB_FILE): PE_ITEM
		do
			Result := pe.read_natural_8_item (label)		
		end

end
