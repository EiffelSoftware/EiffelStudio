indexing

	description:
		"Sequences of characters, accessible through integer indices %
		%in a contiguous range.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class STRING inherit

	INDEXABLE [CHARACTER, INTEGER]
		redefine
			copy, is_equal, out, prune_all,
			consistent, setup,
			changeable_comparison_criterion
		end;

	RESIZABLE [CHARACTER]
		redefine
			copy, is_equal, out,
			consistent, setup,
			changeable_comparison_criterion
		end;

	HASHABLE
		redefine
			copy, is_equal, out,
			consistent, setup
		end;

	COMPARABLE
		redefine
			copy, is_equal, out,
			consistent, setup
		end;

	TO_SPECIAL [CHARACTER]
		redefine
			copy, is_equal, out,
			consistent, setup
		end;

creation

	make

feature -- Initialization

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

	adapt (s: STRING): like Current is
			-- Object of a type conforming to the type of `s',
			-- initialized with attributes from `s'
		do
			!! Result.make (0);
			Result.share (s)
		end;

	from_c (c_string: ANY) is
			-- Reset contents of string from contents of `c_string',
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

	setup (other: like Current) is
			-- Perform actions on a freshly created object so that
			-- the contents of `other' can be safely copied onto it.
		do
			make (other.capacity)	
		end;

feature -- Access

	item, infix "@" (i: INTEGER): CHARACTER is
			-- Character at position `i'
		do
			Result := area.item (i - 1)
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
			-- Hash code value.
		do
			Result := hashcode ($area, count)
		end;

	True_constant: STRING is "true";
			-- Constant string "true"

	shared_with (other: like Current): BOOLEAN is
			-- Does string share the text of `other'?
		do
			Result := (other /= Void) and then (area = other.area)
		end;


	has (c: CHARACTER): BOOLEAN is
			-- Does string include `c'?
		local
			counter: INTEGER
		do
			if not empty then
				from
					counter := 1
				until
					counter > count or else (item (counter) = c)
				loop
					counter := counter + 1;
				end;
				Result := (counter <= count);
			end;
		end;

	index_of (c: CHARACTER; start: INTEGER): INTEGER is
			-- Position of first occurrence of `c' at or after `start';
			-- 0 if none.
		do
			Result := str_search ($area, c, start, count)
		end;

	substring_index (other: STRING; start: INTEGER): INTEGER is
			-- Position of first occurrence of `other' at or after `start';
			-- 0 if none.
		do
			Result := str_str (area, other.area, count, other.count, start, 0);
		end;

feature -- Measurement

	capacity: INTEGER is
			-- Allocated space
		do
			Result := area.count
		end;

	count: INTEGER;
			-- Actual number of characters making up the string

	occurrences (c: CHARACTER): INTEGER is
			-- Number of times `c' appears in the string
		local
			counter: INTEGER
		do
			from
				counter := 1
			until
				counter > count
			loop
				if item (counter) = c then
					Result := Result + 1
				end;
				counter := counter + 1;
			end
		end;
			

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is string made of same character sequence as `other'
			-- (possibly with a different capacity)?
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

	infix "<" (other: STRING): BOOLEAN is
			-- Is string lexicographically lower than `other'?
			-- (False if `other' is void)
		local
			other_area: like area
		do
			if other /= Void then
				other_area := other.area;
				Result := str_cmp ($other_area, $area, other.count, count)>0
			end;
		end;

feature -- Status report	

	consistent (other: like Current): BOOLEAN is
				-- Is object in a consistent state so that `other'
				-- may be copied onto it? (Default answer: yes).
		do
			Result := (other.capacity = capacity)
		end;

	extendible: BOOLEAN is true;
			-- May new items be added? (Answer: yes.)


	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
		do
			Result := true
		end;

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' correctly bounded?
		do
			Result := (i > 0) and (i <= count);
		end;

	changeable_comparison_criterion: BOOLEAN is false;

feature -- Element change

	set (t: like Current; n1, n2: INTEGER) is
			-- Set current string to substring of `t' from indices `n1'
			-- to `n2', or to empty string if no such substring.
		require
			argument_not_void: t /= Void;
		local
			t_area: like area
		do
			if (1 <= n1) and (n1 <= n2) and (n2 <= t.count) then
				resize (n2 - n1 + 1); -- if necessary
				t_area := t.area;
				str_take ($t_area, $area, n1, n2);
				count := n2 - n1 + 1;
			else
				wipe_out
			end
		ensure
			is_substring: is_equal (t.substring (n1, n2))
		end;


	copy (other: like Current) is
			-- Reinitialize by copying the characters of `other'.
			-- (This is also used by `clone'.)
		do
			make (other.capacity);
			area.copy (other.area);
			count := other.count
		ensure then
			new_result_count: count = other.count;
			-- same_characters: For every `i' in 1..`count', `item' (`i') = `other'.`item' (`i')
		end;


	replace_substring (s: like Current; start_pos, end_pos:  INTEGER) is
			-- Copy the characters of `s' to positions
			-- `start_pos' .. `end_pos'.
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
				resize (new_size + additional_space)
			end;
			s_area := s.area;
			str_replace ($area, $s_area, count, s.count, start_pos, end_pos);
			count := new_size
		ensure
		   new_count: count = old count + s.count - end_pos + start_pos -1
		end;

	fill_blank is
			-- Fill with blanks.
		do
			str_blank ($area, capacity);
			count := capacity
		ensure
			-- all_blank: For every `i' in 1..`count', `item' (`i') = `Blank'
		end;

	head (n: INTEGER) is
			-- Remove all characters except for the first `n';
			-- do nothing if `n' >= `count'.
		require
			non_negative_argument: n >= 0
		do
			if n < count then
				count := n
			end
		ensure
			new_count: count = min (n, old count)
			-- first_kept: For every `i' in 1..`n', `item' (`i') = old `item' (`i')
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
			count = min (n, old count)
		end;

	left_adjust is
			-- Remove leading blanks.
		do
			count := str_left ($area, count);
		ensure
			new_count: (count /= 0) implies (item (1) /= ' ')
		end;

	right_adjust is
			-- Remove trailing blanks.
		do
			count := str_right ($area, count)
		ensure
			new_count: (count /= 0) implies (item (count) /= ' ')
		end;



	share (other: like Current) is
			-- Make current string share the text of `other'.
			-- Subsequent changes to the characters of current string
			-- will also affect `other', and conversely.
		require
			argument_not_void: other /= Void
		do
			area := other.area;
			count := other.count;
		ensure
			sHAred_count: other.count = count;
			-- sharing: For every `i' in 1..`count', `Result'.`item' (`i') = `item' (`i')
		end;


	put (c: CHARACTER; i: INTEGER) is
			-- Replace character at position `i' by `c'.
		require else
			index_small_enough: i <= count;
			index_large_enough: i > 0
		do
			area.put (c, i - 1)
		end;

	precede (c: CHARACTER) is
			-- Add `c' at front.
		do
			if count = capacity then
				resize (count + additional_space)
			end;
			str_cprepend ($area, $c, count);
			count := count + 1
 		ensure
 		  new_count: count = old count + 1;
		end;

	prepend (s: STRING) is
			-- Prepend a copy of `s' at front.
		require
			argument_not_void: s /= Void
		local
			new_size: INTEGER;
			s_area: like area
		do
			new_size := count + s.count;
			if new_size > capacity then
				resize (new_size + additional_space)
			end;
			s_area := s.area;
			str_insert ($area, $s_area, count, s.count, 1);
			count := new_size
 		ensure
 		  new_count: count = old count + s.count;
		end;

	append (s: STRING) is
			-- Append a copy of `s' at end.
		local
			new_size: INTEGER;
			s_area: like area
		do
			new_size := s.count + count;
			if new_size > capacity then
				resize (new_size + additional_space)
			end;
			s_area := s.area;
			str_append ($area, $s_area, count, s.count);
			count := new_size
 		ensure then
			new_count: count = old count + s.count
			-- appended: For every `i' in 1..`s'.`count', `item' (old `count'+`i') = `s'.`item' (`i')
		end;

	append_integer (i: INTEGER) is
			-- Append the string representation of `i' at end.
			--| Should use `sprintf'
		do
			append (i.out);
		end;

	append_real (r: REAL) is
			-- Append the string representation of `r' at end.
			--| Should use `sprintf'
		do
			append (r.out);
		end;

	append_double (d: DOUBLE) is
			-- Append the string representation of `d' at end.
			--| Should use `sprintf'
		do
			append (d.out);
		end;

	extend (c: CHARACTER) is
			-- Append `c' at end.
		do
			if count = capacity then
				resize (capacity + additional_space);
			end;
			area.put (c, count);
			count := count + 1;
		ensure then
			item_inserted: item (count) = c;
		end;

	append_boolean (b: BOOLEAN) is
			-- Append the string representation of `b' at end.
			--| Should use `sprintf'
		do
			append (b.out);
		end;

	insert (s: like Current; i: INTEGER) is
			-- Add `s' to the left of position `i' in current string.
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
				resize (new_size + additional_space)
			end;
			s_area := s.area;
			str_insert ($area, $s_area, count, s.count, i);
			count := new_size
		ensure
			new_count: count = old count + s.count
		end;

feature -- Removal

	remove (i: INTEGER) is
			-- Remove `i'-th character.
		require
			index_small_enough: i <= count;
			index_large_enough: i > 0
		do
			str_rmchar ($area, count, i);
			count := count - 1;
 		ensure
			new_count: count = old count - 1;
		end;

	prune (c: CHARACTER) is
			-- Remove first occurrence of `c', if any.
		require else
			true
		local
			counter: INTEGER
		do
			from
				counter := 1
			until
				counter > count or else (item (counter) = c)
			loop
				counter := counter + 1;
			end;
			if counter <= count then
				remove (counter);
			end;
		end;

	prune_all (c: CHARACTER) is
			-- Remove all occurrences of `c'.
		require else
			true
		do
			count := str_rmall ($area, $c, count)
		ensure then
			changed_count: count = (old count) - (old occurrences (c))
			-- removed: For every `i' in 1..`count', `item' (`i') /= `c'
		end;

	wipe_out is
			-- Remove all characters.
		do
			make_area(0);
			count := 0;
		ensure then
			Empty_string: count = 0;
			Empty_area: capacity = 0
		end;

feature -- Resizing

	adapt_size is
			-- Adapt the size to accommodate `count' characters.
		do
			resize (count);
		end;

	resize (newsize: INTEGER) is
			-- Reallocate space to accommodate
			-- `newsize' characters.
			-- May discard some characters if `newsize' is
			-- lower than the current number of characters.
		require
			new_size_non_negative: newsize >= 0
		do
			area := str_resize ($area, newsize);
			if capacity < count then
				count := capacity;
			end;
		end;

	grow (newsize: INTEGER) is
			-- Ensure that the capacity is at least `newsize'.
		require else
			new_size_non_negative: newsize >= 0
		do
			if newsize > capacity then
				resize (newsize);
			end;
		end;

feature -- Conversion

	to_lower is
			-- Convert to lower case.
		do
			str_lower ($area, count)
		end;

	to_upper is
			-- Convert to upper case.
		do
			str_upper ($area, count)
		end;

	to_integer: INTEGER is
			-- Integer value;
			-- for example, when applied to "123", will yield 123
		require
			-- String contains digits only
		do
			Result := str_atoi ($area, count)
		end;

	to_real: REAL is
			-- Real value;
			-- for example, when applied to "123.0", will yield 123.0
		require
			-- String is representation of real number.
		do
			Result := str_ator ($area, count)
		end;

	to_double: DOUBLE is
			-- "Double" value;
			-- for example, when applied to "123.0", will yield 123.0 (double)
		require
			-- String contains double digits only
		do
			Result := str_atod ($area, count)
		end;

	to_boolean: BOOLEAN is
			-- Boolean value;
			-- "true" yields `true', "false" yields `false' 
			-- (case-insensitive)
		require
			-- String is "true" or "false" (with some letters possibly upper-case)
		local
			s: STRING
		do
			s := clone (Current);
			s.to_lower;
			Result := s.is_equal (True_constant)
		end;

	linear_representation: LINEAR [CHARACTER] is
			-- Representation as a linear structure
		do
		end;

	to_c: ANY is
			-- An integer which a C function may cast into a pointer
			-- to a `C' form of current string.
			-- Useful only for interfacing with C software.
		do
			if count = 0 or else item (count) /= '%U' then
				extend ('%U');
				count := count - 1;
			end;
			Result := area
		end;

	mirrored: like Current is
			-- Mirror image of string;
			-- result for "Hello world" is "dlrow olleH".
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
			-- reversed: For every `i' in 1..`count', `Result'.`item' (`i') = `item' (`count'+1-`i')
		end;

	mirror is
			-- Reverse the order of characters.
			-- "Hello world" -> "dlrow olleH".
		do
			str_reverse ($area, count);
		ensure
			same_count: count = old count;
			-- reversed: For every `i' in 1..`count', `item' (`i') = old `item' (`count'+1-`i')
		end;

feature -- Duplication

	substring (n1, n2: INTEGER): like Current is
			-- Copy of substring containing all characters at indices
			-- between `n1' and `n2'
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
			new_result_count: Result.count = n2 - n1 + 1
			-- original_characters: For every `i' in 1..`n2'-`n1', `Result'.`item' (`i') = `item' (`n1'+`i'-1)
		end;

feature -- Output	

	out: like Current is
			-- Printable representation
		do
			Result := clone (Current);
		end;

feature -- Obsolete

	clear is obsolete "Use ``wipe_out''"
		do
			wipe_out
		end;

	duplicate: like Current is obsolete "Use ``clone (string)''"
		do
			Result := clone (Current)
		end;

	max_size: INTEGER is obsolete "Use ``capacity''"
		do
			Result := capacity
		end;

	to_external: ANY is obsolete "Use ``to_c''"
		do
			Result := to_c
		end;

feature {NONE} -- Inapplicable

	search_substring (other: STRING; start: INTEGER): INTEGER is
			-- Position of first occurrence of `other' at or after `start';
			-- 0 if none.
		obsolete "Use ``substring_index'' instead"
		do
			Result := substring_index (other, start);
		end;

feature {STRING, FILE, TEXT_FILLER} -- Implementation

	frozen set_count (number: INTEGER) is
			-- Set `count' to `number' of characters.
		do
			count := number
		ensure
			new_count: count = number
		end;

feature {STRING} -- Implementation

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

	c_p_i: INTEGER is
			-- Number of characters per INTEGER
		do
			Result := Integer_bits // Character_bits;
		end;

	str_len (c_string: ANY): INTEGER is
			-- Length of the C string: `c_string'
		external
			"C"
		alias
			"strlen"
		end;

	str_cmp (this, other: like area; this_len, other_len: INTEGER ): INTEGER is
			-- Compare `this' and `other' C strings.
			-- 0 if equal, < 0 if `this' < `other',
			-- > 0 if `this' > `other'
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

	str_reverse (c_string: like area; length: INTEGER) is
			-- In-place reverse string `c_string'.
		external
			"C"
		end;

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

	
	str_mirror (c_string, new_string: like area; length: INTEGER) is
			-- Build a new string into `new_string' which is the
			-- mirror copy of the original string held in `c_string'.
		external
			"C"
		end;
	

	str_cpy (to_str: like area; from_str: ANY; length_from: INTEGER) is
			-- Copy `length_from' characters from `from_str' into `to_str'.
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


	str_take (other_string, c_string: like area; n1, n2: INTEGER) is
			-- Make `c_string' the substring of `other_string'
			-- from `n1' .. `n2'.
		external
			"C"
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

	str_rmchar (c_string: like area; length, i: INTEGER) is
			-- Remove `i'-th character from `c_string'.
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

	str_resize (a: like area; newsize: INTEGER): like area is
			-- Area which can accomodate
			-- at least `newsize' characters
		external
			"C"
		alias
			"sprealloc"
		end;

invariant

	extendible: extendible;
	compare_character: object_comparison = false

end -- class STRING


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
