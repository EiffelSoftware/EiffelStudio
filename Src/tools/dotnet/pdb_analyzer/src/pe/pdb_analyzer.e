note
	description: "Summary description for {PE_ANALYZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PDB_ANALYZER

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

	make (pdb: PDB_FILE)
		do
			pdb_file := pdb
		end

	pdb_file: PDB_FILE

feature -- Access	

	error_count: NATURAL_32

feature -- Visitor

	reset
		do
			error_count := 0
		end

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

	table_count (tb_id: NATURAL_8): NATURAL_32
		do
			if attached tables_count as ht then
				Result := ht [tb_id]
			end
		end

	visit_tables (o: PDB_MD_TABLES)
		local
			l_count: NATURAL_32
			ht: like tables_count
		do

				-- Record table counts
			create ht.make (o.tables.count)
			tables_count := ht
			across
				o.tables as ic
			loop
				if attached ic.item as tb then
					ht [tb.table_id] := tb.entries_count.to_natural_32
				end
			end
			Precursor (o)
		end

	current_table: detachable PDB_MD_TABLE [PDB_MD_TABLE_ENTRY]

	visit_table (o: PDB_MD_TABLE [PDB_MD_TABLE_ENTRY])
		do
			current_table := o
			update_list_indexes (o)
			Precursor (o)
			o.check_validity (pdb_file)
			if o.has_error then
				error_count := error_count + o.error_count
			end
			current_table := Void
		end

	update_list_indexes (o: PDB_MD_TABLE [PDB_MD_TABLE_ENTRY])
		local
			lst: ARRAYED_LIST [READABLE_STRING_GENERAL]
		do
			if attached {PE_MD_TABLE_ENTRY_WITH_STRUCTURE} o.first as tb then
				create lst.make (1)
				across
					tb.structure.structure_items as ic
				loop
					if attached {PE_LIST_INDEX} ic.item as li then
						lst.force (li.label)
					end
				end

				across
					lst as ic
				loop
					update_list_index (o, ic.item)
				end
			end
		end

	sorting_index_of_list (idx: PE_INDEX_ITEM): NATURAL_32
		do
			if attached {PE_WITH_POINTER_TABLE_INDEX} idx as r_idx and then r_idx.is_replaced then
				Result := r_idx.replaced_index
			else
				Result := idx.index
			end
		end

	update_list_index (o: PDB_MD_TABLE [PDB_MD_TABLE_ENTRY]; label: READABLE_STRING_GENERAL)
		local
			i: NATURAL_32
			prev: PE_INDEX_ITEM
			l_updated: BOOLEAN
		do
			across
				o.entries as ic
			loop
				i := i + 1 -- not used, just to know the index while debugging
				if
					attached {PE_MD_TABLE_ENTRY_WITH_STRUCTURE} ic.item as e and then
					attached {PE_INDEX_ITEM} e.structure.item (label) as idx
				then
					if
						prev /= Void and then
						sorting_index_of_list (prev) = sorting_index_of_list (idx)
					then
						prev.update_index (0)
						l_updated := True
					end
					if attached {PE_INDEX_ITEM_WITH_TABLE} idx as idx_with_table then
						if sorting_index_of_list (idx) = table_count (idx_with_table.associated_table_id) + 1 then
							idx.update_index (0)
							l_updated := True
						end
					end
					prev := idx
				else
					check has_label: False end
				end
			end

			debug
				if l_updated then
					print ({STRING_32} "Updated index list ["+label.to_string_8+"]:%N")
					across
						o.entries as ic
					loop
						if
							attached {PE_MD_TABLE_ENTRY_WITH_STRUCTURE} ic.item as e and then
							attached {PE_INDEX_ITEM} e.structure.item (label) as idx
						then
							print ({STRING_32} " - " + label.to_string_32 + ": " + idx.to_string + "%N")
						else
							check has_label: False end
						end
					end
				end
			end
		end

	current_table_entry: detachable PDB_MD_TABLE_ENTRY

	visit_table_entry (o: PDB_MD_TABLE_ENTRY)
		do
			current_table_entry := o
			Precursor (o)
			o.check_validity (pdb_file)
			if o.has_error then
				error_count := error_count + o.error_count
			end
			current_table_entry := Void
		end

	visit_item (o: PE_ITEM)
		do
			if attached {PE_METHOD_DEF_INDEX_ITEM} o as mtd_index then
				visit_method_def_index_item (mtd_index)

--			elseif attached {PDB_IMPORTS_BLOB_INDEX_ITEM} o as m_index then
--				visit_blob_index_item (m_index)
			elseif attached {PE_DOCUMENT_INDEX_ITEM} o as d_index then
				visit_document_index_item (d_index)
			elseif attached {PE_IMPORT_SCOPE_INDEX_ITEM} o as ic_index then
				visit_import_scope_index_item (ic_index)
			elseif attached {PE_LOCAL_CONSTANT_INDEX_ITEM} o as lc_index then
				visit_local_constant_index_item (lc_index)
			elseif attached {PE_LOCAL_VARIABLE_INDEX_ITEM} o as lv_index then
				visit_local_variable_index_item (lv_index)


			elseif attached {PE_STRING_INDEX_ITEM} o as tstring_index then
				visit_string_index_item (tstring_index)

			elseif attached {PE_BLOB_INDEX_ITEM} o as tblob_index then
				visit_blob_index_item (tblob_index)

			elseif attached {PE_GUID_INDEX_ITEM} o as tguid_index then
				visit_guid_index_item (tguid_index)

			elseif attached {PE_GUID_ITEM} o as tguid then
				visit_guid_item (tguid)

			else
				-- TODO
				visit_unhandled_item (o)
			end
			Precursor (o)
		end

	visit_unhandled_item (o: PE_ITEM)
		do
			-- CHECK
			if
				attached {PE_NATURAL_16_ITEM} o
				or attached {PE_NATURAL_32_ITEM} o
				or attached {PE_INTEGER_16_ITEM} o
				or attached {PE_INTEGER_32_ITEM} o
			then
					-- TODO: check validity
			else
				do_nothing
			end
		end

	visit_method_def_index_item (idx: PE_METHOD_DEF_INDEX_ITEM)
		do
			if
				not idx.is_null_index  -- and then idx.index /= table_count ({PE_TABLES}.ttypespec) + 1
			then
				visit_unhandled_item (idx)
--				if attached pdb_file.method_def (idx) as d then
--					if attached d.resolved_identifier (pdb_file) as s then
--						idx.set_info (create {PE_ITEM_INFO}.make (s))
--					else
----						idx.set_info (create {PE_ITEM_INFO}.make_link (t.to_link_string))
--					end
--				else
--					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
--				end
			end
		end

	visit_document_index_item (idx: PE_DOCUMENT_INDEX_ITEM)
		do
			if
				not idx.is_null_index  -- and then idx.index /= table_count ({PE_TABLES}.ttypespec) + 1
			then
--				if attached pdb_file.document (idx) as d then
--					if attached d.resolved_identifier (pdb_file) as s then
--						idx.set_info (create {PE_ITEM_INFO}.make (s))
--					else
----						idx.set_info (create {PE_ITEM_INFO}.make_link (t.to_link_string))
--					end
--				else
--					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
--				end
			end
		end

	visit_import_scope_index_item (idx: PE_IMPORT_SCOPE_INDEX_ITEM)
		do
			if
				not idx.is_null_index  -- and then idx.index /= table_count ({PE_TABLES}.ttypespec) + 1
			then
--				if attached pdb_file.import_scope (idx) as d then
--					if attached d.resolved_identifier (pdb_file) as s then
--						idx.set_info (create {PE_ITEM_INFO}.make (s))
--					else
----						idx.set_info (create {PE_ITEM_INFO}.make_link (t.to_link_string))
--					end
--				else
--					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
--				end
			end
		end

	visit_local_variable_index_item (idx: PE_LOCAL_VARIABLE_INDEX_ITEM)
		do
			if
				not idx.is_null_index  -- and then idx.index /= table_count ({PE_TABLES}.ttypespec) + 1
			then
				if attached pdb_file.local_variable (idx) as d then
					if attached d.resolved_identifier (pdb_file) as s then
						idx.set_info (create {PE_ITEM_INFO}.make (s))
					else
--						idx.set_info (create {PE_ITEM_INFO}.make_link (t.to_link_string))
					end
				else
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
				end
			end
		end

	visit_local_constant_index_item (idx: PE_LOCAL_CONSTANT_INDEX_ITEM)
		do
			if
				not idx.is_null_index  -- and then idx.index /= table_count ({PE_TABLES}.ttypespec) + 1
			then
				if attached pdb_file.local_constant (idx) as d then
					if attached d.resolved_identifier (pdb_file) as s then
						idx.set_info (create {PE_ITEM_INFO}.make (s))
					else
--						idx.set_info (create {PE_ITEM_INFO}.make_link (t.to_link_string))
					end
				else
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
				end
			end
		end

	visit_string_index_item (idx: PE_STRING_INDEX_ITEM)
		do
			if
				not idx.is_null_index
			then
				if attached pdb_file.string_heap_item (idx) as str then
					idx.set_info (create {PE_ITEM_INFO}.make (str))
				else
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
				end
			end
		end

	visit_blob_index_item (idx: PE_BLOB_INDEX_ITEM)
		do
			if attached {PDB_SEQUENCE_POINTS_BLOB_INDEX} idx.associated_structure then
				if
					idx.index > 0
				then
					if attached pdb_file.sequence_points_blob_heap_item (idx) as seq_pts then
						seq_pts.set_associated_pdb_file (pdb_file)
						seq_pts.set_associated_table_entry (current_table_entry)
						if attached {PDB_MD_TABLE_METHOD_DEBUG_INFORMATION_ENTRY} current_table_entry as e then
							idx.set_info (create {PE_ITEM_INFO}.make (seq_pts.to_string_using_method_debug_information_entry (e)))
						end
					else
						idx.report_error (create {PE_INDEX_ERROR}.make (idx))
					end
				end
			elseif attached {PDB_DOCUMENT_NAME_BLOB_INDEX} idx.associated_structure then
				if
					idx.index > 0
				then
					if attached pdb_file.document_name_blob_heap_item (idx) as doc_name then
						doc_name.set_associated_pdb_file (pdb_file)
						doc_name.set_associated_table_entry (current_table_entry)
						idx.set_info (create {PE_ITEM_INFO}.make (doc_name.to_string))
					else
						idx.report_error (create {PE_INDEX_ERROR}.make (idx))
					end
				end
			else
				if
					idx.index > 0
				then
					if attached pdb_file.blob_heap_item (idx) as blb then
						idx.set_info (create {PE_ITEM_INFO}.make (blb.dump))
					else
						idx.report_error (create {PE_INDEX_ERROR}.make (idx))
					end
				end
			end
		end

	visit_guid_index_item (idx: PE_GUID_INDEX_ITEM)
		do
			if
				not idx.is_null_index
			then
				if attached pdb_file.guid_heap_item (idx) as g then
					idx.set_info (create {PE_ITEM_INFO}.make (g.to_string))
				else
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
				end
			end
		end

	visit_guid_item (i: PE_GUID_ITEM)
		do
			do_nothing
		end

end
