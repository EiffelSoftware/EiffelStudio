note
	description: "Summary description for {MD_TABLE_COLUMN_UTILITIES}."
	author: ""
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
		end

feature -- Access

	remap: MD_REMAP_TOKEN_MANAGER

	table: MD_TABLE
			-- Table containing the colum to sort

	table_for_column: MD_TABLE
			-- Table associated with the column (Field, MethodDef, Param, ...)

	value_for: FUNCTION [E, PE_LIST]

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
						Result.append ("0x")
						Result.append (i_start.to_hex_string)
						if i_start <= table_for_column.size then
							i_end := end_index_of_list (i_start)
						else
							i_end := i_start
						end
						if i_end > i_start then
							Result.append ("..0x")
							Result.append (i_end.to_hex_string)
							Result.append ("("+ (i_end - i_start + 1).out +")")
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
						Result.append ("0x")
						i_start := remap.token (i_start)
						Result.append (i_start.to_hex_string)
						if i_start <= table_for_column.size then
							i_end := end_index_of_list (i_start)
						else
							i_end := i_start
						end
						if i_end > i_start then
							Result.append ("..0x")
							Result.append (i_end.to_hex_string)
							Result.append ("("+ (i_end - i_start + 1).out +")")
						end
					end
					Result.append_character ('%N')
				else
					check expected_entries: False end
				end
			end
		end

feature -- Sorting

	unsorted_list_indexes: ARRAYED_LIST [TUPLE [index, next: NATURAL_32]]
			-- Indexes of unsorted indexes from `tb` metadata table.
		local
			i, n: NATURAL_32
			i1, i2: NATURAL_32
			tb: MD_TABLE
			l_col_value_fct: like value_for
			p_list: PE_LIST
			prev_index: NATURAL_32
		do
			tb := table
			l_col_value_fct := value_for
			from
				n := tb.size
				create Result.make (tb.count)
				i := 2
				prev_index := 0
			until
				i > n
			loop
				if attached {E} tb [i] as r2 then
					i1 := prev_index
					p_list := l_col_value_fct (r2)
					if p_list.is_null_index then
						-- Ignore index
					else
						i2 := p_list.index
						i2 := remap.token (i2)
						if i1 > i2 then
							Result.force ([i1, i2])
						end
						prev_index := i2
					end
				else
					check expected_entries: False end
				end
				i := i + 1
			end
		end

	end_index_of_list (a_index: NATURAL_32): NATURAL_32
			-- End index of List starting at `idx`
		require
			a_index >= 0 and a_index <= table_for_column.size
		local
			idx: NATURAL_32
			i, n: NATURAL_32
			i1: NATURAL_32
			tb: MD_TABLE
			l_col_value_fct: like value_for
			p_list: PE_LIST
			prev_index: NATURAL_32
		do
			idx := a_index -- Already remapped here !

			tb := table
			l_col_value_fct := value_for

			from
				n := tb.size
				Result := table_for_column.size
				i := 2
			until
				i > n
			loop
				if attached {E} tb [i] as r then
					p_list := l_col_value_fct (r)
					if p_list.is_null_index then
					else
						i1 := remap.token (p_list.index)
						if i1 > idx and i1 - 1 < Result then
							Result := i1 - 1
						end
					end
				else
					check expected_entries: False end
				end
				i := i + 1
			end
		ensure
			Result >= a_index and Result <= table_for_column.size
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

			debug ("il_emitter_table")
				print ("REMAP%N")
				print (remap.dump)
			end
		end

end
