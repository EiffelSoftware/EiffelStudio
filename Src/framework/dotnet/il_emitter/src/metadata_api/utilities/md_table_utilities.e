note
	description: "[

	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TABLE_UTILITIES

create
	make

feature {NONE} -- Initialization

	make (e: MD_EMIT)
		do
			emitter := e
		end

feature -- Access

	emitter: MD_EMIT

	md_table (idx: NATURAL_32): detachable MD_TABLE
		do
			Result := emitter.md_table (idx)
		end

	typedef_table: detachable MD_TABLE
		do
			Result := md_table ({PE_TABLES}.ttypedef)
		end

	methoddef_table: detachable MD_TABLE
		do
			Result := md_table ({PE_TABLES}.tmethoddef)
		end

	field_table: detachable MD_TABLE
		do
			Result := md_table ({PE_TABLES}.tfield)
		end

	param_table: detachable MD_TABLE
		do
			Result := md_table ({PE_TABLES}.tparam)
		end

feature -- Saving preparation	

	prepare_to_save
			-- Prepare data to be save
		local
			max_field_idx, max_meth_idx, max_param_idx: NATURAL_32
			field_idx, meth_idx, param_idx: NATURAL_32
			l_missing_field_index_entries: ARRAYED_LIST [PE_TYPE_DEF_TABLE_ENTRY]
			l_missing_method_index_entries: ARRAYED_LIST [PE_TYPE_DEF_TABLE_ENTRY]
			l_missing_param_index_entries: ARRAYED_LIST [PE_METHOD_DEF_TABLE_ENTRY]
		do
				-- Ensure FieldList and MethodList columns are ordered in TypeDef
			ensure_field_list_column_is_ordered
			ensure_method_list_column_is_ordered
				-- Ensure ParamList column is ordered in MethodDef
			ensure_param_list_column_is_ordered


				-- Update all uninitialized PE_LIST (FieldList, MethodList, ParamList, ...)
			if attached methoddef_table as tb then
				max_meth_idx := tb.next_index
			end
			if attached field_table as tb then
				max_field_idx := tb.next_index
			end
			if attached param_table as tb then
				max_param_idx := tb.next_index
			end

				-- TypeDef table
			if attached typedef_table as typedef_tb then
				across
					typedef_tb as e
				loop
					if attached {PE_TYPE_DEF_TABLE_ENTRY} e as l_type_def_entry then
							-- FieldList
						if l_type_def_entry.is_field_list_index_set then
							field_idx := l_type_def_entry.fields.index
							if l_missing_field_index_entries /= Void then
								across
									l_missing_field_index_entries as t
								loop
									t.fields.update_missing_index (l_type_def_entry.fields.index)
								end
								l_missing_field_index_entries.wipe_out
							end
						else
							if l_missing_field_index_entries = Void then
								create l_missing_field_index_entries.make (10)
							end
							l_missing_field_index_entries.force (l_type_def_entry)
						end

							-- MethodList
						if l_type_def_entry.is_method_list_index_set then
							meth_idx := l_type_def_entry.methods.index
							if l_missing_method_index_entries /= Void then
								across
									l_missing_method_index_entries as t
								loop
									t.methods.update_missing_index (l_type_def_entry.methods.index)
								end
								l_missing_method_index_entries.wipe_out
							end
						else
							if l_missing_method_index_entries = Void then
								create l_missing_method_index_entries.make (10)
							end
							l_missing_method_index_entries.force (l_type_def_entry)
						end
					else
						check is_type_def: False end
					end
				end
				if l_missing_field_index_entries /= Void then
					across
						l_missing_field_index_entries as t
					loop
						t.fields.update_missing_index (max_field_idx)
					end
					l_missing_field_index_entries := Void
				end
				if l_missing_method_index_entries /= Void then
					across
						l_missing_method_index_entries as t
					loop
						t.methods.update_missing_index (max_meth_idx)
					end
					l_missing_method_index_entries := Void
				end
			end

				-- MethodDef table
			if attached methoddef_table as methoddef_tb then
				across
					methoddef_tb as e
				loop
					if attached {PE_METHOD_DEF_TABLE_ENTRY} e as l_method_def_entry then
							-- ParamList
						if l_method_def_entry.is_param_list_index_set then
							param_idx := l_method_def_entry.param_index.index
							if l_missing_param_index_entries /= Void then
								across
									l_missing_param_index_entries as m
								loop
									m.param_index.update_missing_index (l_method_def_entry.param_index.index)
								end
								l_missing_param_index_entries.wipe_out
							end
						else
							if l_missing_param_index_entries = Void then
								create l_missing_param_index_entries.make (10)
							end
							l_missing_param_index_entries.force (l_method_def_entry)
						end
					else
						check is_method_def: False end
					end
				end
				if l_missing_param_index_entries /= Void then
					across
						l_missing_param_index_entries as t
					loop
						t.param_index.update_missing_index (max_param_idx)
					end
					l_missing_param_index_entries := Void
				end
			end

				-- Sort tables...
				-- CustomAttribute table
			ensure_table_is_sorted ({PE_TABLES}.tcustomattribute)
			ensure_table_is_sorted ({PE_TABLES}.tinterfaceimpl)
			ensure_table_is_sorted ({PE_TABLES}.tmethodimpl)
			ensure_table_is_sorted ({PE_TABLES}.tmethodsemantics)
		end

feature -- Table sorting		

	ensure_table_is_sorted (tb_id: NATURAL_32)
			-- Ensure table associated with `tb_id` is sorted.
		do
			if
				attached md_table (tb_id) as tb and then
				attached table_sorter (tb_id) as l_sorter
			then
				debug ("il_emitter")
					if not tb.is_sorted (l_sorter) then
						print ("Table ["+ tb_id.to_natural_8.to_hex_string +"] is NOT sorted%N")
					end
				end
				tb.sort (l_sorter)
				check tb.is_sorted (l_sorter) end
			end
		end

	table_sorter (tb_id: NATURAL_32): detachable QUICK_SORTER [PE_TABLE_ENTRY_BASE]
			-- Sorter for table associated with `tb_id`.
		local
			l_comparator: AGENT_EQUALITY_TESTER [PE_TABLE_ENTRY_BASE]
		do
			inspect tb_id
			when {PE_TABLES}.tcustomattribute then
				create l_comparator.make (agent (e1, e2: PE_TABLE_ENTRY_BASE): BOOLEAN
					do
						if
							attached {PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY} e1 as o1 and then
							attached {PE_CUSTOM_ATTRIBUTE_TABLE_ENTRY} e2 as o2
						then
							Result := o1.less_than (o2)
						end
					end)
			when {PE_TABLES}.tinterfaceimpl then
				create l_comparator.make (agent (e1, e2: PE_TABLE_ENTRY_BASE): BOOLEAN
					do
						if
							attached {PE_INTERFACE_IMPL_TABLE_ENTRY} e1 as o1 and then
							attached {PE_INTERFACE_IMPL_TABLE_ENTRY} e2 as o2
						then
							Result := o1.less_than (o2)
						end
					end)
			when {PE_TABLES}.tmethodimpl then
				create l_comparator.make (agent (e1, e2: PE_TABLE_ENTRY_BASE): BOOLEAN
					do
						if
							attached {PE_METHOD_IMPL_TABLE_ENTRY} e1 as o1 and then
							attached {PE_METHOD_IMPL_TABLE_ENTRY} e2 as o2
						then
							Result := o1.less_than (o2)
						end
					end)
			when {PE_TABLES}.tmethodsemantics then
				create l_comparator.make (agent (e1, e2: PE_TABLE_ENTRY_BASE): BOOLEAN
					do
						if
							attached {PE_METHOD_SEMANTICS_TABLE_ENTRY} e1 as o1 and then
							attached {PE_METHOD_SEMANTICS_TABLE_ENTRY} e2 as o2
						then
							Result := o1.less_than (o2)
						end
					end)
			else
				-- Not implemented or not needed
			end
			if l_comparator /= Void then
				create Result.make (l_comparator)
			end
		end

feature -- Column sorting

	table_token (idx: NATURAL_32; tb: INTEGER_32): NATURAL_32
		do
			Result := (tb.to_natural_32 |<< 24) | idx
		ensure
			class
		end

	table_name (id: INTEGER_32): STRING_8
		do
			inspect id
			when {PE_TABLES}.ttypedef  then Result := "TypeDef"
			when {PE_TABLES}.tmethoddef  then Result := "MethodDef"
			when {PE_TABLES}.tfield  then Result := "Field"
			when {PE_TABLES}.tparam  then Result := "Param"
			else
				Result := "Table#" + id.to_natural_8.to_hex_string
			end
		ensure
			class
		end

	partial_sort_list (a_list: like {MD_TABLE_COLUMN_UTILITIES [PE_TABLE_ENTRY_BASE]}.unsorted_list_indexes;
					ut: MD_TABLE_COLUMN_UTILITIES [PE_TABLE_ENTRY_BASE]
				)
			-- We do partial sorting over the unsorted field list `a_list`
			-- Update the metadata table {PE_TABLES}.ttypedef
			-- Update the MD_REMAP_MANAGER
		local
			i, n: INTEGER
			l_item: TUPLE [index, next: NATURAL_32]
			idx, l_end_index: NATURAL_32
		do
			from
				i := 1
				n := a_list.count
			until
				i > n
			loop
				l_item := a_list [i]
				l_end_index := ut.end_index_of_list (l_item.index)
				debug ("il_emitter_table")
					print ("@"+table_name (ut.table_for_column.table_id)+"@ Partial Sort: ")
					print (" index=" + table_token (l_item.index, ut.table_for_column.table_id).to_hex_string)
					print (" before=" + table_token (l_item.next, ut.table_for_column.table_id).to_hex_string)
					from
						print (" -> (" + (l_end_index - l_item.index +1).out + ") %N")
						idx := l_item.index
					until
						idx > l_end_index
					loop
						print ("%T0x" + table_token (idx, ut.table_for_column.table_id).to_hex_string + "%N")
						idx := idx + 1
					end
					print ("%N")
				end
				ut.move_tokens (l_item.index, l_end_index, l_item.next)
				i := i + 1
			end
			ut.remap.commit
		end

	sort_list_column (ut: MD_TABLE_COLUMN_UTILITIES [PE_TABLE_ENTRY_BASE])
		do
			if
				attached ut.unsorted_list_indexes as lst and then
				not lst.is_empty
			then
				--print (ut.remapped_table_dump)
				--print ("%N")
				partial_sort_list (lst, ut)
				--print (ut.remapped_table_dump)
				--print ("%N")

					-- Recursive sorting..
				sort_list_column (ut)
			else
				-- The Metadata Tokens for Token List are sorted in the container table
				-- and the token remap manager has the tokens remaps to be applied to
				-- the corresponding tables.
			end
		end

feature -- FieldList column sorting in TypeDef

	ensure_field_list_column_is_ordered
		local
			ut: MD_TABLE_COLUMN_UTILITIES [PE_TYPE_DEF_TABLE_ENTRY]
			vis: MD_FIELD_TOKEN_REMAPPER
		do
			if
				attached typedef_table as tb and then
				attached field_table as col_tb
			then
				create ut.make (tb, col_tb, agent (e: PE_TYPE_DEF_TABLE_ENTRY): PE_LIST do Result := e.fields end)

				sort_list_column (ut)
				if not ut.remap.is_empty then
					-- Update tables with remapped tokens!
					ut.apply_remapping
						-- Updated tokens in the related tables (For instance: TypeDef table, ...)
					create vis.make (ut.remap)
					vis.visit_emitter (emitter)

					ut.remap.reset
				end
			end
		end

feature -- MethodList column sorting in TypeDef

	ensure_method_list_column_is_ordered
		local
			ut: MD_TABLE_COLUMN_UTILITIES [PE_TYPE_DEF_TABLE_ENTRY]
			vis: MD_METHOD_DEF_TOKEN_REMAPPER
		do
			if
				attached typedef_table as tb and then
				attached methoddef_table as col_tb
			then
				create ut.make (tb, col_tb, agent (e: PE_TYPE_DEF_TABLE_ENTRY): PE_LIST do Result := e.methods end)

				sort_list_column (ut)
				if not ut.remap.is_empty then
					ut.apply_remapping
						-- Updated tokens in the related tables (For instance: TypeDef table, ...)
					create vis.make (ut.remap)
					vis.visit_emitter (emitter)
				end
			end
		end

feature -- ParamList column sorting in MethodDef		

	ensure_param_list_column_is_ordered
		local
			ut: MD_TABLE_COLUMN_UTILITIES [PE_METHOD_DEF_TABLE_ENTRY]
			vis: MD_PARAM_TOKEN_REMAPPER
		do
			if
				attached methoddef_table as tb and then
				attached param_table as col_tb
			then
				create ut.make (tb, col_tb, agent (e: PE_METHOD_DEF_TABLE_ENTRY): PE_LIST do Result := e.param_index end)

				sort_list_column (ut)
				if not ut.remap.is_empty then
					ut.apply_remapping
						-- Updated tokens in the related tables (For instance: TypeDef table, ...)
					create vis.make (ut.remap)
					vis.visit_emitter (emitter)
				end
			end
		end

end
