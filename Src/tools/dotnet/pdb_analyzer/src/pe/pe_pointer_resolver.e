note
	description: "Summary description for {PE_POINTER_RESOLVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_POINTER_RESOLVER

inherit
	PE_ITERATOR
		redefine
			visit_pdb_file,
			visit_root,
			visit_tables,
			visit_table,
			visit_table_entry,
			visit_item
		end

create
	make

feature {NONE} -- Access

	make (pe: PDB_FILE)
		do
			pdb_file := pe
		end

	pdb_file: PDB_FILE

feature -- Visitor

	visit_pdb_file (o: PDB_FILE)
		do
			check o = PDB_FILE end
			o.metadata_root.accepts (Current)
			o.metadata_string_heap.accepts (Current)
			o.metadata_user_string_heap.accepts (Current)
			o.metadata_guid_heap.accepts (Current)
			o.metadata_blob_heap.accepts (Current)
			o.metadata_tables.accepts (Current)
		end

	visit_root (o: PDB_ROOT)
		do
			Precursor (o)
		end

	tables_count: detachable HASH_TABLE [NATURAL_32, NATURAL_32]

--	has_field_pointer_table: BOOLEAN
--	has_method_pointer_table: BOOLEAN

	table_count (tb_id: NATURAL_8): NATURAL_32
		do
			if attached tables_count as ht then
				Result := ht [tb_id]
			end
		end

	visit_tables (o: PDB_MD_TABLES)
		local
--			l_count: NATURAL_32
--			ht: like tables_count
		do
--			has_field_pointer_table := o [{PE_TABLES}.tfieldpointer] /= Void
--			has_method_pointer_table := o [{PE_TABLES}.tmethodpointer] /= Void

--			if has_field_pointer_table or has_method_pointer_table then
--				Precursor (o)
--			else
--				-- Nothing to resolve
--			end
		end

	current_table: detachable PDB_MD_TABLE [PDB_MD_TABLE_ENTRY]

	visit_table (o: PDB_MD_TABLE [PDB_MD_TABLE_ENTRY])
		do
			current_table := o
			Precursor (o)
			current_table := Void
		end

	current_table_entry: detachable PDB_MD_TABLE_ENTRY

	visit_table_entry (o: PDB_MD_TABLE_ENTRY)
		do
			current_table_entry := o
			Precursor (o)
			current_table_entry := Void
		end

	visit_item (o: PE_ITEM)
		do
--			if attached {PE_METHOD_DEF_INDEX_ITEM} o as mtd_index then
--				visit_method_def_index_item (mtd_index)
--			elseif attached {PE_FIELD_INDEX_ITEM} o as fld_index then
--				visit_field_index_item (fld_index)
--			else
--			end
			Precursor (o)
		end



end
