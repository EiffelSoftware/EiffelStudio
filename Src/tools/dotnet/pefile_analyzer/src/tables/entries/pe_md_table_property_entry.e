class
	PE_MD_TABLE_PROPERTY_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "Property")
			structure := struct
			struct.add_property_attributes ("Flags")
			struct.add_string_index ("Name")
			struct.add_property_signature_blob_index ("Type")
		end

feature -- Access

	property_attributes: detachable PE_PROPERTY_ATTRIBUTES_ITEM
		do
			if attached {PE_PROPERTY_ATTRIBUTES_ITEM} structure.item ("Flags") as ta then
				Result := ta
			else
				check False end
			end
		end

	name_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Name")
		end

	type_signature_index: detachable PE_BLOB_INDEX_ITEM
		do
			if attached {like type_signature_index} structure.item ("Type") as i then
				Result := i
			else
				check False end
			end
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tproperty
		end

end
