-- Abstract representation of a routine-or-attribute offset table for
--the final Eiffel executable.

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
		end

	IDABLE
		rename
			id as rout_id,
			set_id as set_rout_id
		undefine
			copy, is_equal
		end

	SHARED_WORKBENCH
		undefine
			copy, is_equal
		end

	SHARED_CODE_FILES
		undefine
			copy, is_equal
		end

	SHARED_ARRAY_BYTE
		undefine
			copy, is_equal
		end

	SHARED_SERVER
		undefine
			copy, is_equal
		end

	SH_DEBUG
		undefine
			copy, is_equal
		end

	SHARED_GENERATION
		undefine
			copy, is_equal
		end

	COMPILER_EXPORTER
		undefine
			copy, is_equal
		end

feature -- Initialization

	make (routine_id: INTEGER) is
			-- Create table with associated `routine_ioid'
		do
			rout_id := routine_id
		end

	create_block (n: INTEGER) is
			-- Create an array of `n' elements.
		require
			large_enough: n > 0
		do
			array_make (1,n)
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
		do
			writer.generate (Current)
			if has_type_table and then not has_one_type then
				writer.generate_type_table (Current)
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
			i, nb: INTEGER
			local_copy: POLY_TABLE [T]
		do
			from
				local_copy := Current
				i := lower
				nb := max_position
			until
				Result > 0
			loop
				entry := local_copy.array_item (i)
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
			i, nb: INTEGER
			local_copy: POLY_TABLE [T]
		do
			from
				local_copy := Current
				i := max_position
				nb := lower
			until
				Result > 0
			loop
				entry := local_copy.array_item (i)
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
			local_copy: POLY_TABLE [T]
		do
			from
				local_copy := Current
				i := lower
				nb := max_position
			until
				Result or else i > nb
			loop
				Result := local_copy.array_item(i).used
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
			local_copy: POLY_TABLE [T]
		do
			from
				local_copy := Current
				i := binary_search (type_id)
				nb := max_position
			until
				local_copy.array_item(i).used or else i = nb
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
			local_copy: POLY_TABLE [T]
			first_type, this_type: TYPE_I
		do
			from
				local_copy := Current
				i := lower
				first_type := local_copy.array_item (i).type
				i := i + 1
				nb := max_position
				Result := true
			until
				i > nb or else not Result
			loop
				this_type := local_copy.array_item (i).type
				Result := (first_type = Void and then this_type = Void)
						or else ((first_type /= Void and then this_type /= Void)
						and then first_type.is_identical (this_type)
						and then this_type.is_identical (first_type))
				i := i + 1
			end
		end

	generate_type_table (buffer: GENERATION_BUFFER) is
			-- Generate the associated type table in final mode.
		local
			i, j, nb, index: INTEGER
			entry: T
			local_copy: POLY_TABLE [T]
			c_name: STRING
		do
			local_copy := Current

				-- First generate type arrays for generic types.
			c_name := Encoder.type_table_name (rout_id)

			from
				i := min_type_id;
				nb := max_type_id;
				index := lower
				j := 0;
			until
				i > nb
			loop
				entry := local_copy.array_item (index);
				if i = entry.type_id then
					if entry.is_generic then
						buffer.putstring ("static int16 ");
						buffer.putstring (c_name);
						buffer.putstring ("_pgtype");
						buffer.putint (j);
						buffer.putstring (" [] = {0,");
						entry.generate_cid (buffer, True);
						buffer.putstring ("-1};");
						buffer.new_line;
						j := j + 1
					end;
					index := index + 1
				end;
				i := i + 1;
			end;

				-- Now generate pointer table
			buffer.putstring ("int16 *");
			buffer.putstring (c_name);
			buffer.putstring ("_gen_type [] = {%N");

			from
				i := min_type_id;
				nb := max_type_id;
				index := lower
				j := 0 
			until
				i > nb
			loop
				entry := local_copy.array_item (index)
				if i = entry.type_id then
					if entry.is_generic then
						buffer.putstring (c_name);
						buffer.putstring ("_pgtype");
						buffer.putint (j);
						buffer.putchar (',');
						j := j + 1;
					else
						buffer.putstring ("0,");
					end
					index := index + 1
				else
					buffer.putstring ("0,");
				end;
				buffer.new_line;

				i := i + 1;
			end;
			buffer.putstring ("0};%N%N");

				-- Generate the old stuff
			from
				buffer.putstring ("int16 ")
				buffer.putstring (c_name)
				buffer.putstring ("[] = {%N")
				i := min_type_id
				nb := max_type_id
				index := lower
			until
				i > nb
			loop
				entry := local_copy.array_item (index)
				if i = entry.type_id then
					buffer.putint (entry.feature_type_id - 1)
					buffer.putstring (",%N")
					index := index + 1
				else
					buffer.putstring ("0,%N")
				end
				i := i + 1
			end
			buffer.putstring ("};%N%N")
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
			tmp: ARRAY [ENTRY]
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

			tmp := Tmp_poly_table
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
			quick_sort (lower, max_position)
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
			local_copy: POLY_TABLE [T]
		do
			local_copy := Current
				-- Define the pivot value as the first element of table
			x := local_copy.array_item (min).type_id

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
					up >= max or else local_copy.array_item (up).type_id > x
				loop
					up := up + 1
				end
			
					-- Decrement down until it selects the first element
					-- lesser than or equal to the pivot
				from
				until
					local_copy.array_item (down).type_id <= x
				loop
					down := down - 1
				end

				if up < down then
						-- If up < down  exchange their values until up
						-- meets or passes down
					temp := local_copy.array_item (up)
					put (local_copy.array_item (down), up)
					put (temp, down)
				end
			end

			temp := local_copy.array_item (down)
			put (local_copy.array_item (min), down)
			put (temp, min)
			Result := down
		end
			
feature {NONE} -- Implementation

	binary_search (type_id: INTEGER): INTEGER is
			-- Return position where `type_id' is in POLY_TABLE.
		local
			i, j, m: INTEGER
			local_copy: POLY_TABLE [T]
		do
			local_copy := Current
			j := max_position
			if j = 1 then
				Result := 1
			else
				from
					i := local_copy.lower
				until
					i = j
				loop
					m := (i + j) // 2 + 1
					if local_copy.array_item (m).type_id > type_id then
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
			area := arycpy ($area, upper - lower + 1 + n, 0, upper - lower + 1)
			upper := upper + n
		end

feature {POLY_TABLE} -- Special data

	Tmp_poly_table: ARRAY [ENTRY] is
			-- Contain a copy of Current during a merge
		once
			create Result.make (1, Block_size)
		end

	bad_cast_but_valid (e: POINTER): T is
		external
			"C [macro %"eif_eiffel.h%"]"
		alias
			"(EIF_REFERENCE)"
		end

	increase_tmp_size (n: INTEGER) is
			-- Increase the current array of `n' elements.
		do
			Tmp_poly_table.make (1, Tmp_poly_table.upper + (1 + n // Block_size) * Block_size)
		end

	Block_size: INTEGER is 50
			-- Size of a block of `Tmp_poly_table'.
end
