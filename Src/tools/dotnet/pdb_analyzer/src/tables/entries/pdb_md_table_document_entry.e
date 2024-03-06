class
	PDB_MD_TABLE_DOCUMENT_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

--	PE_MD_TABLE_ENTRY_WITH_IDENTIFIER

create
	make

feature -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (4, "Document")
			structure := struct;
			struct.add_document_name_blob_index ("Name");
			struct.add_guid_index ("HashAlgorithm");
			struct.add_blob_index ("Hash");
			struct.add_guid_index ("Language");
		end

feature -- Access

	name_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Name")
		end

--	resolved_identifier (pdb: PDB_FILE): detachable STRING_32
--		do
--			create Result.make_empty
--			if attached name_index as tn_idx and then attached pdb.blob_heap_item (tn_idx) as blob then
--				Result.append_string_general (blob.dump)
--			end
--			if Result.is_whitespace then
--				Result := Void
--			end
--		end

feature -- Access

	Table_id: NATURAL_8
		once
			Result := {PDB_TABLES}.tdocument
		end

end
