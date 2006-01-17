indexing
	description: "[
		Abstract representation of a routine-or-attribute offset table for
		the final Eiffel executable.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class POLY_TABLE [T -> ENTRY]

inherit
	ARRAY [T]
		rename
			make as array_make,
			extend as array_extend,
			item as array_item,
			empty as array_empty,
			is_empty as array_is_empty,
			entry as array_entry
		export
			{ANY} count
			{POLY_TABLE} all
		end

	IDABLE
		rename
			id as rout_id,
			set_id as set_rout_id
		export
			{NONE} all
			{ANY} rout_id, set_rout_id
		undefine
			copy, is_equal
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_ARRAY_BYTE
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_SERVER
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	SHARED_GENERATION
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		undefine
			copy, is_equal
		end

feature -- Initialization

	make (routine_id: INTEGER) is
			-- Create table with associated `routine_id'
		do
			rout_id := routine_id
			array_make (1, 1)
		end

	create_block (n: INTEGER) is
			-- Create an array of `n' elements.
		require
			large_enough: n > 0
		do
			array_make (1, n)
		end

	extend_block (n: INTEGER) is
			-- Extend current to `n' elements.
		require
			large_enough: n > 0
			not_empty: not is_empty
		do
			if (max_position > upper) or else (upper - max_position < n) then
				increase_size (n.max (upper // 2))
			end
		end

feature

	is_polymorphic (type_id: INTEGER): BOOLEAN is
			-- Is the table polymorphic from entry indexed by `type_id' to
			-- the maximum entry id ?
		require
			positive: type_id > 0
		deferred
		end

	writer: TABLE_GENERATOR is
			-- Generator of tables which spilt the generation in several
			-- files.
		deferred
		end

	write is
			-- Generation of the table through the writer
		require
			writer_exists: writer /= Void
		local
			l_poly: POLY_TABLE [ENTRY]
		do
			l_poly ?= Current
			check l_poly_not_void: l_poly /= Void end
			writer.generate (l_poly)
			if has_type_table and then not has_one_type then
				writer.generate_type_table (l_poly)
			end
		end

	generate (buffer: GENERATION_BUFFER) is
			-- Generation of the table for final Eiffel executable.
		deferred
		end

	item: T is
		do
			Result := array_item (position)
		end

	min_type_id: INTEGER is
			-- Minimum effecitve type id of the table ?
		require
			not is_empty
		do
			Result := array_item (lower).type_id
		end

	max_type_id: INTEGER is
			-- Maximum type id of the table ?
		require
			not is_empty
		do
			Result := array_item (max_position).type_id
		end

	min_used: INTEGER is
			-- Minimum used type id ?
		require
			not_empty: count > 0
			is_used: used
		local
			entry: T
			i: INTEGER
		do
			from
				i := lower
			until
				Result > 0
			loop
				entry := array_item (i)
				if entry.used then
					Result := entry.type_id
				end
				i := i + 1
			end
		end

	max_used: INTEGER is
			-- Minimum used type id ?
		require
			not_empty: count > 0
			is_used: used
		local
			entry: T
			i: INTEGER
		do
			from
				i := max_position
			until
				Result > 0
			loop
				entry := array_item (i)
				if entry.used then
					Result := entry.type_id
				end
				i := i - 1
			end
		end

	used: BOOLEAN is
			-- Is the table effectively used ?
		local
			i, nb: INTEGER
		do
			from
				i := lower
				nb := max_position
			until
				Result or else i > nb
			loop
				Result := array_item(i).used
				i := i + 1
			end;
		end

	final_table_size: INTEGER is
			-- Size of the C table
		require
			not is_empty
			is_used: used
		do
			Result := max_used - min_used + 1
		end

	has_type_id (type_id: INTEGER): BOOLEAN is
			-- Is a non-deferred entry present at index greater
			-- than `type_id' ?
		require
			positive: type_id > 0
		do
			Result := type_id = array_item (binary_search (type_id)).type_id
		end

	goto (type_id: INTEGER) is
			-- Move cursor to the first entry of type_id `type_id'
			-- associated to an effective class (non-deferred).
		require
			positive: type_id > 0
		do
			position := binary_search (type_id)
		end

	goto_used (type_id: INTEGER) is
			-- Move cursor to the first entry of type_id `type_id'
			-- associated to an used effective class (non-deferred).
		require
			positive: type_id > 0
		local
			i, nb: INTEGER
		do
			from
				i := binary_search (type_id)
				nb := max_position
			until
				array_item(i).used or else i = nb
			loop
				i := i + 1
			end
			position := i
		end

	has_type_table: BOOLEAN is
			-- Is a type table needed for the current table ?
		do
			Result := System.type_set.has (rout_id)
		end

	has_one_type: BOOLEAN is
			-- Is the type table not polymorphic ?
		require
			not_empty: not is_empty
		local
			i, nb: INTEGER
			first_type, this_type: TYPE_I
		do
			from
				i := lower
				first_type := array_item (i).type
				i := i + 1
				nb := max_position
				Result := True
			until
				i > nb or else not Result
			loop
				this_type := array_item (i).type
				Result := (first_type = Void and then this_type = Void)
						or else ((first_type /= Void and then this_type /= Void)
						and then first_type.is_identical (this_type)
						and then this_type.is_identical (first_type))
				i := i + 1
			end
			if Result then
				Result := first_type.is_explicit
			end
		end

	generate_type_table (buffer: GENERATION_BUFFER) is
			-- Generate the associated type table in final mode.
		local
			i, j, k, nb, index: INTEGER
			entry: T
			l_table_name: STRING
			l_entry_type_id, l_type_id: INTEGER
			l_start, l_end: INTEGER
			l_generate: BOOLEAN
		do
			l_table_name := Encoder.type_table_name (rout_id)

				-- First generate type arrays for generic types.
			from
				i := min_type_id;
				nb := max_type_id;
				index := lower
				j := 0
			until
				i > nb
			loop
				entry := array_item (index)
				if i = entry.type_id then
					if entry.is_generic then
						buffer.put_string ("static int16 ")
						buffer.put_string (l_table_name)
						buffer.put_string ("_pgtype")
						buffer.put_integer (j)
						buffer.put_string ("[] = {0,")
						entry.generate_cid (buffer, True);
						buffer.put_string ("-1};");
						buffer.put_new_line
						j := j + 1
					end
					index := index + 1
				end
				i := i + 1
			end

				-- Generate pointer table
			nb := max_type_id - min_type_id + 1
			buffer.put_string ("int16 *")
			buffer.put_string (l_table_name)
			buffer.put_string ("_gen_type [")
			buffer.put_integer (nb)
			buffer.put_string ("];");
			buffer.put_new_line

			buffer.put_string ("int16 ")
			buffer.put_string (l_table_name)
			buffer.put_string (" [")
			buffer.put_integer (nb)
			buffer.put_string ("];")
			buffer.put_new_line

			buffer.put_string ("void ")
			buffer.put_string (l_table_name)
			buffer.put_string ("_init (void) {")
			buffer.put_new_line
			buffer.indent

				-- Compact generation for `XXX_gen_type' table. No need to try to be
				-- smart here, since occurrences of the type array occurs only once in
				-- this table.
			from
				i := min_type_id;
				nb := max_type_id;
				index := lower
				j := 0
			until
				i > nb
			loop
				entry := array_item (index)
				if i = entry.type_id then
					if entry.is_generic then
						buffer.put_string (l_table_name)
						buffer.put_string ("_gen_type [")
						buffer.put_integer (k)
						buffer.put_string ("] = ")
						buffer.put_string (l_table_name)
						buffer.put_string ("_pgtype")
						buffer.put_integer (j)
						buffer.put_string (";");
						buffer.put_new_line
						j := j + 1
					end
					index := index + 1
				end
				i := i + 1
				k := k + 1
			end

				-- Generate the old stuff in a compact manner
				-- We generate a compact table initialization, that is to say if two or more
				-- consecutives rows are identical we will generate a loop to fill the rows
			from
				i := min_type_id
				nb := max_type_id
				index := lower
				l_entry_type_id := -1
				j := 0
			until
				i > nb
			loop
				entry := array_item (index)
				if i = entry.type_id then
					if l_entry_type_id = -1 then
						l_entry_type_id := entry.feature_type_id - 1
						l_start := j
						l_end := j
					else
						l_type_id := entry.feature_type_id - 1
						if l_entry_type_id = l_type_id then
							l_end := j
						else
							l_generate := True
						end
					end
					index := index + 1
				else
					l_generate := True
					l_type_id := -1
				end
				if l_generate then
					l_generate := False
					if l_entry_type_id /= -1 then
						generate_loop_type_id_initialization (buffer, l_table_name,
							l_entry_type_id, l_start, l_end)
						l_entry_type_id := l_type_id
						l_start := j
						l_end := j
					end
				end
				i := i + 1
				j := j + 1
			end
			if l_entry_type_id /= -1 then
				generate_loop_type_id_initialization (buffer, l_table_name, l_entry_type_id,
					l_start, l_end)
			end

			buffer.exdent
			buffer.put_new_line
			buffer.put_string ("};%N%N")
		end

	is_routine_table: BOOLEAN is
			-- Is the current table a routine table ?
		do
			-- Do nothing
		end

feature -- Iteration

	start is
		do
			position := lower
		end

	forth is
		do
			position := position + 1
		end

	after: BOOLEAN is
		do
			Result := (position > max_position)
		end

	go_to (pos: INTEGER) is
		do
			position := pos
		end

	position: INTEGER
			-- Actual position in the POLY_TABLE

	max_position: INTEGER
			-- Position of the last item

	first: T is
		do
			Result := array_item (lower)
		end

feature -- Insertion

	extend (v: T) is
		do
			max_position := max_position + 1
			put (v, max_position)
		end

	merge (other: like Current) is
			-- Put `other' into Current
		local
			tmp: ARRAY [T]
			i, j, k, nb: INTEGER
			t_max, o_max: INTEGER
			t_item: ENTRY
			o_item: T
		do
			i := max_position
			t_max := i
			o_max := other.max_position
			nb := i + o_max
			max_position := nb

			if (nb > upper) then
				increase_size (nb - i)
			end

			tmp ?= tmp_poly_table
			if (nb > tmp.upper) then
				increase_tmp_size (nb - tmp.upper)
			end
			tmp.subcopy (Current, 1, i, 1)

			from
				k := 1
				i := 1
				j := 1
			until
				k > nb
			loop
				if i <= t_max then
					if j <= o_max then
						t_item := tmp.item (i)
						o_item := other.array_item (j)
						if (t_item.type_id > o_item.type_id) then
							put (o_item, k)
							j := j + 1
						else
							put (bad_cast_but_valid ($t_item), k)
							i := i + 1
						end
						k := k + 1
					else
						from
						until
							i > t_max
						loop
							t_item := tmp.item (i)
							put (bad_cast_but_valid ($t_item), k)
							i := i + 1
							k := k + 1
						end
					end
				else
					from
					until
						j > o_max
					loop
						put (other.array_item (j), k)
						j := j + 1
						k := k + 1
					end
				end
			end
		end

feature -- Status

	is_empty: BOOLEAN is
			-- Is there an element?
		do
			Result := max_position = 0
		end

feature -- Sort

	sort is
			-- Sort Current object in ascending order.
		do
			if max_position > 0 then
				quick_sort (lower, max_position)
			end
		end

feature {NONE} -- Implementation of quick sort algorithm

	quick_sort (min, max: INTEGER) is
			-- Apply `quick sort' algorithm
			-- If `max' < `min' then it stops
		local
			pivo_index: INTEGER
		do
			if min < max then
				pivo_index := partition_quick_sort (min, max)
				quick_sort (min, pivo_index - 1)
				quick_sort (pivo_index + 1, max)
			end
		end

	partition_quick_sort  (min, max: INTEGER): INTEGER is
			-- Apply `quick_sort' algorithm to position [`min'..`max']
		require
			correct_bounds: min <= max
		local
			up, down : INTEGER
			x: INTEGER
			temp: T
		do
				-- Define the pivot value as the first element of table
			x := array_item (min).type_id

				-- Initialize UP to first
			up := min

				-- Initialize DOWN to last
			down := max

			from
			until
				up >= down    -- Repeat until up meets or passes down
			loop
					-- Increment up until up selects the first element
					-- greater than the pivot value
				from
				until
					up >= max or else array_item (up).type_id > x
				loop
					up := up + 1
				end

					-- Decrement down until it selects the first element
					-- lesser than or equal to the pivot
				from
				until
					array_item (down).type_id <= x
				loop
					down := down - 1
				end

				if up < down then
						-- If up < down  exchange their values until up
						-- meets or passes down
					temp := array_item (up)
					put (array_item (down), up)
					put (temp, down)
				end
			end

			temp := array_item (down)
			put (array_item (min), down)
			put (temp, min)
			Result := down
		end

feature {NONE} -- Implementation

	binary_search (type_id: INTEGER): INTEGER is
			-- Return position where `type_id' is in POLY_TABLE.
		local
			i, j, m: INTEGER
		do
			j := max_position
			if j = 1 then
				Result := 1
			else
				from
					i := lower
				until
					i = j
				loop
					m := (i + j) // 2 + 1
					if array_item (m).type_id > type_id then
						j := j - 1
					else
						i := m
					end
				end
				Result := i
			end
		end

	increase_size (n: INTEGER) is
			-- Increase the current array of `n' elements.
		do
			area := area.aliased_resized_area (count + n)
			upper := upper + n
		end

feature {POLY_TABLE} -- Special data

	tmp_poly_table: ARRAY [ENTRY] is
			-- Contain a copy of Current during a merge
		deferred
		ensure
			tmp_poly_table_not_void: Result /= Void
		end

	bad_cast_but_valid (e: POINTER): T is
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"(EIF_REFERENCE)"
		end

	increase_tmp_size (n: INTEGER) is
			-- Increase the current array of `n' elements.
		do
			tmp_poly_table.make (1, tmp_poly_table.upper + (1 + n // Block_size) * Block_size)
		end

	Block_size: INTEGER is 50
			-- Size of a block of `tmp_poly_table'.

feature {NONE} -- Implementation

	generate_loop_type_id_initialization (buffer: GENERATION_BUFFER; a_table_name: STRING; a_type_id, a_lower, a_upper: INTEGER) is
			-- Generate code to initialize current array with `a_routine_name'. Generate a
			-- loop if `a_lower' is different from `a_upper'.
		require
			buffer_not_void: buffer /= Void
			a_table_name_not_void: a_table_name /= Void
			a_type_id_non_negative: a_type_id >= 0
			a_lower_non_negative: a_lower >= 0
			a_upper_non_negative: a_upper >= 0
			a_upper_greater_or_equal_than_a_lower: a_upper >= a_lower
		do
			if a_lower = a_upper then
				buffer.put_string (a_table_name)
				buffer.put_character ('[')
				buffer.put_integer (a_lower)
				buffer.put_string ("] = ")
				buffer.put_integer (a_type_id)
				buffer.put_character (';')
				buffer.put_new_line
			else
				buffer.put_string ("{long i; for (i = ")
				buffer.put_integer (a_lower)
				buffer.put_string ("; i < ")
				buffer.put_integer (a_upper + 1)
				buffer.put_string ("; i++) ")
				buffer.put_string (a_table_name)
				buffer.put_string ("[i] = ")
				buffer.put_integer (a_type_id)
				buffer.put_character (';')
				buffer.put_character ('}')
				buffer.put_character (';')
				buffer.put_new_line
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
