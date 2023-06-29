class
	PE_MODULE_REF_INDEX

inherit
	PE_STRUCTURE_ITEM

create
	make

feature -- Read

	read (pe: PE_FILE): PE_MODULE_REF_INDEX_ITEM
		do
			Result := pe.read_module_ref_index (label)
		end

end
