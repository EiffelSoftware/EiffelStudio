class
	PE_FLAGS_16

inherit
	PE_STRUCTURE_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_ITEM
		do
			Result := pe.read_flags_16 (label)		
		end

end
