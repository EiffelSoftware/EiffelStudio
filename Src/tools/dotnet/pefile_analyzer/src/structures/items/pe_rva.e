class
	PE_RVA

inherit
	PE_STRUCTURE_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_RVA_ITEM
		do
			Result := pe.read_rva (label)
		end

end
