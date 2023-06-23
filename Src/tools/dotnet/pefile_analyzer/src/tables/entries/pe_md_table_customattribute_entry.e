class
	PE_MD_TABLE_CUSTOMATTRIBUTE_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Access

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "CustomAttribute")
			structure := struct
			struct.add_has_custom_attribute_index ("Parent")
			struct.add_custom_attribute_type_index ("Type")
				-- ???
				-- Type (an index into the MethodDef or MemberRef table; more precisely, a
				-- CustomAttributeType (§II.24.2.6) coded index)

			struct.add_blob_index ("Value")
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tcustomattribute
		end

end
