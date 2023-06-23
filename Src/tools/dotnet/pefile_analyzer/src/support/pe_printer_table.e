note
	description: "Summary description for {PE_PRINTER_TABLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_PRINTER_TABLE

create
	make

feature {NONE} -- Initialization

	make (a_cols, a_rows: INTEGER)
		do
			create rows.make (a_rows)
			create column_counts.make (1, a_cols)
		end

feature -- Access

	rows: ARRAYED_LIST [like row]

	row (i: INTEGER): detachable PE_PRINTER_TABLE_ROW
		do
			Result := rows.i_th (i)
		end

	add (r: PE_PRINTER_TABLE_ROW)
		local
			i, len, nb, sz: INTEGER
		do
			rows.force (r)
			i := 0
			across
				r.items as ic
			loop
				i := i + 1
				len := ic.item.count
				sz := sz + len
				if column_counts.valid_index (i) then
					nb := column_counts [i]
				else
					column_counts.grow (i)
					nb := 0
				end
				nb := nb.max (len)
				column_counts [i] := nb
			end
			columns_count := columns_count.max (i)
			row_size := row_size.max (sz)
		end

feature -- Columns

	column_counts: ARRAY [INTEGER]

	columns_count: INTEGER

	row_size: INTEGER

feature -- Conversion

	row_as_string (r: PE_PRINTER_TABLE_ROW): STRING_32
		local
			i: INTEGER
			l_is_first: BOOLEAN
			s, pad: STRING_32
			col_nb: INTEGER
		do
			create Result.make (row_size
					+ first_column_separator.count
					+ columns_count * first_column_separator.count
					+ last_column_separator.count
				)
			create pad.make_empty
			l_is_first := True
			i := 0
			across
				r.items as ic
			loop
				i := i + 1
				if l_is_first then
					l_is_first := False
					Result.append (first_column_separator)
				else
					Result.append (column_separator)
				end
				s := ic.item.to_string_32
				Result.append (s)
				col_nb := column_counts [i]
				if s.count < col_nb then
					pad.make_filled (' ', col_nb - s.count)
					Result.append (pad)
				end
			end
			if last_column_separator.is_empty then
				Result.right_adjust
			else
				Result.append (last_column_separator)
			end
		end

feature -- Constants

--	column_separator: STRING = " | "
	column_separator: STRING = " |"
	first_column_separator: STRING = " "
	last_column_separator: STRING = "" -- %T|"		

end
