class
	PE_MD_TABLE_MODULE_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE
		redefine
			check_validity
		end

	PE_MD_TABLE_ENTRY_WITH_IDENTIFIER

create
	make

feature {NONE} -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (5, "Module")
			structure := struct
			struct.add_natural_16 ("Generation")
			struct.add_string_index ("Name")
			struct.add_guid_index ("Mvid")
			struct.add_guid_index ("EncId")
			struct.add_guid_index ("EncBaseId")
		end

feature -- Access

	name_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Name")
		end

	check_validity (pe: PE_FILE)
		do
			if
				attached {PE_GUID_INDEX_ITEM} structure.item ("EncId") as idx and then
				idx.index > 0
			then
				idx.report_error (create {PE_USER_ERROR}.make ("shall be zero"))
			end
			if
				attached {PE_GUID_INDEX_ITEM} structure.item ("EncBaseId") as idx and then
				idx.index > 0
			then
				idx.report_error (create {PE_USER_ERROR}.make ("shall be zero"))
			end
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
			Result := {PE_TABLES}.tmodule
		end

end
