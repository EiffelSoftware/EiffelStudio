class
	PE_NATURAL_32

inherit
	PE_STRUCTURE_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_ITEM
		do
			Result := pe.read_natural_32_item (label)		
		end

end
