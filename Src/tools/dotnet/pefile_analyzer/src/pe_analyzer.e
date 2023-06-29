note
	description: "Summary description for {PE_ANALYZER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_ANALYZER

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

feature -- Access	

	error_count: NATURAL_32

feature -- Visitor

	reset
		do
			error_count := 0
		end

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

	current_table: detachable PE_MD_TABLE [PE_MD_TABLE_ENTRY]

	visit_table (o: PE_MD_TABLE [PE_MD_TABLE_ENTRY])
		do
			current_table := o
			update_list_indexes (o)
			Precursor (o)
			o.check_validity (pe_file)
			if o.has_error then
				error_count := error_count + o.error_count
			end
			current_table := Void
		end

	update_list_indexes (o: PE_MD_TABLE [PE_MD_TABLE_ENTRY])
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

	update_list_index (o: PE_MD_TABLE [PE_MD_TABLE_ENTRY]; label: READABLE_STRING_GENERAL)
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
						prev.index = idx.index
					then
						prev.update_index (0)
						l_updated := True
					end
					if attached {PE_INDEX_ITEM_WITH_TABLE} idx as idx_with_table then
						if idx.index = table_count (idx_with_table.associated_table_id) + 1 then
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

	current_table_entry: detachable PE_MD_TABLE_ENTRY

	visit_table_entry (o: PE_MD_TABLE_ENTRY)
		do
			current_table_entry := o
			Precursor (o)
			o.check_validity (pe_file)
			if o.has_error then
				error_count := error_count + o.error_count
			end
			current_table_entry := Void
		end

	visit_item (o: PE_ITEM)
		do
			if attached {PE_METHOD_DEF_INDEX_ITEM} o as mtd_index then
				visit_method_def_index_item (mtd_index)

			elseif attached {PE_MEMBER_REF_INDEX_ITEM} o as m_index then
				visit_member_ref_index_item (m_index)

			elseif attached {PE_FIELD_INDEX_ITEM} o as fld_index then
				visit_field_index_item (fld_index)

			elseif attached {PE_PARAM_INDEX_ITEM} o as par_index then
				visit_param_index_item (par_index)

			elseif attached {PE_EVENT_INDEX_ITEM} o as evt_index then
				visit_event_index_item (evt_index)

			elseif attached {PE_PROPERTY_INDEX_ITEM} o as prp_index then
				visit_property_index_item (prp_index)

			elseif attached {PE_TYPE_DEF_INDEX_ITEM} o as tdef_index then
				visit_type_def_index_item (tdef_index)

			elseif attached {PE_TYPE_REF_INDEX_ITEM} o as tref_index then
				visit_type_ref_index_item (tref_index)

			elseif attached {PE_TYPE_SPEC_INDEX_ITEM} o as tspec_index then
				visit_type_spec_index_item (tspec_index)

			elseif attached {PE_MODULE_INDEX_ITEM} o as tmod_index then
				visit_module_index_item (tmod_index)
			elseif attached {PE_MODULE_REF_INDEX_ITEM} o as tmodref_index then
				visit_moduleref_index_item (tmodref_index)

			elseif attached {PE_ASSEMBLY_INDEX_ITEM} o as tass_index then
				visit_assembly_index_item (tass_index)
			elseif attached {PE_ASSEMBLY_REF_INDEX_ITEM} o as tassref_index then
				visit_assemblyref_index_item (tassref_index)

			elseif attached {PE_STRING_INDEX_ITEM} o as tstring_index then
				visit_string_index_item (tstring_index)

			elseif attached {PE_BLOB_INDEX_ITEM} o as tblob_index then
				visit_blob_index_item (tblob_index)

			elseif attached {PE_GUID_INDEX_ITEM} o as tguid_index then
				visit_guid_index_item (tguid_index)

			elseif attached {PE_GUID_ITEM} o as tguid then
				visit_guid_item (tguid)

			elseif attached {PE_RVA_ITEM} o as trva then
				visit_rva_item (trva)

			elseif attached {PE_ATTRIBUTES_ITEM} o as tattrs then
					-- Warning: this is a common ancestor
				visit_attributes_item (tattrs)

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

	visit_attributes_item (o: PE_ATTRIBUTES_ITEM)
		do
			-- TODO
		end

	visit_rva_item (o: PE_RVA_ITEM)
		do
			-- TODO: check if the RVA value is in expected zone.
		end

	visit_method_def_index_item (idx: PE_METHOD_DEF_INDEX_ITEM)
		do
			if
				not idx.is_null_index and then
				idx.index /= table_count ({PE_TABLES}.tmethoddef) + 1
			then
				if attached pe_file.method_def (idx) as m then
					if
						attached m.name_index as m_name and then
						attached pe_file.string_heap_item (m_name) as s
					then
						idx.set_info (create {PE_ITEM_INFO}.make (s))
					else
						idx.set_info (create {PE_ITEM_INFO}.make_link (m.to_link_string))
					end
				else
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
				end
			end
		end

	visit_member_ref_index_item (idx: PE_MEMBER_REF_INDEX_ITEM)
		do
			if
				not idx.is_null_index and then idx.index /= table_count ({PE_TABLES}.tmemberref) + 1
			then
				if attached pe_file.member_ref (idx) as m then
					if attached m.resolved_identifier (pe_file) as s then
						idx.set_info (create {PE_ITEM_INFO}.make (s))
					else
						idx.set_info (create {PE_ITEM_INFO}.make_link (m.to_link_string))
					end
				else
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
				end
			end
		end

	visit_field_index_item (idx: PE_FIELD_INDEX_ITEM)
		do
			if
				not idx.is_null_index and then
				idx.index /= table_count ({PE_TABLES}.tfield) + 1
			then
				if attached pe_file.field (idx) as f then
					if attached f.resolved_identifier (pe_file) as s then
						idx.set_info (create {PE_ITEM_INFO}.make (s))
					else
						idx.set_info (create {PE_ITEM_INFO}.make (idx.to_string))
					end
				else
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
				end
			end
		end

	visit_param_index_item (idx: PE_PARAM_INDEX_ITEM)
		do
			if
				not idx.is_null_index and then idx.index /= table_count ({PE_TABLES}.tparam) + 1
			then
				if attached pe_file.param (idx) as p then
					if attached p.resolved_identifier (pe_file) as s then
						idx.set_info (create {PE_ITEM_INFO}.make (s))
					else
						idx.set_info (create {PE_ITEM_INFO}.make (idx.to_string))
					end
				else
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
				end
			end
		end

	visit_event_index_item (idx: PE_EVENT_INDEX_ITEM)
		do
			if
				idx.index > 0 and then idx.index /= table_count ({PE_TABLES}.tevent) + 1
			then
				if attached pe_file.event (idx) as ev then
					if
						attached ev.name_index as p_name and then
						attached pe_file.string_heap_item (p_name) as s
					then
						idx.set_info (create {PE_ITEM_INFO}.make (s))
					else
						idx.set_info (create {PE_ITEM_INFO}.make (idx.to_string))
					end
				else
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
				end
			end
		end

	visit_property_index_item (idx: PE_PROPERTY_INDEX_ITEM)
		do
			if
				not idx.is_null_index and then idx.index /= table_count ({PE_TABLES}.tproperty) + 1
			then
				if attached pe_file.param (idx) as prp then
					if attached prp.resolved_identifier (pe_file) as s then
						idx.set_info (create {PE_ITEM_INFO}.make (s))
					else
						idx.set_info (create {PE_ITEM_INFO}.make (idx.to_string))
					end
				else
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
				end
			end
		end

	visit_type_def_index_item (idx: PE_TYPE_DEF_INDEX_ITEM)
		do
			if
				not idx.is_null_index -- and then idx.index /= table_count ({PE_TABLES}.ttypedef) + 1
			then
				if attached pe_file.type_def (idx) as tdef then
					if attached tdef.resolved_identifier (pe_file) as s then
						idx.set_info (create {PE_ITEM_INFO}.make (s))
					else
						idx.set_info (create {PE_ITEM_INFO}.make_link (tdef.to_link_string))
					end
				else
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
				end
			end
		end

	visit_type_ref_index_item (idx: PE_TYPE_REF_INDEX_ITEM)
		do
			if
				not idx.is_null_index -- and then idx.index /= table_count ({PE_TABLES}.ttyperef) + 1
			then
				if attached pe_file.type_ref (idx) as tref then
					if attached tref.resolved_identifier (pe_file) as s then
						idx.set_info (create {PE_ITEM_INFO}.make (s))
					else
						idx.set_info (create {PE_ITEM_INFO}.make_link (tref.to_link_string))
					end
				else
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
				end
			end
		end

	visit_type_spec_index_item (idx: PE_TYPE_SPEC_INDEX_ITEM)
		do
			if
				not idx.is_null_index  -- and then idx.index /= table_count ({PE_TABLES}.ttypespec) + 1
			then
				if attached pe_file.type_spec (idx) as tspec then
					-- Found
				else
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
				end
			end
		end

	visit_module_index_item (idx: PE_MODULE_INDEX_ITEM)
		do
			if
				not idx.is_null_index  -- and then idx.index /= table_count ({PE_TABLES}.ttypespec) + 1
			then
				if attached pe_file.module (idx) as t then
					if attached t.resolved_identifier (pe_file) as s then
						idx.set_info (create {PE_ITEM_INFO}.make (s))
					else
--						idx.set_info (create {PE_ITEM_INFO}.make_link (t.to_link_string))
					end
					-- Found
				else
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
				end
			end
		end

	visit_moduleref_index_item (idx: PE_MODULE_REF_INDEX_ITEM)
		do
			if
				not idx.is_null_index  -- and then idx.index /= table_count ({PE_TABLES}.ttypespec) + 1
			then
				if attached pe_file.moduleref (idx) as t then
					if attached t.resolved_identifier (pe_file) as s then
						idx.set_info (create {PE_ITEM_INFO}.make (s))
					else
--						idx.set_info (create {PE_ITEM_INFO}.make_link (t.to_link_string))
					end
				else
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
				end
			end
		end

	visit_assembly_index_item (idx: PE_ASSEMBLY_INDEX_ITEM)
		do
			if
				not idx.is_null_index  -- and then idx.index /= table_count ({PE_TABLES}.ttypespec) + 1
			then
				if attached pe_file.assembly (idx) as t then
					if attached t.resolved_identifier (pe_file) as s then
						idx.set_info (create {PE_ITEM_INFO}.make (s))
					else
--						idx.set_info (create {PE_ITEM_INFO}.make_link (t.to_link_string))
					end
				else
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
				end
			end
		end

	visit_assemblyref_index_item (idx: PE_ASSEMBLY_REF_INDEX_ITEM)
		do
			if
				not idx.is_null_index  -- and then idx.index /= table_count ({PE_TABLES}.ttypespec) + 1
			then
				if attached pe_file.assemblyref (idx) as t then
					if attached t.resolved_identifier (pe_file) as s then
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
				if attached pe_file.string_heap_item (idx) as str then
					idx.set_info (create {PE_ITEM_INFO}.make (str))
				else
					idx.report_error (create {PE_INDEX_ERROR}.make (idx))
				end
			end
		end

	visit_blob_index_item (idx: PE_BLOB_INDEX_ITEM)
		do
			if attached {PE_SIGNATURE_BLOB_INDEX} idx.associated_structure then
				if
					idx.index > 0
				then
					if attached pe_file.signature_blob_heap_item (idx) as sig then
						sig.set_associated_pe_file (pe_file)
						sig.set_associated_table_entry (current_table_entry)
						idx.set_info (create {PE_ITEM_INFO}.make (sig.to_string))
					else
						idx.report_error (create {PE_INDEX_ERROR}.make (idx))
					end
				end
			else
				if
					idx.index > 0
				then
					if attached pe_file.blob_heap_item (idx) as blb then
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
				if attached pe_file.guid_heap_item (idx) as g then
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
