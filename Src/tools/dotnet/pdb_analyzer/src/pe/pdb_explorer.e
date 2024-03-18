note
	description: "Summary description for {PDB_EXPLORER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PDB_EXPLORER

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

	make (o: APP_OUTPUT; pdb: PDB_FILE)
		do
			output := o
--			create output.make (io.error) -- HACK to console
			pdb_file := pdb
			create printer.make (output)
		end

	output: APP_OUTPUT

	pdb_file: PDB_FILE

	printer: PDB_PRINTER

feature -- Visitor

	visit_pdb_file (o: PDB_FILE)
		do
			output.put_line_divider
			output.put_string ("[[ Explorer ]]%N")

			check o = pdb_file end
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

	visit_tables (o: PDB_MD_TABLES)
		do
			if attached o.document_table as mtb then
				visit_document_table (mtb)
			end
--			if attached o.method_debug_information_table as mtb then
--				visit_method_debug_information_table (mtb)
--			end
			if attached o.local_scope_table as mtb then
				visit_local_scope_table (mtb)
			end
			if attached o.import_scope_table as mtb then
				visit_import_scope_table (mtb)
			end
--			Precursor (o)
		end

	visit_table (o: PDB_MD_TABLE [PDB_MD_TABLE_ENTRY])
		do
--			Precursor (o)
		end

	visit_document_table (o: PDB_MD_TABLE_DOCUMENT)
		local
			e: PDB_MD_TABLE_DOCUMENT_ENTRY
		do
			output.put_string (o.entries_count.out + " documents%N")
			output.put_line_divider
			across
				o.entries as ic
			loop
				e := ic.item
				visit_document (e)
			end
		end

	visit_method_debug_information_table (o: PDB_MD_TABLE_METHOD_DEBUG_INFORMATION)
		local
			e: PDB_MD_TABLE_METHOD_DEBUG_INFORMATION_ENTRY
		do
			output.put_string (o.entries_count.out + " methods (debug info)%N")
			output.put_line_divider
			across
				o.entries as ic
			loop
				e := ic.item
				visit_method_debug_information (e)
			end
		end

	variables: detachable MD_INDEX_LIST [PDB_MD_TABLE_LOCAL_SCOPE]

	visit_local_scope_table (o: PDB_MD_TABLE_LOCAL_SCOPE)
		local
			i,n: INTEGER
			vars: MD_INDEX_LIST [PDB_MD_TABLE_LOCAL_SCOPE]
			e: PDB_MD_TABLE_LOCAL_SCOPE_ENTRY
		do
			i := 1
			create vars.make (o.entries.count)
			variables := vars

			across
				o.entries as ic
			loop
				e := ic.item
				if attached e.variables as idx then
					vars.force (idx.index, idx.index, e)
				end
				i := i + 1
			end
			vars.update

			output.put_string (o.entries_count.out + " local scopes%N")
			output.put_line_divider
			across
				o.entries as ic
			loop
				e := ic.item
				visit_local_scope (e)
			end
		end

	visit_import_scope_table (o: PDB_MD_TABLE_IMPORT_SCOPE)
		local
			e: PDB_MD_TABLE_IMPORT_SCOPE_ENTRY
		do
			output.put_string (o.entries_count.out + " Import scopes%N")
			output.put_line_divider
			across
				o.entries as ic
			loop
				e := ic.item
				visit_import_scope (e)
			end
		end

	current_table_entry: detachable PDB_MD_TABLE_ENTRY

	visit_table_entry (o: PDB_MD_TABLE_ENTRY)
		do
			current_table_entry := o
			if attached {PDB_MD_TABLE_METHOD_DEBUG_INFORMATION_ENTRY} o as mtd then
				visit_method_debug_information (mtd)
			elseif attached {PDB_MD_TABLE_DOCUMENT_ENTRY} o as doc then
				visit_document (doc)
			elseif attached {PDB_MD_TABLE_LOCAL_SCOPE_ENTRY} o as locsco then
				visit_local_scope (locsco)
			else
			end
			Precursor (o)
			current_table_entry := Void
		end

	visit_document (e: PDB_MD_TABLE_DOCUMENT_ENTRY)
		do
			output_token (e)
			output.put_string ("[Document]")
			if attached e.name_index as l_name_idx then
				if attached pdb_file.document_name_blob_heap_item (l_name_idx) as b then
					b.set_associated_pdb_file (pdb_file)
					b.set_associated_table_entry (current_table_entry)
					output.put_string (b.to_string)
				else
					output.put_string (l_name_idx.token.to_hex_string)
				end
			end
			if attached e.language_index as l_lang_idx then
				output.put_string (" Language(")
				if attached pdb_file.guid_heap_item (l_lang_idx) as g then
					output.put_string (g.value)
				else
					output.put_string (l_lang_idx.token.to_hex_string)
				end
				output.put_string (")")
			end
			output.put_new_line
			output.indent
			if attached pdb_file.metadata_tables.method_debug_information_table as tb then
				across
					tb.entries as ic
				loop
					if
						attached {PE_DOCUMENT_INDEX_ITEM} ic.item.document_row_id as l_document_row_id and then
						l_document_row_id.token = e.token
					then
						visit_method_debug_information (ic.item)
					end
				end
			end
			output.exdent
		end

	visit_method_debug_information (e: PDB_MD_TABLE_METHOD_DEBUG_INFORMATION_ENTRY)
		local
			err: BOOLEAN
		do
			output_token (e)
			output.put_new_line
			output.indent
			if
				attached e.sequence_points (pdb_file) as seq_pts and then
				attached seq_pts.to_sequence_points (pdb_file, e) as d
			then
				err := d.has_error
				output.put_string ("LocalSignature: ")
				output.put_string (d.local_token.to_hex_string)
				output.put_new_line
				across
					d.points as ic
				loop
					output.put_string (ic.item.debug_output)
					output.put_new_line
				end
			else
				err := True
			end
			if err then
				output.put_string ("ERROR occurred!")
				output.put_new_line
			end
			output.exdent
		end

	visit_local_scope (e: PDB_MD_TABLE_LOCAL_SCOPE_ENTRY)
		local
			i,u: NATURAL_32
		do
			output_token (e)
--			output.put_new_line
			if attached e.method as m then
				output.put_string (" Method: " + m.token.to_hex_string)
				if
					attached pdb_file.metadata_tables.method_debug_information_table as tb and then
					not tb.valid_index (m.index)
				then
					output.put_string ("OUT-OF-RANGE MethodToken!")

				end
			end
			if attached e.import_scope as imp then
				output.put_string (" ImportScope: " + imp.token.to_hex_string)
				if
					attached pdb_file.metadata_tables.import_scope_table as l_import_scope_tb and then
					attached l_import_scope_tb [imp.index] as iscp and then
					attached iscp.imports_index as b_imports_idx
				then
					if b_imports_idx.is_null_index then
						output.put_string (" NULL")
					elseif attached pdb_file.import_scope_blob_heap_item (b_imports_idx) as b then
						output.put_string (b.to_string)
					else
						output.put_string (b_imports_idx.token.to_hex_string)
					end
				end
			end
			output.put_string (" Start: IL_" + e.start_offset.to_hex_string)
			output.put_string (" Length: " + e.length.out)
			output.put_string (" Variables: ")

			if attached e.variables as vars then
				if
					attached pdb_file.metadata_tables.local_variable_table as l_loc_var_tb and then
					attached variables as lst and then
					attached lst.indexes (e) as vars_indexes
				then
					output.put_string (vars_indexes.nb.out)
					output.put_new_line
					output.indent
					from
						i := vars_indexes.lower_index
						u := vars_indexes.upper_index
					until
						i > u
					loop
						if
							attached l_loc_var_tb [i] as v and then
							attached v.resolved_identifier (pdb_file) as l_name
						then
							output.put_string (v.index_value.out)
							output.put_string (": %"")
							output.put_string (l_name)
							output.put_string ("%"")
							output.put_new_line
						end
						i := i + 1
					end
					output.exdent
				else
					output.put_string (" 0 at 0x" + vars.token.to_hex_string)
					output.put_new_line
				end
			end
		end

	visit_import_scope (e: PDB_MD_TABLE_IMPORT_SCOPE_ENTRY)
		do
			output_token (e)
			if
				attached e.parent as l_parent_imports_idx
			then
				output.put_string ("Parent: ")
				output.put_string (l_parent_imports_idx.token.to_hex_string)
				output.put_string (" ")
			end

			if
				attached e.imports_index as b_imports_idx
			then
				if b_imports_idx.is_null_index then
					output.put_string ("NULL")
				elseif attached pdb_file.import_scope_blob_heap_item (b_imports_idx) as b then
					b.set_associated_pdb_file (pdb_file)
					b.set_associated_table_entry (e)
					output.put_string (b.to_string)
				else
					output.put_string (b_imports_idx.token.to_hex_string)
				end
			end
			output.put_new_line
		end


	visit_item (o: PE_ITEM)
		do
			Precursor (o)
		end

	output_token (e: PDB_MD_TABLE_ENTRY)
		do
			if e.has_token then
				output.put_string ("/*0x" + e.token.to_hex_string + "*/ ")
			end
		end

end
