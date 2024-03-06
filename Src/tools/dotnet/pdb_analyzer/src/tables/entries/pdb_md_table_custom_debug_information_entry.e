class
	PDB_MD_TABLE_CUSTOM_DEBUG_INFORMATION_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "CustomDebugInformation")
			structure := struct
				--    Parent (HasCustomDebugInformation coded index)
			struct.add_natural_16 ("Parent") -- FIXME!!!
				--    Kind (Guid heap index)
			struct.add_guid_index ("Kind")
				--    Value (Blob heap index)
			struct.add_blob_index ("Value")
		end

feature -- Access


feature -- Access

	Table_id: NATURAL_8
		once
			Result := {PDB_TABLES}.tcustomdebuginformation
		end

end

