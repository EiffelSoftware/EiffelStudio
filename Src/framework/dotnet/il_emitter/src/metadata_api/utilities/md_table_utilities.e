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

	make (e: MD_EMIT; fn: like associated_filename)
		do
			associated_filename := fn
			emitter := e
		end

feature -- Saving preparation	

	prepare_to_save
			-- Prepare data to be save
		do
			debug ("il_emitter_table_map")
				if attached associated_filename as fn then
					print ("%N")
					print ("Prepare ")
					print (fn)
					print ("%N")
				end
			end

			ensure_list_indexes_are_ordered

				-- Update all uninitialized PE_LIST (FieldList, MethodList, ParamList, ...)
			update_index_list_in_tables

				-- Sort tables...
			ensure_expected_tables_are_sorted
		end

feature -- Access

	associated_filename: detachable READABLE_STRING_GENERAL

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

feature -- Update missing indexes

	update_index_list_in_tables
		do
				-- Update all uninitialized PE_LIST (FieldList, MethodList, ParamList, ...)
			if attached typedef_table as l_typedef_tb then
				if attached field_table as l_field_tb then
					update_field_list_of_typedef_table (l_typedef_tb, l_field_tb)
				end
				if attached methoddef_table as l_methoddef_tb then
					update_method_list_of_typedef_table (l_typedef_tb, l_methoddef_tb)
				end
			end
			if
				attached methoddef_table as l_methoddef_tb and then
				attached param_table as l_param_tb
			then
				update_param_list_of_methoddef_table (l_methoddef_tb, l_param_tb)
			end
		end

	update_field_list_of_typedef_table (a_typedef_tb, a_field_tb: MD_TABLE)
		local
			max_field_idx: NATURAL_32
			field_idx: NATURAL_32
			l_missing_field_index_entries: ARRAYED_LIST [PE_TYPE_DEF_TABLE_ENTRY]
		do
			max_field_idx := a_field_tb.next_index
				-- TypeDef table
			across
				a_typedef_tb as e
			loop
				if attached {PE_TYPE_DEF_TABLE_ENTRY} e as l_type_def_entry then
						-- ParamList
					if l_type_def_entry.is_field_list_index_set then
						field_idx := l_type_def_entry.fields.index
						if l_missing_field_index_entries /= Void then
							across
								l_missing_field_index_entries as m
							loop
								m.fields.update_missing_index (l_type_def_entry.fields.index)
							end
							l_missing_field_index_entries.wipe_out
						end
					else
						if l_missing_field_index_entries = Void then
							create l_missing_field_index_entries.make (10)
						end
						l_missing_field_index_entries.force (l_type_def_entry)
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
		end

	update_method_list_of_typedef_table (a_typedef_tb, a_methoddef_tb: MD_TABLE)
		local
			max_method_idx: NATURAL_32
			method_idx: NATURAL_32
			l_missing_method_index_entries: ARRAYED_LIST [PE_TYPE_DEF_TABLE_ENTRY]
		do
			max_method_idx := a_methoddef_tb.next_index
				-- TypeDef table
			across
				a_typedef_tb as e
			loop
				if attached {PE_TYPE_DEF_TABLE_ENTRY} e as l_type_def_entry then
						-- ParamList
					if l_type_def_entry.is_method_list_index_set then
						method_idx := l_type_def_entry.methods.index
						if l_missing_method_index_entries /= Void then
							across
								l_missing_method_index_entries as m
							loop
								m.methods.update_missing_index (l_type_def_entry.methods.index)
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
			if l_missing_method_index_entries /= Void then
				across
					l_missing_method_index_entries as t
				loop
					t.methods.update_missing_index (max_method_idx)
				end
				l_missing_method_index_entries := Void
			end
		end

	update_param_list_of_methoddef_table (a_methoddef_tb, a_param_table: MD_TABLE)
		local
			max_param_idx: NATURAL_32
			param_idx: NATURAL_32
			l_missing_param_index_entries: ARRAYED_LIST [PE_METHOD_DEF_TABLE_ENTRY]
		do
			max_param_idx := a_param_table.next_index
				-- MethodDef table
			across
				a_methoddef_tb as e
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

feature -- Table sorting

	ensure_expected_tables_are_sorted
			-- Ensure tables that should be sorted are sorted.
			-- See ECMA 335 (6th editions) II.22 Metadata logical format: tables
		do
				--|	Certain tables are required to be sorted by a primary key, as follows:
				--| Class name				Primary key, then secondary key
				--|-----------------------+---------------------------------
				--|	ClassLayout 			Parent
				--|	Constant 				Parent
				--|	CustomAttribute 		Parent
				--|	DeclSecurity 			Parent
				--|	FieldLayout 			Field
				--|	FieldMarshal 			Parent
				--|	FieldRVA 				Field
				--|	GenericParam 			Owner, then Number
				--|	GenericParamConstraint 	Owner
				--|	ImplMap 				MemberForwarded
				--|	InterfaceImpl 			Class, then Interface
				--|	MethodImpl 				Class
				--|	MethodSemantics 		Association
				--|	NestedClass 			NestedClass
				--|
				--|	Finally, the TypeDef table has a special ordering constraint: the definition of an enclosing class shall
				--|	precede the definition of all classes it encloses.
				--|	Metadata items (records in the metadata tables) are addressed by metadata tokens. Uncoded metadata
				--|	tokens are 4-byte unsigned integers, which contain the metadata table index in the most significant byte
				--|	and a 1-based record index in the three least-significant bytes. Metadata tables and their respective
				--|	indexes are described in §II.22.2 and later subclauses.
				--|	Coded metadata tokens also contain table and record indexes, but in a different format. For details on
				--|	the encoding see II.24.2.6			

				-- Below the commented lines are related to the tables the compiler does not use for now [2023-07-13]
--			ensure_table_is_sorted ({PE_TABLES}.tclasslayout)
--			ensure_table_is_sorted ({PE_TABLES}.tconstant)
			ensure_table_is_sorted ({PE_TABLES}.tcustomattribute)
--			ensure_table_is_sorted ({PE_TABLES}.tdeclsecurity)
--			ensure_table_is_sorted ({PE_TABLES}.tfieldlayout)
--			ensure_table_is_sorted ({PE_TABLES}.tfieldmarshal)
--			ensure_table_is_sorted ({PE_TABLES}.tfieldrva)
--			ensure_table_is_sorted ({PE_TABLES}.tgenericparam)
--			ensure_table_is_sorted ({PE_TABLES}.tgenericparamconstraint)
--			ensure_table_is_sorted ({PE_TABLES}.timplmap)
			ensure_table_is_sorted ({PE_TABLES}.tinterfaceimpl)
			ensure_table_is_sorted ({PE_TABLES}.tmethodimpl)
			ensure_table_is_sorted ({PE_TABLES}.tmethodsemantics)
--			ensure_table_is_sorted ({PE_TABLES}.tnestedclass)
		end

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

feature -- Operation: List indexes sorting using additional FieldPointer and MethodPointer tables

	ensure_field_list_column_is_ordered_using_field_pointer_table
			-- FieldList column sorting in TypeDef
		local
			ut: MD_TABLE_COLUMN_UTILITIES [PE_TYPE_DEF_TABLE_ENTRY]
			vis: MD_FIELD_TOKEN_REMAPPER
			idx: NATURAL_32
		do
			if
				attached field_table as l_field_tb and then
				attached md_table ({PE_TABLES}.tFieldPtr) as ptr_tb
			then
				across
					l_field_tb as e
				loop
					idx := idx + 1
					if attached {PE_FIELD_TABLE_ENTRY} e as l_field then
						ptr_tb.force (create {PE_FIELD_POINTER_TABLE_ENTRY}.make_with_data (idx))
					end
				end
				if
					attached typedef_table as tb
				then
					create ut.make (tb, ptr_tb, agent (e: PE_TYPE_DEF_TABLE_ENTRY): PE_LIST do Result := e.fields end)
					sort_list_column (ut)
					if not ut.remap.is_empty then
						-- Update tables with remapped tokens!
						debug ("il_emitter_table_map")
							print (ut.remap.dump)
						end
						ut.apply_remapping

							-- Updated tokens in the related tables (For instance: TypeDef table, ...)
						create vis.make_using_pointer_table (ut.remap)
						vis.visit_emitter (emitter)

						ut.remap.reset
					end
				end
			end
		end

	ensure_method_list_column_is_ordered_using_method_pointer_table
			-- MethodList column sorting in TypeDef
		local
			ut: MD_TABLE_COLUMN_UTILITIES [PE_TYPE_DEF_TABLE_ENTRY]
			vis: MD_METHOD_DEF_TOKEN_REMAPPER
			idx: NATURAL_32
		do
			if
				attached methoddef_table as l_methoddef_tb and then
				attached md_table ({PE_TABLES}.tMethodPtr) as ptr_tb
			then
				across
					l_methoddef_tb as e
				loop
					idx := idx + 1
					if attached {PE_METHOD_DEF_TABLE_ENTRY} e as l_field then
						ptr_tb.force (create {PE_METHOD_POINTER_TABLE_ENTRY}.make_with_data (idx))
					end
				end
				if
					attached typedef_table as tb
				then
					create ut.make (tb, ptr_tb, agent (e: PE_TYPE_DEF_TABLE_ENTRY): PE_LIST do Result := e.methods end)
					sort_list_column (ut)
					if not ut.remap.is_empty then
						-- Update tables with remapped tokens!
						debug ("il_emitter_table_map")
							print (ut.remap.dump)
						end
						ut.apply_remapping

							-- Updated tokens in the related tables (For instance: TypeDef table, ...)
						create vis.make_using_pointer_table (ut.remap)
						vis.visit_emitter (emitter)

						ut.remap.reset
					end
				end
			end
		end

feature -- Operation: List indexes sorting

	is_using_additional_pointer_tables: BOOLEAN = True
			-- Use FieldPointer and MethodPointer tables.

	ensure_list_indexes_are_ordered
		do
			if is_using_additional_pointer_tables then
						-- Ensure FieldList and MethodList columns are ordered in TypeDef
						-- FIXME: optimization = check first if the table are not order, and only in this case, use related Pointer table [2023-07-17]
				ensure_field_list_column_is_ordered_using_field_pointer_table
				ensure_method_list_column_is_ordered_using_method_pointer_table
					-- Ensure ParamList column is ordered in MethodDef
				ensure_param_list_column_is_ordered
			else
						-- Ensure FieldList and MethodList columns are ordered in TypeDef
				ensure_field_list_column_is_ordered
				ensure_method_list_column_is_ordered
					-- Ensure ParamList column is ordered in MethodDef
				ensure_param_list_column_is_ordered
			end
		end

	ensure_field_list_column_is_ordered
			-- FieldList column sorting in TypeDef
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
					debug ("il_emitter_table_map")
						print (ut.remap.dump)
					end
					ut.apply_remapping
						-- Updated tokens in the related tables (For instance: TypeDef table, ...)
					create vis.make (ut.remap)
					vis.visit_emitter (emitter)

					ut.remap.reset
				end
			end
		end

	ensure_method_list_column_is_ordered
			-- MethodList column sorting in TypeDef
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
					debug ("il_emitter_table_map")
						print (ut.remap.dump)
					end

					ut.apply_remapping
						-- Updated tokens in the related tables (For instance: TypeDef table, ...)
					create vis.make (ut.remap)
					vis.visit_emitter (emitter)
				end
			end
		end

	ensure_param_list_column_is_ordered
			-- ParamList column sorting in MethodDef
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
					debug ("il_emitter_table_map")
						print (ut.remap.dump)
					end

					ut.apply_remapping
						-- Updated tokens in the related tables (For instance: TypeDef table, ...)
					create vis.make (ut.remap)
					vis.visit_emitter (emitter)
				end
			end
		end

feature -- Column sorting

	table_token (idx: NATURAL_32; tb: NATURAL_32): NATURAL_32
		do
			Result := (tb |<< 24) | idx
		ensure
			class
		end

	table_name (id: NATURAL_32): STRING_8
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
			l_item: TUPLE [index: NATURAL_32; index_count: INTEGER; next: NATURAL_32; next_count: INTEGER]
			idx, l_index_end, l_next_end: NATURAL_32
			done: BOOLEAN
		do
			from
				i := 1
				n := a_list.count
			until
				i > n or done
			loop
				l_item := a_list [i]
				l_index_end := l_item.index + l_item.index_count.to_natural_32 - 1
				l_next_end := l_item.next + l_item.next_count.to_natural_32 - 1
				debug ("il_emitter_table")
					print ("@"+table_name (ut.table_for_column.table_id)+"@ Partial Sort: ")
					print (" index=" + table_token (l_item.index, ut.table_for_column.table_id).to_hex_string)
					print (" +" + l_item.index_count.out)
					print (" before=" + table_token (l_item.next, ut.table_for_column.table_id).to_hex_string)
					print (" +" + l_item.next_count.out)
					if l_index_end = 0 then
						print (" -> NULL (0) %N")
					else
						from
							print (" -> (" + l_item.index_count.out + ") %N")
							idx := l_item.index
						until
							idx > l_index_end
						loop
							print ("%T0x" + table_token (idx, ut.table_for_column.table_id).to_hex_string + "%N")
							idx := idx + 1
						end
					end
					print ("%N")
				end
				if l_index_end > 0 then
					ut.move_tokens (l_item.index, l_index_end, l_item.next, l_next_end)
				end
				i := i + 1
				done := True -- One at the time for now
			end
			ut.remap.commit
		end

	sort_list_column (ut: MD_TABLE_COLUMN_UTILITIES [PE_TABLE_ENTRY_BASE])
		do
			if
				attached ut.unsorted_list_indexes as lst and then
				not lst.is_empty
			then
				debug("il_emitter_table")
					print ("UNSORTED {"+ table_name (ut.table_for_column.table_id) +"} list indexes in table {"+ table_name (ut.table.table_id) +"}%N")
					across
						lst as ic
					loop
						print (" - 0x")
						print (ic.index.to_hex_string)
						print (" +" + ic.index_count.out)
						print (" > 0x")
						print (ic.next.to_hex_string)
						print (" +" + ic.next_count.out)
						print ("%N")
					end
				end

				partial_sort_list (lst, ut)

					-- Recursive sorting..
				sort_list_column (ut)
			else
				-- The Metadata Tokens for Token List are sorted in the container table
				-- and the token remap manager has the tokens remaps to be applied to
				-- the corresponding tables.
			end
		end

end
