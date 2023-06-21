class
	PE_MD_TABLE_PARAM_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "Param")
			structure := struct
			struct.add_param_attributes ("Flags")
			struct.add_natural_16 ("Sequence")
			struct.add_string_index ("Name")
		end

feature -- Access

	param_attributes: detachable PE_PARAM_ATTRIBUTES_ITEM
		do
			if attached {PE_PARAM_ATTRIBUTES_ITEM} structure.item ("Flags") as ta then
				Result := ta
			else
				check False end
			end
		end

	name_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Name")
		end

	sequence: detachable PE_NATURAL_16_ITEM
		do
			Result := structure.natural_16_item ("Sequence")
		end

feature -- Access

	table_id: NATURAL_32
		once
			Result := {PE_TABLES}.tparam
		end

end
