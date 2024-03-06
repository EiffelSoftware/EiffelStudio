class
	PE_NATURAL_16

inherit
	PE_STRUCTURE_ITEM

create
	make

feature -- Read

	read (pe: PDB_FILE): PE_ITEM
		do
			Result := pe.read_natural_16_item (label)		
		end

end
