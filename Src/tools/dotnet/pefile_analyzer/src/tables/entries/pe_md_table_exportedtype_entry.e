class
	PE_MD_TABLE_EXPORTEDTYPE_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (5, "ExportedType")
			structure := struct
			struct.add_type_attributes ("Flags")

				-- TypeDefId (a 4-byte index into a TypeDef table of another module in this Assembly).
				-- This column is used as a hint only. If the entry in the target TypeDef table matches
				-- the TypeName and TypeNamespace entries in this table, resolution has succeeded.
				-- But if there is a mismatch, the CLI shall fall back to a search of the target TypeDef
				-- table. Ignored and should be zero if Flags has IsTypeForwarder set.			
			struct.add_natural_32 ("TypeDefId")

			struct.add_string_index ("Name")
			struct.add_string_index ("Namespace")
			struct.add_implementation_index ("Implementation")
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.texportedtype
		end

end
