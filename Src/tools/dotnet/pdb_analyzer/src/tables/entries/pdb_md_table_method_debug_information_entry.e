class
	PDB_MD_TABLE_METHOD_DEBUG_INFORMATION_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

create
	make

feature -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "MethodDebugInformation")
			structure := struct;
			struct.add_document_index ("Document")
			struct.add_sequence_points_index ("SequencePoints")
		end

feature -- Access

	document_row_id: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Document")
		end

	Table_id: NATURAL_8
		once
			Result := {PDB_TABLES}.tMethodDebugInformation
		end

end

