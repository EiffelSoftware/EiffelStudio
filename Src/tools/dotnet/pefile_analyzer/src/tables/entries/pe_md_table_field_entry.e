class
	PE_MD_TABLE_FIELD_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Access

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "Field")
			structure := struct
			struct.add_flags_16 ("Flags")
			struct.add_string_index ("Name")
			struct.add_signature_blob_index ("Signature")
		end

feature -- Access

	name_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Name")
		end

feature -- Access

	table_id: NATURAL_32
		once
			Result := {PE_TABLES}.tfield
		end

end
