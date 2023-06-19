class
	PE_PROPERTY_INDEX

inherit
	PE_STRUCTURE_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_ITEM
		do
			Result := pe.read_property_index (label)		
		end

end
