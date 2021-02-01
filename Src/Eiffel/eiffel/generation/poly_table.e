note
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
			{ANY} count, valid_index
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

	make (routine_id: INTEGER)
			-- Create table with associated `routine_id'
		do
			rout_id := routine_id
			array_make (1, 1)
				-- By default all tables are considered using only deferred routines.
			is_deferred := True
			has_body := False
			pattern_id := -2
			position := 1
		end

	create_block (n: INTEGER)
			-- Create an array of `n' elements.
		require
			large_enough: n > 0
		do
			array_make (1, n)
		end

	extend_block (n: INTEGER)
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

	new_entry (f: FEATURE_I; t: CLASS_TYPE; d: BOOLEAN; c: INTEGER): ENTRY
			-- New entry corresponding to `f` for the target type `t` of the class of ID `c`
			-- that is deferred or not according to `d`.
		deferred
		end

	write
			-- Generate table using writer.
		deferred
		end

	write_for_type
			-- Generate table for type description.
		deferred
		end

	item: T
		do
			Result := array_item (position)
		end

	min_type_id: INTEGER
			-- Minimum effecitve type id of the table ?
		require
			not is_empty
		do
			Result := array_item (lower).type_id
		end

	max_type_id: INTEGER
			-- Maximum type id of the table ?
		require
			not is_empty
		do
			Result := array_item (max_position).type_id
		end

	is_deferred: BOOLEAN
			-- Is the table only containing deferred routines?

	has_body: BOOLEAN
			-- Is there an explicit body for any attribute in the table?

	pattern_id: INTEGER
			-- Is the table only containing routines with the same `pattern_id'?
			-- `-1' otherwise and `-2' when not yet computed.
			--| Currently it is only checked for ROUT_TABLE we could possibly do
			--| the same for ATTR_TABLE.

	has_one_signature: BOOLEAN
			-- Is the table only containing features with the same signature?
		do
			Result := pattern_id >= 0
		end

	goto (type_id: INTEGER)
			-- Move cursor to the entry of type ID `type_id'.
			-- Set `context_position` to the entry of `type_id`.
		require
			positive: type_id > 0
		local
			p: like position
		do
			p := binary_search (type_id)
			position := p
			context_position := p
		end

	has_one_type: BOOLEAN
			-- Is the type table not polymorphic ?
		require
			not_empty: not is_empty
		local
			i, nb: INTEGER
			first_type, this_type: TYPE_A
		do
			i := lower
			first_type := array_item (i).type
			if first_type /= Void then
				from
					first_type := first_type.deep_actual_type
					i := i + 1
					nb := max_position
					Result := True
				until
					i > nb
				loop
					this_type := array_item (i).type.deep_actual_type
					if not first_type.same_as (this_type) then
						Result := False
						i := nb	-- Jump out of loop.
					end
					i := i + 1
				end
			end
		end

	generate_type_table (writer: TABLE_GENERATOR)
			-- Generate the associated type table in final mode.
		local
			i, j, k, nb, index: INTEGER
			entry: T
			l_table_name: STRING
			l_entry_type_id, l_type_id: INTEGER
			l_start, l_end: INTEGER
			l_generate: BOOLEAN
			buffer: GENERATION_BUFFER
		do
			writer.update_size (max_type_id - min_type_id + 1)
			buffer := writer.current_buffer
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
					if entry.needs_extended_info then
						buffer.put_new_line
						buffer.put_string ("static EIF_TYPE_INDEX ")
						buffer.put_string (l_table_name)
						buffer.put_string ("_pgtype")
						buffer.put_integer (j)
						buffer.put_string ("[] = {")
						entry.generate_cid (buffer, True);
						buffer.put_hex_natural_16 ({SHARED_GEN_CONF_LEVEL}.terminator_type)
						buffer.put_string ("};");
						j := j + 1
					end
					index := index + 1
				end
				i := i + 1
			end

				-- Generate pointer table
			nb := max_type_id - min_type_id + 1
			buffer.put_new_line
			buffer.put_string ("EIF_TYPE_INDEX *")
			buffer.put_string (l_table_name)
			buffer.put_string ("_gen_type [")
			buffer.put_integer (nb)
			buffer.put_string ("];");

			buffer.put_new_line
			buffer.put_string ("EIF_TYPE_INDEX ")
			buffer.put_string (l_table_name)
			buffer.put_string (" [")
			buffer.put_integer (nb)
			buffer.put_string ("];")

			buffer.put_new_line
			buffer.put_string ("void ")
			buffer.put_string (l_table_name)
			buffer.put_string ("_init (void)")
			buffer.generate_block_open

				-- Initialize `egc_routines_types', `egc_routines_gen_types' and `egc_routines_offset'.
			buffer.put_new_line
			buffer.put_string ("egc_routines_types [")
			buffer.put_integer (rout_id)
			buffer.put_string ("] = ")
			buffer.put_string (l_table_name)
			buffer.put_character (';')

			buffer.put_new_line
			buffer.put_string ("egc_routines_gen_types [")
			buffer.put_integer (rout_id)
			buffer.put_string ("] = ")
			buffer.put_string (l_table_name)
			buffer.put_string ("_gen_type;")

			buffer.put_new_line
			buffer.put_string ("egc_routines_offset [")
			buffer.put_integer (rout_id)
			buffer.put_string ("] = ")
			buffer.put_type_id (min_type_id)
			buffer.put_string (";")

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
					if entry.needs_extended_info then
						buffer.put_new_line
						buffer.put_string (l_table_name)
						buffer.put_string ("_gen_type [")
						buffer.put_integer (k)
						buffer.put_string ("] = ")
						buffer.put_string (l_table_name)
						buffer.put_string ("_pgtype")
						buffer.put_integer (j)
						buffer.put_string (";");
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

			buffer.generate_block_close
			buffer.put_new_line_only
		end

feature -- Status report

	is_routine_table: BOOLEAN
			-- Is the current table a routine table ?
		do
			-- Do nothing
		end

	is_attribute_table: BOOLEAN
			-- Is the current table an attribute table ?
		do
			-- Do nothing
		end

	is_empty: BOOLEAN
			-- Is there an element?
		do
			Result := max_position = 0
		end

	is_initialization_required (t: TYPE_A; context_class_type: CLASS_TYPE): BOOLEAN
			-- Is initialization required for an attribute from `t` or a descendant?
		local
			type_id: INTEGER
			i: INTEGER
			nb: INTEGER
			entry: ENTRY
			old_position: like position
			system_i: SYSTEM_I
		do
			if has_body then
				type_id := t.type_id (context_class_type.type)
				old_position := position
				goto_used_for_offset (type_id)
				if not item.type.is_expanded then
						-- Expanded types are initialized elsewhere.
					if t.is_expanded then
							-- Check current type only
						Result := item.is_initialization_required
					else
							-- Check all conforming descendants
						system_i := system
						from
							i := position
							nb := max_position
						until
							Result or else i > nb
						loop
							entry := array_item (i)
							if entry.used_for_offset and then system_i.class_type_of_id (entry.type_id).is_binding_of (t, type_id, context_class_type.type) then
								Result := entry.is_initialization_required
							end
							i := i + 1
						end
					end
				end
				position := old_position
			end
		end

feature -- Iteration

	start
			-- Go to the first position.
		do
			position := lower
		end

	finish
			-- Go to the last position.
		do
			position := max_position
		end

	forth
		do
			position := position + 1
		end

	after: BOOLEAN
		do
			Result := position > max_position
		end

	go_to (pos: INTEGER)
		do
			position := pos
		end

	position: INTEGER
			-- Actual position in the POLY_TABLE

	max_position: INTEGER
			-- Position of the last item

	first: T
		do
			Result := array_item (lower)
		end

	goto_used_for_offset (type_id: INTEGER)
			-- Move cursor to the first entry of type_id `type_id`
			-- associated to a used effective class (non-deferred).
		require
			positive: type_id > 0
		local
			i, nb: INTEGER
			a: like area
		do
			from
				i := binary_search (type_id) - 1
				nb := max_position - 1
				a := area
			until
				i = nb or else a [i].used_for_offset
			loop
				i := i + 1
			end
			position := i + 1
		end

feature {NONE} -- Access

	context_position: INTEGER
			-- Position of the starting item found by `goto`, `goto_used`, `goto_implemented`.

feature -- Insertion

	extend (v: T)
			-- Add `v' to the end of `Current'.
		do
			max_position := max_position + 1
			if v.is_polymorphic then
				is_deferred := False
			end
			if v.is_initialization_required then
				has_body := True
			end
			put (v, max_position)
		ensure
			max_position_updated: max_position = old max_position + 1
			inserted: array_item (max_position) = v
			is_deferred_set: v.is_polymorphic implies not is_deferred
		end

	merge (other: like Current)
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

				-- Reset `is_deferred' flag if other contains no deferred entries.
			if not other.is_deferred then
				is_deferred := False
			end

			if other.has_body then
				has_body := True
			end

			if nb > upper then
				increase_size (nb - i)
			end

			tmp ?= tmp_poly_table
			if nb > tmp.upper then
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
						if t_item.type_id > o_item.type_id then
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

feature -- Sort

	sort
			-- Sort Current object in ascending order.
		do
			if max_position > 0 then
				quick_sort (lower, max_position)
			end
		end

feature -- Code generation

	generate_initialization (buf: GENERATION_BUFFER; header_buf: GENERATION_BUFFER)
			-- Generate calls required to initialize the table into `buf' and the associated declarations into `header_buf'.
		require
			buf_attached: buf /= Void
			header_buf_attached: header_buf /= Void
		deferred
		end

feature {NONE} -- Implementation of quick sort algorithm

	quick_sort (min, max: INTEGER)
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

	partition_quick_sort  (min, max: INTEGER): INTEGER
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

	binary_search (type_id: INTEGER): INTEGER
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
						j := m - 1
					else
						i := m
					end
				end
				Result := i
			end
		end

	increase_size (n: INTEGER)
			-- Increase the current array of `n' elements.
		local
			l_default: T
		do
			area := area.aliased_resized_area_with_default (l_default, count + n)
			upper := upper + n
		end

feature {POLY_TABLE} -- Special data

	tmp_poly_table: ARRAY [ENTRY]
			-- Contain a copy of Current during a merge
		deferred
		ensure
			tmp_poly_table_not_void: Result /= Void
		end

	bad_cast_but_valid (e: POINTER): T
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"(EIF_REFERENCE)"
		end

	increase_tmp_size (n: INTEGER)
			-- Increase the current array of `n' elements.
		do
			tmp_poly_table.make (1, tmp_poly_table.upper + (1 + n // Block_size) * Block_size)
		end

	Block_size: INTEGER = 50
			-- Size of a block of `tmp_poly_table'.

feature {NONE} -- Implementation

	generate_loop_type_id_initialization (buffer: GENERATION_BUFFER; a_table_name: STRING; a_type_id, a_lower, a_upper: INTEGER)
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
			buffer.put_new_line
			if a_lower = a_upper then
				buffer.put_string (a_table_name)
				buffer.put_character ('[')
				buffer.put_integer (a_lower)
				buffer.put_string ("] = ")
				buffer.put_integer (a_type_id)
				buffer.put_character (';')
			else
				buffer.put_string ("{long i; for (i = ")
				buffer.put_integer (a_lower)
				buffer.put_string ("; i < ")
				buffer.put_integer (a_upper + 1)
				buffer.put_string ("; i++) ")
				buffer.put_string (a_table_name)
				buffer.put_string ("[i] = ")
				buffer.put_integer (a_type_id)
				buffer.put_three_character (';', '}', ';')
			end
		end

invariant
	position >= lower

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
