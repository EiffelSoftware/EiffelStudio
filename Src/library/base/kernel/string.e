--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	  --
--|	270 Storke Road, Suite 7 Goleta, California 93117		--
--|				   (805) 685-1006							--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class STRING inherit

	INDEXABLE [CHARACTER, INTEGER]
		redefine
			twin, copy, is_equal, out
		end;

	TO_SPECIAL [CHARACTER]
		redefine
			twin, copy, is_equal, out
		end;

	RESIZABLE
		undefine
			empty
		redefine
			twin, copy, is_equal, out
		end;

	BAG [CHARACTER]
		rename
			add as append_character
		redefine
			append_character, out, twin, copy, is_equal
		end;

	HASHABLE
		redefine
			twin, copy, is_equal, out
		end;

	COMPARABLE
		redefine
			twin, copy, is_equal, out
		end

creation

	make

feature -- Creation

	frozen make (n: INTEGER) is
			-- Allocate space for at least `n' characters.
		require
			non_negative_size: n >= 0
		do
			make_area (n);
		ensure
			empty_string: count = 0;
			area_allocated: capacity >= n;
		end;

feature -- Access

	item, infix "@" (i: INTEGER): CHARACTER is
			-- Character at position `i'
		require else
			index_small_enough: i <= count;
			index_large_enough: i > 0
		do
			Result := area.item (i - 1)
		end;

feature -- Access

	has (c: CHARACTER): BOOLEAN is
			-- Does `Current' include `c'?
		local
			counter: INTEGER
		do
			if not empty then
				from
				until
					counter = count or else (item (counter + 1) = c)
				loop
					counter := counter + 1;
				end;
				Result := counter /= count;
			end;
		end;

	item_code (i: INTEGER): INTEGER is
			-- Numeric code of character at position `i'
		require
			index_small_enough: i <= count;
			index_large_enough: i > 0;
		do
			Result := str_code ($area, i)
		end;

	hash_code: INTEGER is
			-- Hash code value of `Current'
		do
			Result := hashcode ($area, count)
		end;

	out: like Current is
			-- Printable representation of `Current'
		do
			!! Result.make (count + 2);
			Result.append ("%"");
			Result.append (Current);
			Result.append ("%"");
		end;

feature -- Insertion

	put (c: CHARACTER; i: INTEGER) is
			-- Replace character at position `i' by `c'.
		require else
			index_small_enough: i <= count;
			index_large_enough: i > 0
		do
			area.put (c, i - 1)
		end;

feature -- Insertion

	precede (c: CHARACTER) is
			-- Add `c' at front.
		do
			if count = capacity then
				resize (count + additional_space + 1)
			end;
			str_cprepend ($area, $c, count);
			count := count + 1
--		ensure
--		  New_count: count = old count + 1;
		end;

	prepend (s: STRING) is
			-- Prepend a copy of `s' at front of `Current'.
		require
			argument_not_void: s /= Void
		local
			new_size: INTEGER;
			s_area: like area
		do
			new_size := count + s.count;
			if new_size > capacity then
				resize (new_size + additional_space + 1)
			end;
			s_area := s.area;
			str_insert ($area, $s_area, count, s.count, 1);
			count := new_size
--		ensure
--		  New_count: count = old count + s.count;
		end;

	append (s: STRING) is
			-- Append a copy of `s' at end of `Current'.
		local
			new_size: INTEGER;
			s_area: like area
		do
			new_size := s.count + count;
			if new_size > capacity then
				resize (new_size + additional_space + 1)
			end;
			s_area := s.area;
			str_append ($area, $s_area, count, s.count);
			count := new_size
--		ensure then
--		  New_count: count = old count + s.count
		end;

	insert (s: like Current; i: INTEGER) is
			-- Insert the string `s' at the left of position `i' in Current.
		require
			string_exists: s /= Void;
			index_small_enough: i <= count;
			index_large_enough: i > 0
		local
			new_size: INTEGER;
			s_area: like area
		do
			new_size := s.count + count;
			if new_size > capacity then
				resize (new_size + additional_space + 1)
			end;
			s_area := s.area;
			str_insert ($area, $s_area, count, s.count, i);
			count := new_size
		ensure
		--  new_count: count = old count + s.count
		end;

	replace_substring (s: like Current; start_pos, end_pos:  INTEGER) is
			-- Replace the substring (`start_pos', `end_pos') of Current by `s'.
		require
			string_exists: s /= Void;
			index_small_enough: end_pos <= count;
			order_respected: start_pos <= end_pos;
			index_large_enough: start_pos > 0
		local
			new_size, substring_size: INTEGER;
			s_area: like area
		do
			substring_size := end_pos - start_pos + 1;
			new_size := s.count + count - substring_size;
			if new_size > capacity then
				resize (new_size + additional_space + 1)
			end;
			s_area := s.area;
			str_replace ($area, $s_area, count, s.count, start_pos, end_pos);
			count := new_size
		ensure
		--  new_count: count = old count + s.count - end_pos + start_pos -1
		end;

	append_integer (i: INTEGER) is
			-- Append the string representation of `i' at end of `Current'.
			--| Should use `sprintf'
		do
			append (i.out);
		end;

	append_real (r: REAL) is
			-- Append the string representation of `r' at end of `Current'.
			--| Should use `sprintf'
		do
			append (r.out);
		end;

	append_double (d: DOUBLE) is
			-- Append the string representation of `d' at end of `Current'.
			--| Should use `sprintf'
		do
			append (d.out);
		end;

	append_character (c: CHARACTER) is
			-- Append `c' at end of `Current'.
		do
			if count = capacity then
				resize (capacity + 1 + additional_space);
			end;
			area.put (c, count);
			count := count + 1;
		ensure then
			item_inserted: item (count) = c;
		end;

	append_boolean (b: BOOLEAN) is
			-- Append the string representation of `b' at end of `Current'.
			--| Should use `sprintf'
		do
			append (b.out);
		end;

	extensible: BOOLEAN is true;
			-- May new items be added to `Current'?

feature -- Deletion

	remove (i: INTEGER) is
			-- Remove `i'-th character.
		require
			index_small_enough: i <= count;
			index_large_enough: i > 0
		do
			str_rmchar ($area, count, i);
			count := count - 1;
--		ensure
--		  New_count: count = old count - 1;
		end;

	remove_item (c: CHARACTER) is
			-- Remove `c' from `Current'.
			-- No effect if `Current' doesn't include `c'.
		local
			counter: INTEGER
		do
			from
			until
				counter = count or else (item (counter + 1) = c)
			loop
				counter := counter + 1;
			end;
			if counter /= count then
				remove (counter + 1);
			end;
		end;

	remove_all_occurrences (c: CHARACTER) is
			-- Remove all occurrences of `c'.
		do
			count := str_rmall ($area, $c, count)
		ensure
			-- `for all i: 1..count, item (i) /= c'
			-- `count' = old `count' - number of
			-- occurrences of `c' in initial string
		end;

feature {NONE} -- Deletion

	contractable: BOOLEAN is
			-- May current item be removed from `Current'?
			-- Useless because no current item.
		do
		end;

feature -- Deletion

	wipe_out is
			-- Clear out `Current'.
		do
			make_area(0);
			count := 0;
		ensure then
			Empty_string: count = 0;
			Empty_area: capacity = 0
		end;

feature -- Transformation 

	twin: like Current is
			-- Clone of Current
		do
			!! Result.make (capacity);
			Result.copy (Current)
		end;

	duplicate: like Current is
			-- Copy of `Current'
		local
			other_area: like area;
		do
			!! Result.make (capacity);
			other_area := Result.area;
			str_cpy ($other_area, $area, count);
			Result.set_count (count)
		ensure
			New_result_count: Result.count = count;
			-- for all `i: 1..count, Result.item (i) = item (i)'
		end;

	mirrored: like Current is
			-- Current string read from right to left.
			-- The returned string has the same `capacity' and the
			-- same current position (i.e. the cursor is pointing
			-- at the same item)
		local
			result_area: like area;
		do
			!! Result.make (capacity);
			if count > 0 then
				result_area := Result.area;
				str_mirror ($area, $result_area, count);
				Result.set_count (count);
			end;
		ensure
			same_count: Result.count = count;
		--  reverse_entries:
		--	  for all `i: 1..count, Result.item (i) = item (count + 1 - i)'
		end;

	mirror is
			-- Reverse the characters order.
			-- "Hello world" -> "dlrow olleH".
			-- The current position will be on the same item
			-- as before.
		do
			str_reverse ($area, count);
--		ensure
		--  same_count: count = old count;
		--  reverse_entries:
		--	for all `i: 1..count, item (i) = old item (count + 1 - i)'
		end;

	substring (n1, n2: INTEGER): like Current is
			-- Copy of substring of `Current' containing
			-- all characters at indices between `n1' and `n2'
		require
			meaningful_origin: 1 <= n1;
			meaningful_interval: n1 <= n2;
			meaningful_end: n2 <= count
		local
			other_area: like area
		do
			!! Result.make (n2 - n1 + 1);
			other_area := Result.area;
			str_take ($area, $other_area, n1, n2);
			Result.set_count (n2 - n1 + 1)
		ensure
			New_result_count: Result.count = n2 - n1 + 1
			-- for all `i: 1..n2-n1, Result.item (i) = item (n1 + i - 1)'
		end;

	adapt (s: like Current): like Current is
			-- Object of a type conforming to the type of `s',
			-- initialized with attributes from `s'
		do
			!! Result.make (0);
			Result.share (s)
		end;

	share (other: like Current) is
			-- Make `Current' share the text of `other'.
		require
			argument_not_void: other /= Void
		do
			area := other.area;
			count := other.count;
		ensure
			Shared_count: other.count = count;
			-- for all `i: 1..count, Result.item (i) = item (i)';
			-- Subsequent changes to the characters of current string will
			-- also affect `other', and conversely
		end;

	shared_with (other: like Current): BOOLEAN is
			-- Does `Current' share the text of `other'?
		do
			Result := (other /= Void) and then (area = other.area)
		end;

	set (t: like Current; n1, n2: INTEGER) is
			-- Set `Current' to substring of `t' from `n1' .. `n2'
			-- and place index at the beginning of the string.
		require
			argument_not_void: t /= Void;
			meaningful_origin: 1 <= n1;
			meaningful_interval: n1 <= n2;
			meaningful_end: n2 <= t.count
		local
			t_area: like area
		do
			resize (n2 - n1 + 1); -- if necessary
			t_area := t.area;
			str_take ($t_area, $area, n1, n2);
			count := n2 - n1 + 1;
		ensure
			Is_substring: is_equal (t.substring (n1, n2))
		end;

	fill_blank is
			-- Fill with blanks.
		do
			str_blank ($area, capacity);
			count := capacity
		ensure
			-- for all `i: 1..capacity, item (i)' = `Blank'
		end;

	head (n: INTEGER) is
			-- Remove all characters except for the first `n';
			-- do nothing if `n >= count'.
		require
			non_negative_argument: n >= 0
		do
			if n < count then
				count := n
			end
		ensure
			-- `count' = min (`n', old `count')
		end;

	tail (n: INTEGER) is
			-- Remove all characters except for the last `n';
			-- do nothing if `n' >= `count'.
		require
			non_negative_argument: n >= 0
		do
			if n < count then
				str_tail ($area, n, count);
				count := n
			end
		ensure
			-- `count' = min (`n', old `count')
		end;

	left_adjust is
			-- Remove leading blanks.
		do
			count := str_left ($area, count);
		ensure
			New_count: (count /= 0) implies (item (1) /= ' ')
		end;

	right_adjust is
			-- Remove trailing blanks.
		do
			count := str_right ($area, count)
		ensure
			New_count: (count /= 0) implies (item (count) /= ' ')
		end;

	to_integer: INTEGER is
			-- Integer value of `Current',
			-- assumed to contain digits only.
			-- When applied to "123", will yield 123
		require
			-- String contains digits only
		do
			Result := str_atoi ($area, count)
		end;

	to_real: REAL is
			-- Real value of `Current',
			-- assumed to contain real digits only.
			-- When applied to "123.0", will yield 123.0
		require
			-- String contains real digits only
		do
			Result := str_ator ($area, count)
		end;

	to_double: DOUBLE is
			-- Double value of `Current',
			-- assumed to contain double digits only.
			-- When applied to "123.0", will yield 123.0
		require
			-- String contains double digits only
		do
			Result := str_atod ($area, count)
		end;

	to_boolean: BOOLEAN is
			-- Boolean value of `Current',
			-- "true" yields `true', "false" yields `false'
			-- (case insensitive)
		require
			-- String contains "true" or "false" only
			-- (case insensitive)
		local
			s: STRING
		do
			s := twin;
			s.to_lower;
			Result := s.is_equal (True_constant)
		end;

	True_constant: STRING is "true";
			-- Constant string "true"

	to_lower is
			-- Convert `Current' to lower case.
		do
			str_lower ($area, count)
		end;

	to_upper is
			-- Convert `Current' to upper case.
		do
			str_upper ($area, count)
		end;

feature {NONE} -- Transformation

	sequential_representation: SEQUENTIAL [CHARACTER] is
			-- Sequential representation of `Current'.
			-- This feature enables you to manipulate each
			-- item of `Current' regardless of its
			-- actual structure.
		do
		end;

feature -- Number of elements

	capacity: INTEGER is
			-- Allocated space
		do
			Result := area.count
		end;

	count: INTEGER;
			-- Actual number of characters making up the string

	adapt_size is
			-- Adapt the size to accomodate exactly `count' characters.
		do
			resize (count);
		end;

	resize (newsize: INTEGER) is
			-- Reallocate space to accommodate
			-- `newsize' characters.
			-- May discard some characters in string if `newsize' is
			-- lower than the number of characters making up the string
		require
			new_size_non_negative: newsize >= 0
		do
			area := str_resize ($area, newsize);
			if capacity < count then
				count := capacity;
			end;
		end;

	grow (newsize: INTEGER) is
			-- Change the capacity of `Current' to at least `newsize'.
		require else
			new_size_non_negative: newsize >= 0
		do
			if newsize > capacity then
				resize (newsize);
			end;
		end;

feature {STRING, UNIX_FILE, TEXT_FILLER} -- Number of elements

	frozen set_count (number: INTEGER) is
			-- Set `count' to `number' of characters in `Current'
		do
			count := number
		ensure
			New_count: count = number
		end;

feature -- Equality, clone, copy

	is_equal (other: like Current): BOOLEAN is
			-- Is `Current' made of same character sequence as `other'?
			-- `Current' may not have the same capacity.
		local
			o_area: like area;
			i: INTEGER
		do
			if count = other.count then
				o_area := other.area;
				i := str_cmp ($area, $o_area, count, other.count);
				Result := (i = 0);
			else
				Result := false;
			end;
		end;

	copy (other: like Current) is
			-- Reinitialize `Current' with copy of `other'.
		require else
			same_capacity: capacity = other.capacity
		do
			area.copy (other.area);
			count := other.count
		end;

	infix "<" (other: STRING): BOOLEAN is
			-- Is `Current' lexicographically lower than `other'?
			-- (False if other is void)
		local
			other_area: like area
		do
			if other /= Void then
				other_area := other.area;
				Result := str_cmp ($other_area, $area, other.count, count)>0
			end;
		end;

feature -- Assertion check

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' correctly bounded?
		do
			Result := (i > 0) and (i <= count);
		end;

feature -- External representation

	to_c: ANY is
			-- An integer which a C function may cast into a pointer
			-- to a `C' form of `Current'.
			-- Useful only for interfacing with C software.
		do
			if count = 0 or else item (count) /= '%U' then
				append_character ('%U');
				count := count - 1;
			end;
			Result := area
		end;

	from_c (c_string: ANY) is
			-- Assign to `Current' the contents of `c_string',
			-- a string created by some external C function.
		require
			c_string /= Void
		local
			length: INTEGER
		do
			length := str_len ($c_string);
			make_area (length);
			str_cpy ($area, $c_string, length);
			count := length
		end;

feature {STRING} -- Externals

	str_atoi (c_string: like area; length: INTEGER): INTEGER is
			-- Value of integer in `c_string'
		external
			"C"
		end;

	str_ator (c_string: like area; length: INTEGER): REAL is
			-- Value of real in `c_string'
		external
			"C"
		end;

	str_atod (c_string: like area; length: INTEGER): DOUBLE is
			-- Value of double in `c_string'
		external
			"C"
		end;

	str_left (c_string: like area; length: INTEGER): INTEGER is
			-- Remove all leading blanks from `c_string'.
			-- Return the new number of character making `c_string'
		external
			"C"
		end;

	str_right (c_string: like area; length: INTEGER): INTEGER is
			-- Remove all trailing blanks from `c_string'.
			-- Return the new number of character making `c_string'
		external
			"C"
		end;

	c_p_i: INTEGER is
			-- Number of characters per INTEGER
		do
			Result := Integer_bits / Character_bits;
		end;

	str_resize (a: like area; newsize: INTEGER): like area is
			-- Area which can accomodate
			-- at least `newsize' characters
		external
			"C"
		alias
			"sprealloc"
		end;

	str_search (c_str: like area; c: CHARACTER; i, len: INTEGER): INTEGER is
			-- Index of first occurrence of `c' in `c_str',
			-- equal or following  `i'-th position
			-- 0 if no occurrence
		external
			"C"
		end;

	str_str (c_str, o_str: like area; clen, olen, i, fuzzy: INTEGER): INTEGER is
			-- Forward search of `o_str' within `c_str' starting at `i'.
			-- Return the index within `c_str' where the pattern was
			-- located, 0 if not found.
			-- The 'fuzzy' parameter is the maximum allowed number of
			-- mismatches within the pattern. A 0 means an exact match.
		external
			"C"
		end;

	str_code (c_string: like area; i: INTEGER): INTEGER is
			-- Numeric code of `i'-th character in `c_string'
		external
			"C"
		end;

	hashcode (c_string: like area; len: INTEGER): INTEGER is
			-- Hash code value of `c_string'
		external
			"C"
		end;

	str_rmchar (c_string: like area; length, i: INTEGER) is
			-- Remove `i'-th character from `c_string'.
		external
			"C"
		end;

	str_blank (c_string: like area; n: INTEGER) is
			-- Fill `c_string' with `n' blanks.
		external
			"C"
		end;

	str_tail (c_string: like area; n, length: INTEGER) is
			-- Remove all characters in `c_string'
			-- except for the last `n'.
		external
			"C"
		end;

	str_mirror (c_string, new_string: like area; length: INTEGER) is
			-- Build a new string into `new_string' which is the
			-- mirror copy of the original string held in `c_string'.
		external
			"C"
		end;

	str_reverse (c_string: like area; length: INTEGER) is
			-- In-place reverse string `c_string'.
		external
			"C"
		end;

	str_take (other_string, c_string: like area; n1, n2: INTEGER) is
			-- Make `c_string' the substring of `other_string'
			-- from `n1' .. `n2'.
		external
			"C"
		end;

	str_lower (c_string: like area; length: INTEGER) is
			-- Convert `c_string' to lower case.
		external
			"C"
		end;

	str_upper (c_string: like area; length: INTEGER) is
			-- Convert `c_string' to upper case.
		external
			"C"
		end;

	str_cmp (this, other: like area; this_len, other_len: INTEGER ): INTEGER is
			-- Compare `this' and `other' C strings.
			-- 0 if equal, < 0 if `this' < `other',
			-- > 0 if `this' > `other'
		external
			"C"
		end;

	str_cpy (to_str: like area; from_str: ANY; length_from: INTEGER) is
			-- Copy `length_from' characters from `from_str' into `to_str'.
		external
			"C"
		end;

	str_len (c_string: ANY): INTEGER is
			-- Length of the C string: `c_string'
		external
			"C"
		alias
			"strlen"
		end;

	str_cprepend (c_string: like area; c: CHARACTER; length: INTEGER) is
			-- Prepend `c' to `c_string'.
		external
			"C"
		end;

	str_append (c_str, other_str: like area; c_len, other_len: INTEGER) is
			-- Append `other_str' to `c_str'.
		external
			"C"
		end;

	str_insert (c_string, other_string: like area; c_length, other_length,
			position: INTEGER) is
			-- Insert `other_string' into `c_string' at `position'.
			-- Insertion occurs at the left of `position'.
		external
			"C"
		end;

	str_replace (c_string, other_string: like area; c_length, other_length,
			star_post, end_pos: INTEGER) is
			-- Replace substring (`start_pos', `end_pos') from `c_string'
			-- by `other_string'.
		external
			"C"
		end;

	str_rmall (c_string: like area; c: CHARACTER; length: INTEGER): INTEGER is
			-- Remove all occurrences of `c' in `c_string'.
			-- Return new number of character making up `c_string'
		external
			"C"
		end;

feature -- Obsolete features

	clear is obsolete "Use ``wipe_out''"
		do
			wipe_out
		end;

	max_size: INTEGER is obsolete "Use ``capacity''"
		do
			Result := capacity
		end;

	to_external: ANY is obsolete "Use ``to_c''"
		do
			Result := to_c
		end;

invariant

	extensible = true

end

