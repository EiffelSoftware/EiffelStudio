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
			entry as array_entry
		end

	IDABLE
		rename
			id as rout_id,
			set_id as set_rout_id
		undefine
			setup, consistent, copy, is_equal
		end

	SHARED_WORKBENCH
		undefine
			setup, consistent, copy, is_equal
		end

	SHARED_CODE_FILES
		undefine
			setup, consistent, copy, is_equal
		end

	SHARED_ARRAY_BYTE
		undefine
			setup, consistent, copy, is_equal
		end

	SHARED_SERVER
		undefine
			setup, consistent, copy, is_equal
		end

	SH_DEBUG
		undefine
			setup, consistent, copy, is_equal
		end

	COMPILER_EXPORTER
		undefine
			setup, consistent, copy, is_equal
		end

feature -- Initialization

	create_block (n: INTEGER) is
			-- Create an array of `n' elements.
		require
			large_enough: n > 0
		do
			array_make (1,n)
			position := 1
		end	

	extend_block (n: INTEGER) is
			-- Extend current to `n' elements.
		require
			large_enough: n > 0
			not_empty: not empty
		do
			position := upper + 1
			increase_size (n)
		end

feature

	rout_id: ROUTINE_ID
			-- Routine id of the table

	set_rout_id (i: ROUTINE_ID) is
			-- Assign `i' to `rout_id'.
		do
			rout_id := i
		end

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
			if generable then
				writer.generate (Current)
			end
			if has_type_table and then not has_one_type then
				writer.generate_type_table (Current)
			end
		end

	generable: BOOLEAN is
			-- Has the table to be generated ?
		require
			not_empty: not empty
		do
--			Result := used and then is_polymorphic (min_used)
			Result := used
		end

	generate (file: INDENT_FILE) is
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
			not empty
		do
			Result := array_item (lower).type_id
		end

	max_type_id: INTEGER is
			-- Maximum type id of the table ?
		require
			not empty
		do
			Result := array_item (upper).type_id
		end

	min_used: INTEGER is
			-- Minimum used type id ?
		require
			not_empty: count > 0
			is_used: used
		local
			entry: T
			i, nb: INTEGER
			local_copy: like Current
		do
			from
				local_copy := Current
				i := lower
				nb := upper
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
			local_copy: like Current
		do
			from
				local_copy := Current
				i := upper
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
			entry: T
			local_copy: like Current
		do
			from
				local_copy := Current
				i := lower
				nb := upper
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
			not empty
			is_used: used
		do
			Result := max_used - min_used + 1
		end

	workbench_table_size: INTEGER is
			-- Size of the C table
		require
			not empty
		do
			Result := max_type_id - min_type_id + 1
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
			stop: BOOLEAN
			i, nb, index: INTEGER
			local_copy: like Current
		do
			from
				local_copy := Current
				i := binary_search (type_id)
				nb := upper
			until
				local_copy.array_item(i).used or else i > nb
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
			not_empty: not empty
		local
			i, nb, first_type: INTEGER
			local_copy: like Current
		do
			from
				local_copy := Current
				i := lower
				first_type := local_copy.array_item (i).feature_type_id
				i := i + 1
				nb := upper
				Result := true
			until
				i > nb or else not Result
			loop
				Result := local_copy.array_item (i).feature_type_id = first_type
				i := i + 1
			end
		end

	generate_type_table (file: INDENT_FILE) is
			-- Generate the associated type table in final mode.
		local
			i, j, nb, index: INTEGER
			entry: T
			local_copy: like Current
			c_name: STRING
		do
			local_copy := Current

				-- First generate type arrays for generic types.
			c_name := rout_id.type_table_name

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
						file.putstring ("static int16 ");
						file.putstring (c_name);
						file.putstring ("_pgtype");
						file.putint (j);
						file.putstring (" [] = {0,");
						entry.generate_cid (file, True);
						file.putstring ("-1};");
						file.new_line;
						j := j + 1
					end;
					index := index + 1
				end;
				i := i + 1;
			end;

				-- Now generate pointer table
			file.putstring ("int16 *");
			file.putstring (c_name);
			file.putstring ("_gen_type [] = {%N");

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
						file.putstring (c_name);
						file.putstring ("_pgtype");
						file.putint (j);
						file.putchar (',');
						j := j + 1;
					else
						file.putstring ("0,");
					end
					index := index + 1
				else
					file.putstring ("0,");
				end;
				file.new_line;

				i := i + 1;
			end;
			file.putstring ("0};%N%N");

				-- Generate the old stuff
			from
				file.putstring ("int16 ")
				file.putstring (c_name)
				file.putstring ("[] = {%N")
				i := min_type_id
				nb := max_type_id
				index := lower
			until
				i > nb
			loop
				entry := local_copy.array_item (index)
				if i = entry.type_id then
					file.putint (entry.feature_type_id - 1)
					file.putstring (",%N")
					index := index + 1
				else
					file.putstring ("0,%N")
				end
				i := i + 1
			end
			file.putstring ("};%N%N")
		end

	workbench_c_type: STRING is
			-- Associated C item structure name
		deferred
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Make byte code for the current poly table.
		require
			good_argument: ba /= Void
			not_empty: not empty
		local
			entry: T
			i, nb: INTEGER
			local_copy: like Current
		do
			make_header_code (ba)

				-- Entries byte code
			from
				local_copy := Current
				i := lower
				nb := upper
			until
				i > nb
			loop
				local_copy.array_item(i).make_byte_code (ba)
				i := i + 1
			end

			if has_type_table then
				ba.append ('%/001/')
				from
					i := lower	-- nb has already been computed and set to `upper'
				until
					i > nb
				loop
					entry := local_copy.array_item (i)
					ba.append_short_integer (entry.type_id - 1)
					ba.append_short_integer (entry.feature_type_id - 1)
					if entry.is_generic then
						entry.make_gen_type_byte_code (ba)
					end
					ba.append_short_integer (-1)
					i := i + 1
				end
			else
				ba.append ('%U')
			end
		end

	make_header_code (ba: BYTE_ARRAY) is
			-- Make header byte code
		do
				-- Routine id
			ba.append_int32_integer (rout_id.id)
				-- King of poly table: attribute / routine
			if is_routine_table then
				ba.append ('%/001/')
			else
				ba.append ('%U')
			end
				-- Minimum dynamic type
			ba.append_short_integer (min_type_id - 1)
				-- Maximum dynamic type
			ba.append_short_integer (max_type_id - 1)
				-- Count
			ba.append_short_integer (count)
		end

	is_routine_table: BOOLEAN is
			-- Is the current table a routine table ?
		do
			-- Do nothing
		end

	is_attribute_table: BOOLEAN is
			-- Is the current table an attribute table ?
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
			Result := (position > upper)
		end

	go_to (pos: INTEGER) is
		do
			position := pos
		end
		
	position: INTEGER
			-- Actual position in the POLY_TABLE

	first: T is
		do
			Result := array_item (lower)
		end

feature -- Insertion

	extend (v: T) is
		do
			put (v, position)
			position := position + 1
		end

	merge (other: like Current) is
			-- Put `other' into Current
		local
			i: INTEGER
		do
			i := upper
			increase_size (other.count)
			subcopy (other, other.lower, other.upper, i + 1)
		end

feature -- Status

	empty: BOOLEAN is
			-- Is there an element?
		do
			Result := position = 0
		end

feature -- Sort

	sort is
			-- Sort Current object in ascending order.
		do
			quick_sort (lower, upper)
		end

feature {NONE} -- Implementation of quick sort algorithm

	quick_sort (min, max: INTEGER) is
			-- Apply `quick sort' algorithm
		require
			in_bounds: min < max
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
			local_copy: like Current
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
			local_copy: like Current
		do
			j := upper
			if j = 1 then
				Result := 1
			else
				from
					local_copy := Current
					i := lower
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

end
