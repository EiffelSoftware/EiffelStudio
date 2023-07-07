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
									t.set_field_list_index (l_type_def_entry.fields.index)
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
									t.set_method_list_index (l_type_def_entry.methods.index)
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
						t.set_field_list_index (max_field_idx)
					end
					l_missing_field_index_entries := Void
				end
				if l_missing_method_index_entries /= Void then
					across
						l_missing_method_index_entries as t
					loop
						t.set_method_list_index (max_meth_idx)
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
									m.set_param_list_index (l_method_def_entry.param_index.index)
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
						t.set_param_list_index (max_param_idx)
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

				-- Ensure FieldListand MethodList columns are ordered in TypeDef
			ensure_field_list_column_is_ordered
			ensure_method_list_column_is_ordered
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

	token (idx: NATURAL_32; tb: NATURAL_32): NATURAL_32
		do
			Result := (tb |<< 24) | idx
		end

feature -- FieldList column sorting

	ensure_field_list_column_is_ordered
		local
			ut: MD_TABLE_COLUMN_UTILITIES [PE_TYPE_DEF_TABLE_ENTRY]
		do
			if
				attached typedef_table as tb and then
				attached field_table as col_tb
			then
				create ut.make (tb, col_tb, agent (e: PE_TYPE_DEF_TABLE_ENTRY): PE_LIST do Result := e.fields end)

				sort_fields_list_column (ut)
				if not ut.remap.is_empty then
					-- Update tables with remapped tokens!
				end
			end
		end

	sort_fields_list_column (ut: MD_TABLE_COLUMN_UTILITIES [PE_TYPE_DEF_TABLE_ENTRY])
		do
				-- First we compute the unsorted Field list
				-- TODO: it seems we don't need the type id because we know
				-- that we need to traverse the MD_TABLE  identified by {PE_TABLES}.ttypedef
			if
				attached ut.unsorted_list_indexes as lst and then
				not lst.is_empty
			then
				partial_sort_field_list (lst, ut)

--Commented for now, to avoid infinite recursion
--					sort_fields_list_column (ut)
			else
				-- The Metadata Tokens for FieldList are sorted in the table ttypedef
				-- and the MD_REMAP_MANAGER has the tokens remaps to be applied to
				-- the corresponding tables.
			end
		end

	partial_sort_field_list (a_list: like {MD_TABLE_COLUMN_UTILITIES [PE_TYPE_DEF_TABLE_ENTRY]}.unsorted_list_indexes;
					ut: MD_TABLE_COLUMN_UTILITIES [PE_TYPE_DEF_TABLE_ENTRY]
				)
			-- We do partial sorting over the unsorted field list `a_list`
			-- Update the metadata table {PE_TABLES}.ttypedef
			-- Update the MD_REMAP_MANAGER
		local
			i, n: INTEGER
			l_item: TUPLE [row: NATURAL_32; index, next: NATURAL_32]
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
					print ("@Field@ Partial Sort: 0x" + token(l_item.row, {PE_TABLES}.ttypedef).to_hex_string)
					print (" index=" + token(l_item.index, {PE_TABLES}.tfield).to_hex_string)
					print (" before=" + token(l_item.next, {PE_TABLES}.tfield).to_hex_string)
					from
						print (" ->%N")
						idx := l_item.index
					until
						idx >= l_end_index
					loop
						print ("%T0x" + token (idx, {PE_TABLES}.tfield).to_hex_string + "%N")
						idx := idx + 1
					end
					print ("%N")
				end
				ut.move_tokens (l_item.index, l_end_index, l_item.next)

				i := i + 1
			end
		end

feature -- MethodList column sorting

	ensure_method_list_column_is_ordered
		local
			ut: MD_TABLE_COLUMN_UTILITIES [PE_TYPE_DEF_TABLE_ENTRY]
		do
			if
				attached typedef_table as tb and then
				attached methoddef_table as col_tb
			then
				create ut.make (tb, col_tb, agent (e: PE_TYPE_DEF_TABLE_ENTRY): PE_LIST do Result := e.methods end)
				sort_methods_list_column (ut)
				if not ut.remap.is_empty then
					-- Update tables with remapped tokens!
				end
			end
		end

	sort_methods_list_column (ut: MD_TABLE_COLUMN_UTILITIES [PE_TYPE_DEF_TABLE_ENTRY])
		local
		do
				-- First we compute the unsorted Method list
				-- TODO: it seems we don't need the type id because we know
				-- that we need to traverse the MD_TABLE  identified by {PE_TABLES}.ttypedef
			if
				attached ut.unsorted_list_indexes as lst and then
				not lst.is_empty
			then
				partial_sort_method_list (lst, ut)

--Commented for now, to avoid infinite recursion
--					sort_methods_list_column (ut, remap)
			else
				-- The Metadata Tokens for MethodList are sorted in the table ttypedef
				-- and the MD_REMAP_MANAGER has the tokens remaps to be applied to
				-- the corresponding tables.
			end
		end

	partial_sort_method_list (a_list: like {MD_TABLE_COLUMN_UTILITIES [PE_TYPE_DEF_TABLE_ENTRY]}.unsorted_list_indexes;
					ut: MD_TABLE_COLUMN_UTILITIES [PE_TYPE_DEF_TABLE_ENTRY]
				)
			-- We do partial sorting over the unsorted method list `a_list`
			-- Update the metadata table {PE_TABLES}.ttypedef
			-- Update the MD_REMAP_MANAGER
		local
			i, n: INTEGER
			l_item: TUPLE [row: NATURAL_32; index, next: NATURAL_32]
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
					print ("@Method@ Partial Sort: 0x" + token(l_item.row, {PE_TABLES}.ttypedef).to_hex_string)
					print (" index=" + token(l_item.index, {PE_TABLES}.tmethoddef).to_hex_string)
					print (" before=" + token(l_item.next, {PE_TABLES}.tmethoddef).to_hex_string)
					from
						print (" ->%N")
						idx := l_item.index
					until
						idx >= l_end_index
					loop
						print ("%T0x" + token (idx, {PE_TABLES}.tmethoddef).to_hex_string + "%N")
						idx := idx + 1
					end
					print ("%N")
				end
				ut.move_tokens (l_item.index, l_end_index, l_item.next)

--				update_remap_index (l_item)
				i := i + 1
			end
		end


end
