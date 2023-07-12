note
	description: "Summary description for {MD_TABLE_COLUMN_UTILITIES}."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TABLE_COLUMN_UTILITIES [E -> PE_TABLE_ENTRY_BASE]

inherit
	MD_TABLE_ACCESS

create
	make

feature {NONE} -- Initialization

	make (tb: MD_TABLE; col_tb: MD_TABLE; a_column_value_function: FUNCTION [E, PE_LIST])
		do
			table := tb
			table_for_column := col_tb
			value_for := a_column_value_function
			create remap.make (col_tb)
			prepare (a_column_value_function)
		end

feature -- Access

	remap: MD_REMAP_TOKEN_MANAGER

	table: MD_TABLE
			-- Table containing the colum to sort

	indexes: ARRAYED_LIST [TUPLE [list_index: PE_LIST; list_count: INTEGER]]

	sorted_indexes: ARRAYED_LIST [NATURAL_32]

	table_for_column: MD_TABLE
			-- Table associated with the column (Field, MethodDef, Param, ...)

	value_for: FUNCTION [E, PE_LIST]

feature -- Preparation

	prepare (a_value_for: FUNCTION [E, PE_LIST])
		local
			i,n, col_nb: NATURAL_32
			tb: like table
			p_list: PE_LIST
			idx, e_index: NATURAL_32
			l_indexes: like indexes
			l_sorted_indexes: like sorted_indexes
			l_sorter: QUICK_SORTER [NATURAL_32]
			c: CURSOR
		do
			tb := table
			col_nb := table_for_column.size
				-- Get indexes
			create l_indexes.make (tb.count)
			indexes := l_indexes

			create l_sorted_indexes.make (tb.count)
			sorted_indexes := l_sorted_indexes
			from
				i := 1
				n := tb.size
			until
				i > n
			loop
				if attached {E} tb [i] as e then
					p_list := value_for (e)
					if p_list.is_list_index_set then
						if not l_sorted_indexes.has (p_list.index) then
							l_sorted_indexes.force (p_list.index)
						end
						l_indexes.force ([p_list, 0])

					end
				else
					check expected: False end
--					l_indexes.force (Void)
				end
				i := i + 1
			end
			create l_sorter.make (create {COMPARABLE_COMPARATOR [NATURAL_32]})
			l_sorter.sort (l_sorted_indexes)

				-- When an index is repeated, set the N-1 first occurences as NULL index
			from
				l_indexes.start
			until
				l_indexes.off
			loop
				p_list := l_indexes.item_for_iteration.list_index
				if p_list /= Void then
					idx := p_list.index
					if idx > col_nb then
						-- Index is count + 1, i.e NULL index
						p_list.set_null_index
					else
						c := l_indexes.cursor
						from
							l_indexes.forth
						until
							l_indexes.after or p_list.is_null_index
						loop
							if
								attached l_indexes.item_for_iteration as lst and then
								lst.list_index.index = idx
							then
								p_list.set_null_index
							end
							l_indexes.forth
						end
						l_indexes.go_to (c)
					end
				end
				l_indexes.forth
			end

				-- Compute each list count.
				-- Get the index of the end of the list
				-- if none, the index is also NULL				
			from
				l_indexes.start
			until
				l_indexes.off
			loop
				p_list := l_indexes.item_for_iteration.list_index
				if p_list /= Void and then not p_list.is_null_index then
					idx := p_list.index
					if idx <= col_nb then
						e_index := end_index_of_list (p_list.index)
						if e_index < p_list.index then
							p_list.set_null_index
						else
							l_indexes.item_for_iteration.list_count := (e_index - p_list.index + 1).to_integer_32
						end
					end
				end
				l_indexes.forth
			end

			from
				l_indexes.start
			until
				l_indexes.off
			loop
				if l_indexes.item_for_iteration.list_index.is_null_index then
					l_indexes.remove
				else
					l_indexes.forth
				end
			end
		end

feature -- Apply token remapping

	apply_remapping
		local
			lst: ARRAYED_LIST [PE_TABLE_ENTRY_BASE]
			src: NATURAL_32
			tgt: INTEGER_32
			e: PE_TABLE_ENTRY_BASE
			col_tb: like table_for_column
		do
				-- Re-order `table_for_column` (For instance: Field, MethodDef, .. table)
			col_tb := table_for_column
			create lst.make_from_iterable (col_tb.items)
			across
				remap as r
			loop
				src := @r.key
				tgt := (r).to_integer_32
				e := col_tb [src]
				lst.put_i_th (e, tgt)
			end
			col_tb.items.wipe_out
			col_tb.replace_items (lst)
		end

	table_dump: STRING_8
		local
			i: NATURAL_32
			i_start, i_end: NATURAL_32
			col_name: STRING
			p_list: PE_LIST
		do
			create Result.make (table.count * 20)
			Result.append ({MD_TABLE_UTILITIES}.table_name (table.table_id) +" ("+table.count.out+")%N")

			col_name := {MD_TABLE_UTILITIES}.table_name (table_for_column.table_id)
			i := 0
			across
				table as e
			loop
				i := i + 1

				if attached {E} e as l_entry then
					Result.append ("[0x" + {MD_TABLE_UTILITIES}.table_token (i, table.table_id).to_hex_string + "]")
					Result.append (" "+ col_name +": ")
					p_list := value_for (l_entry)
					if p_list.is_null_index then
						Result.append ("NULL")
						if p_list.is_list_index_set then
							i_start := p_list.index
							Result.append ("<0x")
							Result.append (i_start.to_hex_string)
							Result.append (">")
						end
					else
						i_start := p_list.index
						if i_start <= table_for_column.size then
							i_end := end_index_of_list (i_start)
						else
							i_end := i_start
						end
						if i_end = 0 then
							Result.append ("NULL")
							if p_list.is_list_index_set then
								i_start := p_list.index
								Result.append ("<0x")
								Result.append (i_start.to_hex_string)
								Result.append (">")
							end
						else
							Result.append ("0x")
							Result.append (i_start.to_hex_string)
							if i_end > i_start then
								Result.append ("..0x")
								Result.append (i_end.to_hex_string)
								Result.append ("("+ (i_end - i_start + 1).out +")")
							end
						end
					end
					Result.append_character ('%N')
				else
					check expected_entries: False end
				end
			end
		end

	remapped_table_dump: STRING_8
		local
			i: NATURAL_32
			i_start, i_end: NATURAL_32
			col_name: STRING
			p_list: PE_LIST
		do
			create Result.make (table.count * 20)
			Result.append ({MD_TABLE_UTILITIES}.table_name (table.table_id) +" ("+table.count.out+")%N")

			col_name := {MD_TABLE_UTILITIES}.table_name (table_for_column.table_id)
			i := 0
			across
				table as e
			loop
				i := i + 1
				if attached {E} e as l_entry then
					Result.append ("[0x" + {MD_TABLE_UTILITIES}.table_token (i, table.table_id).to_hex_string + "]")
					Result.append (" "+ col_name +": ")

					p_list := value_for (l_entry)
					if p_list.is_null_index then
						Result.append ("NULL")
						if p_list.is_list_index_set then
							i_start := p_list.index
							Result.append ("<0x")
							Result.append (remap.token (i_start).to_hex_string)
							Result.append (">")
						end
					else
						i_start := p_list.index
						i_start := remap.token (i_start)
						if i_start <= table_for_column.size then
							i_end := end_index_of_list (i_start)
						else
							i_end := i_start
						end
						if i_end = 0 then
							Result.append ("0-NULL")
							if p_list.is_list_index_set then
								i_start := p_list.index
								Result.append ("<0x")
								Result.append (remap.token (i_start).to_hex_string)
								Result.append (">")
							end
						else
							Result.append ("0x")
							Result.append (i_start.to_hex_string)
							if i_end > i_start then
								Result.append ("..0x")
								Result.append (i_end.to_hex_string)
								Result.append ("("+ (i_end - i_start + 1).out +")")
							end
						end
					end
					Result.append_character ('%N')
				else
					check expected_entries: False end
				end
			end
		end

	remapped_indexes_dump: STRING_8
		local
			i_start, i_end: NATURAL_32
			col_name: STRING
			p_list: PE_LIST
		do
			create Result.make (table.count * 20)
			Result.append ({MD_TABLE_UTILITIES}.table_name (table.table_id) +" ("+table.count.out+")%N")

			col_name := {MD_TABLE_UTILITIES}.table_name (table_for_column.table_id)

			across
				indexes as d
			loop
				Result.append (col_name +": ")
				p_list := d.list_index
				check not p_list.is_null_index end
				i_start := p_list.index
				i_start := remap.token (i_start)
				i_end := i_start + d.list_count.to_natural_32 - 1 -- end_index_of_list (i_start)
				if d.list_count = 0 then
					Result.append ("0-NULL")
					if p_list.is_list_index_set then
						i_start := p_list.index
						Result.append ("<0x")
						Result.append (remap.token (i_start).to_hex_string)
						Result.append (">")
					end
				else
					Result.append ("0x")
					Result.append (i_start.to_hex_string)
					if i_end > i_start then
						Result.append ("..0x")
						Result.append (i_end.to_hex_string)
						Result.append ("("+ (i_end - i_start + 1).out +")")
					end
				end
				Result.append_character ('%N')
			end
		end

feature -- Sorting

	unsorted_list_indexes: ARRAYED_LIST [TUPLE [index: NATURAL_32; index_count: INTEGER; next: NATURAL_32]]
			-- Indexes of unsorted indexes from `tb` metadata table.
		local
			i: INTEGER
			idx: NATURAL_32
--			tb: MD_TABLE
--			l_col_value_fct: like value_for
			p_list: PE_LIST
			prev, ref: NATURAL_32
			prev_count, ref_count: INTEGER
			lst: like indexes
		do
--			tb := table
			create Result.make (3)
			prev := 0
			prev_count := 0
			lst := indexes
			i := lst.lower
			across
				lst as item
			loop
				p_list := item.list_index
				idx := p_list.index
				idx := remap.token (idx)
				if prev > idx then
					ref := prev
					ref_count := prev_count
--					from
--						j := i - 2
--					until
--						j < lst.lower or done
--					loop
--						prev := remap.token (lst [j].list_index.index)
--						prev_count := lst [j].list_count
--						if prev > idx and prev < ref then
--							ref := prev
--							ref_count := prev_count
--						else
--							done := True
--						end
--						j := j - 1
--					end
					Result.force ([ref, ref_count, idx])
				end
				prev := idx
				prev_count := item.list_count
				i := i + 1
			end
		end

	cache_for_end_indexes: detachable HASH_TABLE [NATURAL_32, NATURAL_32]

	end_index_of_list (a_index: NATURAL_32): NATURAL_32
			-- End index of List starting at `idx`
		require
			a_index >= 0 and a_index <= table_for_column.size
		local
			idx: NATURAL_32
			prev_index: NATURAL_32
			cache: like cache_for_end_indexes
			l_sorted_indexes: like sorted_indexes
		do
			cache := cache_for_end_indexes
			if cache = Void then
				create cache.make (3)
				cache_for_end_indexes := cache
			end
			if cache.has (a_index) then
				Result := cache [a_index]
			else
				idx := a_index -- Already remapped here !

				l_sorted_indexes := sorted_indexes
				prev_index := 0
				if idx = l_sorted_indexes.last then
					Result := idx
				else
					across
						l_sorted_indexes as k
					until
						Result > 0
					loop
						if k > idx then
							Result := k - 1
						end
					end
				end

				if Result = table_for_column.size + 1 then
					Result := 0
				end
				cache [a_index] := Result
			end
		ensure
			(Result = 0 or Result >= a_index) and Result <= table_for_column.size
		end

feature -- Table operation

	move_tokens (start_index, end_index: NATURAL_32; ref_index: NATURAL_32)
			-- Move indexes between `start_index` and `end_index` before `ref` index
		require
			start_index > ref_index
		local
			i, j, n: NATURAL_32
			offset: NATURAL_32
		do
			n := table_for_column.size

			from
				i := start_index
				j := 0
			until
				i + j > end_index
			loop
				remap.record (i + j, ref_index + j)
				j := j + 1
			end

			offset := end_index - start_index + 1
			from
				i := ref_index
				j := 0
			until
				i + j > start_index
			loop
				if start_index <= i + j then
					-- Already moved!
				else
					remap.record (i + j, ref_index + offset + j)
				end
				j := j + 1
			end

				-- Reset cache
			cache_for_end_indexes := Void

			debug ("il_emitter_table")
				print ("REMAP%N")
				print (remap.dump)
			end
		end

end
