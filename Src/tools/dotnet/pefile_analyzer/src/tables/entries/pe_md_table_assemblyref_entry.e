class
	PE_MD_TABLE_ASSEMBLYREF_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Access

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (9, "AssemblyRef")
			structure := struct
			struct.add_natural_16 ("MajorVersion")
			struct.add_natural_16 ("MinorVersion")
			struct.add_natural_16 ("BuildNumber")
			struct.add_natural_16 ("RevisionNumber")
			struct.add_flags_32 ("Flags") -- AssemblyFlags
			struct.add_blob_index ("PublicKeyOrToken")
			struct.add_string_index ("Name")
			struct.add_string_index ("Culture")
			struct.add_blob_index ("HashValue")
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tassemblyref
		end

end
