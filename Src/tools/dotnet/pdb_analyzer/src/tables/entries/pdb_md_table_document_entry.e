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

	name_index: detachable PE_BLOB_INDEX_ITEM
		do
			if attached {like name_index} structure.index_item ("Name") as i then
				Result := i
			end
		end

	language_index: detachable PE_GUID_INDEX_ITEM
		do
			if attached {like language_index} structure.index_item ("Language") as i then
				Result := i
			end
		end

feature -- Access

	Table_id: NATURAL_8
		once
			Result := {PDB_TABLES}.tdocument
		end

end
