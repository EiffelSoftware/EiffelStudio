class
	PE_MD_TABLE_FIELDMARSHAL_ENTRY

inherit
	PE_MD_TABLE_COMPARABLE_ENTRY_WITH_STRUCTURE

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

	parent_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Parent")
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := index_is_less_than (parent_index, other.parent_index)
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tfieldmarshal
		end

end
