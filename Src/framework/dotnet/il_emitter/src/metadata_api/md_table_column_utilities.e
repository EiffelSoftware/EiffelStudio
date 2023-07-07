note
	description: "Summary description for {MD_TABLE_COLUMN_UTILITIES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_TABLE_COLUMN_UTILITIES [G -> PE_TABLE_ENTRY_BASE]

create
	make

feature {NONE} -- Initialization

	make (tb: MD_TABLE; col_tb: MD_TABLE; a_column_value_function: FUNCTION [G, PE_LIST])
		do
			table := tb
			table_for_column := col_tb
			value_for := a_column_value_function
			create remap.make
		end

feature -- Access

	remap: MD_REMAP_TOKEN_MANAGER

	table: MD_TABLE
			-- Table containing the colum to sort

	table_for_column: MD_TABLE
			-- Table associated with the column (Field, MethodDef, Param, ...)

	value_for: FUNCTION [G, PE_LIST]

feature -- Sorting

	unsorted_list_indexes: ARRAYED_LIST [TUPLE [row: NATURAL_32; index, next: NATURAL_32]]
			-- Indexes of unsorted indexes from `tb` metadata table.
		local
			i, n: NATURAL_32
			i1, i2: NATURAL_32
			tb: MD_TABLE
			l_col_value_fct: like value_for
		do
			tb := table
			l_col_value_fct := value_for
			from
				n := tb.size
				create Result.make (tb.count)
				i := 2
			until
				i > n
			loop
				if
					attached {G} tb [i - 1] as r1 and then
					attached {G} tb [i] as r2
				then
					i1 := remap.token (l_col_value_fct (r1).index)
					i2 := remap.token (l_col_value_fct (r2).index)
					if i1 > i2 then
						Result.force ([i - 1, i1, i2])
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
		do
			idx := remap.token (a_index)

			tb := table
			l_col_value_fct := value_for

			from
				n := tb.size
				Result := table_for_column.size
				i := 2
			until
				i > n
			loop
				if attached {G} tb [i] as r then
					i1 := remap.token (l_col_value_fct (r).index)
					if i1 > idx and i1 - 1 < Result then
						Result := i1 - 1
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
				i + j > n --end_index
			loop
				remap.record (i + j, ref_index + j)
				j := j + 1
			end

			offset := end_index - start_index + 1
			from
				i := ref_index
				j := 0
			until
				j > offset
			loop
				remap.record (i + j, ref_index + offset + j)
				j := j + 1
			end

			debug ("il_emitter_table")
				print ("REMAP%N")
				print (remap.dump)
			end
		end

end
