class
	PE_MD_TABLE_IMPLMAP_ENTRY

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
			-- See II.22.22 ImplMap : 0x1C
			create struct.make (4, "ImplMap")
			structure := struct
			struct.add_pinvoke_attributes ("MappingFlags")
			struct.add_member_forwarded_index ("MemberForwarded")
			struct.add_string_index ("ImportName")
			struct.add_module_ref_index ("ImportScope")
		end

feature -- Access

	import_name_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("ImportName")
		end

	resolved_identifier (pe: PE_FILE): detachable STRING_32
			-- Human identifier
		do
			create Result.make_empty
			if
				attached import_name_index as tn_idx  and then
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
			Result := {PE_TABLES}.timplmap
		end

end
