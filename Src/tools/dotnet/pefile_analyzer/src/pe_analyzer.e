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

	visit_tables (o: PE_MD_TABLES)
		do
			Precursor (o)
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
			if
				attached {PE_METHOD_DEF_INDEX_ITEM} o as mtd_index and then
				mtd_index.index > 0
			then
				if attached pe_file.method_def (mtd_index) as m then
					if
						attached m.name_index as m_name and then
						attached pe_file.string_heap_item (m_name) as s
					then
						o.set_info (create {PE_ITEM_INFO}.make (s))
					else
						o.set_info (create {PE_ITEM_INFO}.make (m.to_string))
					end
				else
					o.report_error (create {PE_INDEX_ERROR}.make (mtd_index))
				end
			elseif
				attached {PE_MEMBER_REF_INDEX_ITEM} o as m_index and then
				m_index.index > 0
			then
				if attached pe_file.member_ref (m_index) as m then
					if
						attached m.name_index as m_name and then
						attached pe_file.string_heap_item (m_name) as s
					then
						o.set_info (create {PE_ITEM_INFO}.make (s))
					else
						o.set_info (create {PE_ITEM_INFO}.make (m.to_string))
					end
				else
					o.report_error (create {PE_INDEX_ERROR}.make (m_index))
				end
			elseif
				attached {PE_FIELD_INDEX_ITEM} o as fld_index and then
				fld_index.index > 0
			then
				if attached pe_file.field (fld_index) as f then
					if
						attached f.name_index as f_name and then
						attached pe_file.string_heap_item (f_name) as s
					then
						o.set_info (create {PE_ITEM_INFO}.make (s))
					else
						o.set_info (create {PE_ITEM_INFO}.make (fld_index.to_string))
					end
				else
					o.report_error (create {PE_INDEX_ERROR}.make (fld_index))
				end
			elseif
				attached {PE_PARAM_INDEX_ITEM} o as par_index and then
				par_index.index > 0
			then
				if attached pe_file.param (par_index) as p then
					if
						attached p.name_index as p_name and then
						attached pe_file.string_heap_item (p_name) as s
					then
						o.set_info (create {PE_ITEM_INFO}.make (s))
					else
						o.set_info (create {PE_ITEM_INFO}.make (par_index.to_string))
					end
				else
					o.report_error (create {PE_INDEX_ERROR}.make (par_index))
				end

			elseif
				attached {PE_PROPERTY_INDEX_ITEM} o as prp_index and then
				prp_index.index > 0
			then
				if attached pe_file.param (prp_index) as prp then
					if
						attached prp.name_index as prp_name and then
						attached pe_file.string_heap_item (prp_name) as s
					then
						o.set_info (create {PE_ITEM_INFO}.make (s))
					else
						o.set_info (create {PE_ITEM_INFO}.make (prp_index.to_string))
					end
				else
					o.report_error (create {PE_INDEX_ERROR}.make (prp_index))
				end

			elseif
				attached {PE_TYPE_DEF_INDEX_ITEM} o as tdef_index and then
				tdef_index.index > 0
			then

				if attached pe_file.type_def (tdef_index) as tdef then
					if
						attached tdef.name_index as tdef_name and then
						attached pe_file.string_heap_item (tdef_name) as s
					then
						o.set_info (create {PE_ITEM_INFO}.make (s))
					else
						o.set_info (create {PE_ITEM_INFO}.make (tdef_index.to_string))
					end
				else
					o.report_error (create {PE_INDEX_ERROR}.make (tdef_index))
				end
			elseif
				attached {PE_TYPE_REF_INDEX_ITEM} o as tref_index and then
				tref_index.index > 0
			then
				if attached pe_file.type_ref (tref_index) as tref then
					if
						attached tref.typename_index as tdef_typename and then
						attached pe_file.string_heap_item (tdef_typename) as s
					then
						o.set_info (create {PE_ITEM_INFO}.make (s))
					else
						o.set_info (create {PE_ITEM_INFO}.make (tref_index.to_string))
					end
				else
					o.report_error (create {PE_INDEX_ERROR}.make (tref_index))
				end
			elseif
				attached {PE_TYPE_SPEC_INDEX_ITEM} o as tspec_index and then
				tspec_index.index > 0
			then
				if attached pe_file.type_spec (tspec_index) as tspec then
					-- Found
				else
					o.report_error (create {PE_INDEX_ERROR}.make (tspec_index))
				end
			elseif
				attached {PE_STRING_INDEX_ITEM} o as tstring_index and then
				tstring_index.index > 0
			then
				if attached pe_file.string_heap_item (tstring_index) as str then
					o.set_info (create {PE_ITEM_INFO}.make (str))
				else
					o.report_error (create {PE_INDEX_ERROR}.make (tstring_index))
				end
			else

			end
			Precursor (o)
		end

end
