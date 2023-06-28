class
	PE_MD_TABLE_IMPLMAP_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization


	initialize_structure
		local
			struct: like structure
		do
			-- See II.22.22 ImplMap : 0x1C
			create struct.make (2, "ImplMap")
			structure := struct
			struct.add_flags_16 ("MappingFlags")
--			struct.add_blob_index ("NativeType")
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.timplmap
		end

end
