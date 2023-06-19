class
	PE_MD_TABLE_ASSEMBLYDEF_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Access

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (9, "AssemblyDef")
			structure := struct
			struct.add_natural_32 ("HashAlgId")
			struct.add_natural_16 ("MajorVersion")
			struct.add_natural_16 ("MinorVersion")
			struct.add_natural_16 ("BuildNumber")
			struct.add_natural_16 ("RevisionNumber")
			struct.add_flags_32 ("Flags")
			struct.add_blob_index ("PublicKey")
			struct.add_string_index ("Name")
			struct.add_string_index ("Culture")
		end

end
