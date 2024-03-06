class
	PE_GUID_INDEX

inherit
	PE_STRUCTURE_ITEM

create
	make

feature -- Read

	read (pe: PDB_FILE): PE_GUID_INDEX_ITEM
		do
			Result := pe.read_guid_index (label)
		end

end
