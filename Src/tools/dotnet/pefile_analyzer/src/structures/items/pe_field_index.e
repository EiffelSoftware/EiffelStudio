class
	PE_FIELD_INDEX

inherit
	PE_STRUCTURE_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_FIELD_INDEX_ITEM
		do
			Result := pe.read_field_index (label)
		end

end
