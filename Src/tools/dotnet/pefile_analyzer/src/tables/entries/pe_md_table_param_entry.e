class
	PE_MD_TABLE_PARAM_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

	PE_MD_TABLE_ENTRY_WITH_IDENTIFIER

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

	resolved_identifier (pe: PE_FILE): detachable STRING_32
			-- Human identifier
		do
			create Result.make_empty
			if
				attached name_index as tn_idx  and then
				attached pe.string_heap_item (tn_idx) as s
			then
				Result.append_string_general (s)
			end
			if Result.is_whitespace then
				Result := Void
			end
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.tparam
		end

end
