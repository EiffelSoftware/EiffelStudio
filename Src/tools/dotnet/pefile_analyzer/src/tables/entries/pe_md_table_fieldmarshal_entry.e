class
	PE_MD_TABLE_FIELDMARSHAL_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization


	initialize_structure
		local
			struct: like structure
		do
			-- See II.22.17 FieldMarshal : 0x0D
			create struct.make (2, "FieldMarshal")
			structure := struct
			struct.add_has_field_marshal ("Parent")
			struct.add_blob_index ("NativeType")
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tfieldmarshal
		end

end
