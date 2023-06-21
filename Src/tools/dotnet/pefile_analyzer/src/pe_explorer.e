note
	description: "Summary description for {PE_EXPLORER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_EXPLORER

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

	make (o: APP_OUTPUT; pe: PE_FILE)
		do
			output := o
--			create output.make (io.error) -- HACK to console
			pe_file := pe
			create printer.make (output)
		end

	output: APP_OUTPUT

	pe_file: PE_FILE

	printer: PE_PRINTER

feature -- Visitor

	visit_pe_file (o: PE_FILE)
		do
			output.put_line_divider
			output.put_string ("[[ Explorer ]]%N")

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
			if attached o.methoddef_table as mtb then
				visit_methoddef_table (mtb)
			end

			if attached o.typedef_table as ttb then
				visit_typedef_table (ttb)
			end
--			Precursor (o)
		end

	visit_table (o: PE_MD_TABLE [PE_MD_TABLE_ENTRY])
		do
			if
				o.table_id = {PE_TABLES}.ttypedef and then
				attached {PE_MD_TABLE_TYPEDEF} o as tb
			then
				visit_typedef_table (tb)
			end
--			Precursor (o)
		end

	typedef_methods: detachable MD_INDEX_LIST [PE_MD_TABLE_TYPEDEF]
	typedef_fields: detachable MD_INDEX_LIST [PE_MD_TABLE_TYPEDEF]

	visit_typedef_table (o: PE_MD_TABLE_TYPEDEF)
		local
			tdef: PE_MD_TABLE_TYPEDEF_ENTRY
			i,n: INTEGER
			methods: MD_INDEX_LIST [PE_MD_TABLE_TYPEDEF]
			fields: MD_INDEX_LIST [PE_MD_TABLE_TYPEDEF]
		do
			i := 1
			create fields.make (o.entries.count)
			typedef_fields := fields
			create methods.make (o.entries.count)
			typedef_methods := methods

			across
				o.entries as ic
			loop
				tdef := ic.item
				if attached tdef.method_list as idx then
					methods.force (idx.index, idx.index, tdef)
				end
				if attached tdef.field_list as idx then
					fields.force (idx.index, idx.index, tdef)
				end
				i := i + 1
			end
			methods.update
			fields.update

			output.put_string (o.entries_count.out + " types%N")
			output.put_line_divider

			across
				o.entries as ic
			loop
				tdef := ic.item
				visit_typedef_entry (tdef)
			end
		end

	methoddef_params: detachable MD_INDEX_LIST [PE_MD_TABLE_METHODDEF]

	visit_methoddef_table (o: PE_MD_TABLE_METHODDEF)
		local
			mdef: PE_MD_TABLE_METHODDEF_ENTRY
			i,n: INTEGER
			params: like methoddef_params
		do
			i := 1
			create params.make (o.entries.count)
			methoddef_params := params

			across
				o.entries as ic
			loop
				mdef := ic.item
				if attached mdef.param_list as idx then
					params.force (idx.index, idx.index, mdef)
				end
				i := i + 1
			end
			params.update
		end

	typedef_fullname (e: PE_MD_TABLE_TYPEDEF_ENTRY): STRING_32
		do
			create Result.make (0)
			if
				attached e.namespace_index as e_ns and then
				attached pe_file.string_heap_item (e_ns) as str
			then
				Result.append (str.to_string_32)
				Result.append_character ('.')
			end

			if
				attached e.name_index as e_n and then
				attached pe_file.string_heap_item (e_n) as str
			then
				Result.append (str.to_string_32)
			end
			if Result.is_empty then
				Result := "{?TypeDef?}"
				check has_name: False end
			end
		end

	typeref_fullname (e: PE_MD_TABLE_TYPEREF_ENTRY): STRING_32
		do
			create Result.make (0)
			if
				attached e.typenamespace_index as e_ns and then
				attached pe_file.string_heap_item (e_ns) as str
			then
				Result.append (str.to_string_32)
				Result.append_character ('.')
			end

			if
				attached e.typename_index as e_n and then
				attached pe_file.string_heap_item (e_n) as str
			then
				Result.append (str.to_string_32)
			end
			if Result.is_empty then
				Result := "{?TypeRef?}"
				check has_name: False end
			end
		end

	visit_typedef_entry (e: PE_MD_TABLE_TYPEDEF_ENTRY)
		local
			n,ns: STRING_32
			l_display: BOOLEAN
		do
			l_display := True
			if attached e.type_attributes as attribs then
				l_display := not attribs.is_nested_private
				if l_display then
					output_token (e)
					output_attributes (attribs)
				end
			else
				output_token (e)
			end
			if l_display then
				output.put_new_line
				output.indent
				output.put_string (typedef_fullname (e))

				if attached e.extends_index as l_parent_index then
					output.put_new_line
					output.indent
					output.put_string (" extends ")
					if attached {PE_TYPE_DEF_INDEX_ITEM} l_parent_index as l_parent_type_def then
						if attached pe_file.type_def (l_parent_index) as tdef then
							output.put_string (typedef_fullname (tdef))
						end
					elseif attached {PE_TYPE_REF_INDEX_ITEM} l_parent_index as l_parent_type_ref then
						if attached pe_file.type_ref (l_parent_index) as tref then
							output.put_string (typeref_fullname (tref))
						end
					elseif attached {PE_TYPE_SPEC_INDEX_ITEM} l_parent_index as l_parent_type_spec then
						if attached pe_file.type_spec (l_parent_index) as tspec then
							output.put_string ({STRING_32} "{TypeSpec#"+ l_parent_type_spec.to_string +"}")
						end
					else
						check is_def_or_ref_or_spec: False end
					end
					output.exdent
				end

				output.put_new_line
				if attached e.field_list as flst then
					if
						attached typedef_fields as lst and then
						attached lst.indexes (e) as l_range
					then
						output.put_string ("Fields("+ l_range.nb.out +"):%N")
						output.indent
						if attached pe_file.fields (flst, l_range.nb) as l_fields then
							across
								l_fields as f_ic
							loop
								f_ic.item.accepts (Current)
							end
						end
						output.exdent
					end
				end
				if attached e.method_list as flst then
					if
						attached typedef_methods as lst and then
						attached lst.indexes (e) as l_range
					then
						output.put_string ("Methods("+ l_range.nb.out +"):%N")
						output.indent
						if attached pe_file.methods (flst, l_range.nb) as l_methods then
							across
								l_methods as m_ic
							loop
								m_ic.item.accepts (Current)
							end
						end
						output.exdent
					end
				end

				output.exdent
				output.put_line_divider
			end
		end

	visit_table_entry (o: PE_MD_TABLE_ENTRY)
		do
			if attached {PE_MD_TABLE_METHODDEF_ENTRY} o as mtd then
				visit_method_def (mtd)
			elseif attached {PE_MD_TABLE_FIELD_ENTRY} o as fld then
				visit_field (fld)
			elseif attached {PE_MD_TABLE_PARAM_ENTRY} o as par then
				visit_param (par)
			elseif attached {PE_MD_TABLE_PROPERTY_ENTRY} o as prp then
				visit_property (prp)
			elseif attached {PE_MD_TABLE_EVENT_ENTRY} o as evt then
				visit_event (evt)
			else
			end
			Precursor (o)
		end

	visit_method_def (e: PE_MD_TABLE_METHODDEF_ENTRY)
		local
			n: NATURAL_32
			l_is_first: BOOLEAN
		do
--			output.put_string (e.to_string + "%N")
			output_token (e)
			output_attributes (e.method_attributes)
			output.put_new_line
			if
				attached e.name_index as str_idx and then
				str_idx.index > 0 and then
				attached pe_file.string_heap_item (str_idx) as str
			then
				output.put_string (str.to_string_32)
			else
				output.put_string ("?")
			end
			if attached e.param_list as plst then
				if
					attached methoddef_params as lst and then
					attached lst.indexes (e) as l_range
				then
					output.put_string (" (")
					if attached pe_file.params (plst, l_range.nb) as l_params then
						n := l_range.nb
						l_is_first := True
						across
							l_params as p_ic
						loop
							if l_is_first then
								l_is_first := False
							else
								output.put_string (", ")
							end
							p_ic.item.accepts (Current)
							n := n - 1
						end
						if n > 0 then
							output.put_string (" /* ERROR: missing " + n.out + " parameters*/")
						end
					end
					output.put_string (")")
				end
			end
			output_signature (e.signature_index)
			output.put_new_line
		end

	visit_field (e: PE_MD_TABLE_FIELD_ENTRY)
		do
--			output.put_string (o.to_string + "%N")
			output_token (e)
			output_attributes (e.field_attributes)
			output.put_new_line

			if
				attached e.name_index as str_idx and then
				str_idx.index > 0 and then
				attached pe_file.string_heap_item (str_idx) as str
			then
				output.put_string (str.to_string_32)
			else
				output.put_string ("???")
			end

			output_signature (e.signature_index)
			output.put_new_line
		end

	visit_param (e: PE_MD_TABLE_PARAM_ENTRY)
		do
--			output.put_string (o.to_string + "%N")
			output_token (e)

			output_attributes (e.param_attributes)

			if attached e.sequence as seq then
				output.put_string ("#"+seq.value.out + ":")
			else
				check has_sequence: False end
			end
			if
				attached e.name_index as str_idx and then
				str_idx.index > 0 and then
				attached pe_file.string_heap_item (str_idx) as str
			then
				output.put_string (str.to_string_32)
			else
				output.put_string ("?")
			end
		end

	visit_property (o: PE_MD_TABLE_PROPERTY_ENTRY)
		do
--			output.put_string (o.to_string + "%N")
		end

	visit_event (o: PE_MD_TABLE_EVENT_ENTRY)
		do
--			output.put_string (o.to_string + "%N")
		end


	visit_item (o: PE_ITEM)
		do
			Precursor (o)
		end

	output_attributes (attribs: detachable PE_ATTRIBUTES_ITEM)
		do
			if
				attribs /= Void and then
				attached attribs.to_flags_string as s and then
				not s.is_whitespace
			then
				if s.ends_with (" ") then
					s.remove_tail (1)
				end
				output.put_string ("/")
				output.put_string (s)
				output.put_string ("/%T")
			end
		end

	output_signature (sig_index: detachable PE_BLOB_INDEX_ITEM)
		do
			if
				attached sig_index and then
				attached pe_file.signature_blob_heap_item (sig_index) as sig
			then
				output.put_string (" :")
				output.put_string (sig.to_string)
			end
		end

	output_token (e: PE_MD_TABLE_ENTRY)
		do
			if e.has_token then
				output.put_string ("/*" + e.token.to_hex_string + "*/ ")
			end
		end

end
