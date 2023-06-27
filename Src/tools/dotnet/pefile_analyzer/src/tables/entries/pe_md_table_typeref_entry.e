class
	PE_MD_TABLE_TYPEREF_ENTRY

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
			create struct.make (3, "TypeRef")
			structure := struct
			struct.add_resolution_scope ("ResolutionScope")
			struct.add_string_index ("TypeName")
			struct.add_string_index ("TypeNamespace")
		end

feature -- Access

	typename_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("TypeName")
		end

	typenamespace_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("TypeNamespace")
		end

feature -- Display

	resolved_identifier (pe: PE_FILE): detachable STRING_32
			-- Human identifier
		do
			create Result.make_empty
			if
				attached typenamespace_index as tns_idx  and then
				attached pe.string_heap_item (tns_idx) as s
			then
				Result.append (s)
				Result.append_character ('.')
			end
			if
				attached typename_index as tn_idx  and then
				attached pe.string_heap_item (tn_idx) as s
			then
				Result.append (s)
			end
			if Result.is_whitespace then
				Result := Void
			end
		end

feature -- Access

	table_id: NATURAL_8
		once
			Result := {PE_TABLES}.ttyperef
		end


end
