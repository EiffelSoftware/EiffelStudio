class
	PE_MD_TABLE_CUSTOMATTRIBUTE_ENTRY

inherit
	PE_MD_TABLE_COMPARABLE_ENTRY_WITH_STRUCTURE

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

			struct.add_custom_attribute_value_signature_blob_index ("Value")
		end

feature -- Access

	parent_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Parent")
		end

	type_index: detachable PE_INDEX_ITEM
		do
				-- Warning: this is not a type, but MethodDef or MemberRef
				-- the name is misleading
			Result := structure.index_item ("Type")
		end

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tcustomattribute
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := index_is_less_than (parent_index, other.parent_index)
		end

end
