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
			visit_pe_file,
			visit_root,
			visit_tables,
			visit_table,
			visit_table_entry,
			visit_item
		end

create
	make

feature {NONE} -- Access

	make (pe: PE_FILE)
		do
			pe_file := pe
		end

	pe_file: PE_FILE

feature -- Visitor

	visit_pe_file (o: PE_FILE)
		do
			check o = pe_file end
			o.metadata_root.accepts (Current)
			o.metadata_string_heap.accepts (Current)
			o.metadata_user_string_heap.accepts (Current)
			o.metadata_guid_heap.accepts (Current)
			o.metadata_blob_heap.accepts (Current)
			o.metadata_tables.accepts (Current)
		end

	visit_root (o: PE_MD_ROOT)
		do
			Precursor (o)
		end

	tables_count: detachable HASH_TABLE [NATURAL_32, NATURAL_32]

	has_field_pointer_table: BOOLEAN
	has_method_pointer_table: BOOLEAN

	table_count (tb_id: NATURAL_8): NATURAL_32
		do
			if attached tables_count as ht then
				Result := ht [tb_id]
			end
		end

	visit_tables (o: PE_MD_TABLES)
		local
			l_count: NATURAL_32
			ht: like tables_count
		do
			has_field_pointer_table := o [{PE_TABLES}.tfieldpointer] /= Void
			has_method_pointer_table := o [{PE_TABLES}.tmethodpointer] /= Void

			if has_field_pointer_table or has_method_pointer_table then
				Precursor (o)
			else
				-- Nothing to resolve
			end
		end

	current_table: detachable PE_MD_TABLE [PE_MD_TABLE_ENTRY]

	visit_table (o: PE_MD_TABLE [PE_MD_TABLE_ENTRY])
		do
			current_table := o
			Precursor (o)
			current_table := Void
		end

	current_table_entry: detachable PE_MD_TABLE_ENTRY

	visit_table_entry (o: PE_MD_TABLE_ENTRY)
		do
			current_table_entry := o
			Precursor (o)
			current_table_entry := Void
		end

	visit_item (o: PE_ITEM)
		do
			if attached {PE_METHOD_DEF_INDEX_ITEM} o as mtd_index then
				visit_method_def_index_item (mtd_index)
			elseif attached {PE_FIELD_INDEX_ITEM} o as fld_index then
				visit_field_index_item (fld_index)
			else
			end
			Precursor (o)
		end

	visit_method_def_index_item (idx: PE_METHOD_DEF_INDEX_ITEM)
		do
			if has_method_pointer_table then
				-- Handle the redirection ...
				if
					not idx.is_null_index and then
					idx.index /= table_count ({PE_TABLES}.tmethodpointer) + 1 and then
					attached pe_file.methodpointer (idx) as ptr and then
					attached ptr.method_index as midx
				then
					idx.replace_index (midx.index) -- Update
				end
			end
		end

	visit_field_index_item (idx: PE_FIELD_INDEX_ITEM)
		do
			if has_field_pointer_table then
				-- Handle the redirection ...
				if
					not idx.is_null_index and then
					idx.index /= table_count ({PE_TABLES}.tfieldpointer) + 1 and then
					attached pe_file.fieldpointer (idx) as ptr and then
					attached ptr.field_index as fidx
				then
					idx.replace_index (fidx.index) -- Update
				end
			end
		end

end
