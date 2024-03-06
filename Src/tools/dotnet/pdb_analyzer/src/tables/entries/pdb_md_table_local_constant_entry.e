class
	PDB_MD_TABLE_LOCAL_CONSTANT_ENTRY

inherit
	PE_MD_TABLE_ENTRY_WITH_STRUCTURE

	PE_MD_TABLE_ENTRY_WITH_IDENTIFIER

create
	make

feature -- Initialization

	initialize_structure
		local
			struct: like structure
		do
			create struct.make (3, "LocalConstant")
			structure := struct
			struct.add_string_index ("Name")
			struct.add_blob_index ("Signature") -- LocalConstantSig blob
		end

feature -- Access

	name_index: detachable PE_INDEX_ITEM
		do
			Result := structure.index_item ("Name")
		end

	resolved_identifier (pe: PDB_FILE): detachable STRING_32
		do
			create Result.make_empty
			if attached name_index as tn_idx and then attached pe.string_heap_item (tn_idx) as s then
				Result.append_string_general (s)
			end
			if Result.is_whitespace then
				Result := Void
			end
		end

feature -- Access

	Table_id: NATURAL_8
		once
			Result := {PDB_TABLES}.tlocalconstant
		end

end

