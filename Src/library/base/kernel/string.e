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

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Allocate space for at least `n' characters.
		require
			non_negative_size: n >= 0
		do
			make_area (n)
		ensure
			empty_string: count = 0;
			area_allocated: capacity >= n
		end;

feature -- Initialization

	remake (n: INTEGER) is
			-- Allocate space for at least `n' characters.
		require
			non_negative_size: n >= 0
		do
			make_area (n);
			count := 0
		ensure
			empty_string: count = 0;
			area_allocated: capacity >= n
		end;

	make_from_string (s: STRING) is
			-- Initialize from the characters of `s'.
			-- (Useful in proper descendants of class STRING,
			-- to initialize a string-like object from a manifest string.)
		require
			string_exists: s /= Void
		do
			area := s.area;
			count := s.count
		ensure
			shared_implementation: shared_with (s)
		end;

	adapt (s: STRING): like Current is
			-- Object of a type conforming to the type of `s',
			-- initialized with attributes from `s'
		do
			!! Result.make (0);
			Result.share (s)
		end;

	from_c (c_string: POINTER) is
			-- Reset contents of string from contents of `c_string',
			-- a string created by some external C function.
		require
			c_string_exists: c_string /= default_pointer
		local
			length: INTEGER
		do
			length := str_len (c_string);
			make_area (length);
			str_cpy ($area, c_string, length);
			count := length
		end;

	from_c_substring (c_string: POINTER; start_pos, end_pos: INTEGER) is
			-- Reset contents of string from substring of `c_string',
			-- a string created by some external C function.
		require
			c_string_exists: c_string /= default_pointer
			start_position_big_enough: start_pos >= 1
			end_position_big_enough: start_pos <= end_pos + 1
		local
			length: INTEGER
		do
			length := end_pos - start_pos + 1;
			make_area (length);
			str_take (c_string, $area, start_pos, end_pos);
			count := length
		ensure
			valid_count: count = end_pos - start_pos + 1
		end

	setup (other: like Current) is
			-- Perform actions on a freshly created object so that
			-- the contents of `other' can be safely copied onto it.
		do
			remake (other.capacity)
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
			-- Hash code value
		do
			Result := hashcode ($area, count)
		end;

	False_constant: STRING is "false";
			-- Constant string "false"

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
		require
			start_large_enough: start >= 1
			start_small_enough: start <= count
		do
			Result := str_search ($area, c, start, count)
		ensure
			correct_place: Result > 0 implies item (Result) = c
			-- forall x : start..Result, item (x) /= c
		end;

	last_index_of (c: CHARACTER; start_index_from_end: INTEGER): INTEGER is
			-- Position of last occurence of `c'.
			-- 0 if none
		require
			start_index_small_enough: start_index_from_end <= count
			start_index_large_enough: start_index_from_end >= 1
		do
			Result := str_last_search ($area, c, start_index_from_end)
		ensure
			correct_place: Result > 0 implies item (Result) = c
			-- forall x : Result..last, item (x) /= c
		end

	substring_index (other: STRING; start: INTEGER): INTEGER is
			-- Position of first occurrence of `other' at or after `start';
			-- 0 if none.
		require
			other_nonvoid: other /= Void
			other_notempty: not other.empty
			start_large_enough: start >= 1
			start_small_enough: start <= count
		do
			Result := str_str (area, other.area, count, other.count, start, 0);
		ensure
			correct_place: Result > 0 implies
				substring (Result, Result+other.count - 1).is_equal (other)
			-- forall x : start..Result
			--	not substring (x, x+other.count -1).is_equal (other)
		end;

	fuzzy_index (other: STRING; start: INTEGER; fuzz : INTEGER): INTEGER is
			-- Position of first occurrence of `other' at or after `start'
			-- with 0..`fuzz' mismatches between the string and `other'.
			-- 0 if there are no fuzzy matches
		require
			other_exists: other /= Void
			other_not_empty: not other.empty
			start_large_enough: start >= 1
			start_small_enough: start <= count
			acceptable_fuzzy: fuzz <= other.count
		do
			Result := str_str (area, other.area, count, other.count, start,
fuzz)
		end

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
		do
			if count = other.count then
				o_area := other.area;
				Result := str_strict_cmp ($area, $o_area, count) = 0;
			end;
		end;

	infix "<" (other: like Current): BOOLEAN is
			-- Is string lexicographically lower than `other'?
		local
			other_area: like area
		do
			other_area := other.area
			Result := str_cmp ($other_area, $area, other.count, count) > 0
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
			-- Is `i' within the bounds of the string?
		do
			Result := (i > 0) and (i <= count);
		end;

	changeable_comparison_criterion: BOOLEAN is false;

	is_integer: BOOLEAN is
			-- Is the string representing an integer?
		do
			Result := str_isi ($area, count)
		end;

	is_real: BOOLEAN is
			-- Is the string representing a real?
		do
			Result := str_isr ($area, count)
		end;

	is_double: BOOLEAN is
			-- Is the string representing a double?
		do
			Result := str_isd ($area, count)
		end;

	is_boolean: BOOLEAN is
			-- Is the string representing a boolean?
		local
			s: STRING
		do
			s := clone (Current);
			s.right_adjust;
			s.left_adjust;
			s.to_lower;
			Result := s.is_equal (True_constant) or else s.is_equal (False_constant)
		end;

feature -- Element change

	set (t: like Current; n1, n2: INTEGER) is
			-- Set current string to substring of `t' from indices `n1'
			-- to `n2', or to empty string if no such substring.
		require
			argument_not_void: t /= Void;
		do
			make_from_string (t.substring (n1, n2))
		ensure
			is_substring: is_equal (t.substring (n1, n2))
		end;

	copy (other: like Current) is
			-- Reinitialize by copying the characters of `other'.
			-- (This is also used by `clone'.)
		do
			remake (other.capacity);
			area.copy (other.area);
			count := other.count
		ensure then
			new_result_count: count = other.count;
			-- same_characters: For every `i' in 1..`count', `item' (`i') = `other'.`item' (`i')
		end;

	subcopy (other: like Current; start_pos, end_pos, index_pos: INTEGER) is
			-- Copy characters of `other' within bounds `start_pos' and
			-- `end_pos' to current string starting at index `index_pos'.
		require
			other_not_void: other /= Void;
			valid_start_pos: other.valid_index (start_pos)
			valid_end_pos: other.valid_index (end_pos)
			valid_bounds: (start_pos <= end_pos) or (start_pos = end_pos + 1)
			valid_index_pos: valid_index (index_pos)
			enough_space: (count - index_pos) >= (end_pos - start_pos)
		local
			other_area: like area
			start0, end0, index0: INTEGER
		do
			other_area := other.area;
			start0 := start_pos - 1;
			end0 := end_pos - 1;
			index0 := index_pos - 1;
			spsubcopy ($other_area, $area, start0, end0, index0)
		ensure
			-- copied: forall `i' in 0 .. (`end_pos'-`start_pos'),
			--     item (index_pos + i) = other.item (start_pos + i)
		end

	replace_substring (s: like Current; start_pos, end_pos: INTEGER) is
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
			new_count: count = old count + s.count - end_pos + start_pos - 1
		end;

	replace_substring_all (original, new: like Current) is
			-- Replace every occurence of `original' with `new'.
		require
			original_exists: original /= Void
			new_exists: new /= Void
			original_not_empty: not original.empty
		local
			change_pos :INTEGER
		do
			if not empty then
				from
					change_pos := substring_index (original, 1)
				until
					change_pos = 0
				loop
					replace_substring (new, change_pos, change_pos + original.count - 1)
					if change_pos + new.count <= count then
						change_pos := substring_index (original, change_pos + new.count)
					else
						change_pos := 0
					end
				end
			end
		end

	replace_blank is
			-- Replace all current characters with blanks.
		do
			str_blank ($area, count);
		ensure
			same_size: (count = old count) and (capacity = old capacity)
			-- all_blank: For every `i' in 1..`count, `item' (`i') = `Blank'
		end;

	fill_blank is
			-- Fill with `capacity' blank characters.
		do
			str_blank ($area, capacity);
			count := capacity
		ensure
			filled: full
			same_size: (count = capacity) and (capacity = old capacity)
			-- all_blank: For every `i' in 1..`capacity', `item' (`i') = `Blank'
		end;

	replace_character (c: CHARACTER) is
			-- Replace all current characters with characters all equal to `c'.
		do
			str_fill ($area, count, c);
		ensure
			same_size: (count = old count) and (capacity = old capacity)
			-- all_char: For every `i' in 1..`count', `item' (`i') = `c'
		end;

	fill_character (c: CHARACTER) is
			-- Fill with `capacity' characters all equal to `c'.
		do
			str_fill ($area, capacity, c);
			count := capacity
		ensure
			filled: full
			same_size: (count = capacity) and (capacity = old capacity)
			-- all_char: For every `i' in 1..`capacity', `item' (`i') = `c'
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
			new_count: count = n.min (old count)
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
			new_count: count = n.min (old count)
		end;

	left_adjust is
			-- Remove leading whitespace.
		do
			count := str_left ($area, count);
		ensure
			new_count: (count /= 0) implies
				((item (1) /= ' ') and
				 (item (1) /= '%T') and
				 (item (1) /= '%R') and
				 (item (1) /= '%N'))
		end;

	right_adjust is
			-- Remove trailing whitespace.
		do
			count := str_right ($area, count)
		ensure
			new_count: (count /= 0) implies
				((item (count) /= ' ') and
				 (item (count) /= '%T') and
				 (item (count) /= '%R') and
				 (item (count) /= '%N'))
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
			shared_count: other.count = count;
			-- sharing: For every `i' in 1..`count', `Result'.`item' (`i') = `item' (`i')
		end;

	put (c: CHARACTER; i: INTEGER) is
			-- Replace character at position `i' by `c'.
		do
			area.put (c, i - 1)
		end;

	precede (c: CHARACTER) is
			-- Add `c' at front.
		do
			if count = capacity then
				resize (count + additional_space)
			end;
			str_cprepend ($area, c, count);
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

	prepend_boolean (b: BOOLEAN) is
			-- Prepend the string representation of `b' at front.
		do
			prepend (b.out)
		end;

	prepend_character (c: CHARACTER) is
			-- Prepend the string representation of `c' at front.
		do
			prepend (c.out)
		end;

	prepend_double (d: DOUBLE) is
			-- Prepend the string representation of `d' at front.
		do
			prepend (d.out)
		end;

	prepend_integer (i: INTEGER) is
			-- Prepend the string representation of `i' at front.
		do
			prepend (i.out)
		end;

	prepend_real (r: REAL) is
			-- Prepend the string representation of `r' at front.
		do
			prepend (r.out)
		end;

	prepend_string (s: STRING) is
			-- Prepend a copy of `s', if not void, at front.
		do
			if s /= Void then
				prepend (s)
			end
		end;

	append (s: STRING) is
			-- Append a copy of `s' at end.
		require
			argument_not_void: s /= Void
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
			new_count: count = old count + old s.count
			-- appended: For every `i' in 1..`s'.`count', `item' (old `count'+`i') = `s'.`item' (`i')
		end;

	append_string (s: STRING) is
			-- Append a copy of `s', if not void, at end.
		do
			if s /= Void then
				append (s)
			end
		end;

	append_integer (i: INTEGER) is
			-- Append the string representation of `i' at end.
		do
			append (i.out);
		end;

	append_real (r: REAL) is
			-- Append the string representation of `r' at end.
		do
			append (r.out);
		end;

	append_double (d: DOUBLE) is
			-- Append the string representation of `d' at end.
		do
			append (d.out);
		end;

	append_character, extend (c: CHARACTER) is
			-- Append `c' at end.
		do
			if count = capacity then
				resize (capacity + additional_space);
			end;
			area.put (c, count);
			count := count + 1;
		ensure then
			item_inserted: item (count) = c;
			new_count: count = old count + 1
		end;

	append_boolean (b: BOOLEAN) is
			-- Append the string representation of `b' at end.
		do
			append (b.out);
		end;

	insert (s: STRING; i: INTEGER) is
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
			count := str_rmall ($area, c, count)
		ensure then
			changed_count: count = (old count) - (old occurrences (c))
			-- removed: For every `i' in 1..`count', `item' (`i') /= `c'
		end;

	prune_all_leading (c: CHARACTER) is
			-- Remove all leading occurrences of `c'.
		do
			from
			until
				empty or else item (1) /= c
			loop
				remove (1)
			end
		end;

	prune_all_trailing (c: CHARACTER) is
			-- Remove all trailing occurrences of `c'.
		do
			from
			until
				empty or else item (count) /= c
			loop
				remove (count)
			end
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

	clear_all is
			-- Reset all characters and keep current `capacity
		require
			area_exists: area /= Void
		do
			count := 0
		ensure
			Empty_string: count = 0
			Same_area: capacity = old capacity
		end

feature -- Resizing

	adapt_size is
			-- Adapt the size to accommodate `count' characters.
		do
			resize (count);
		end;

	resize (newsize: INTEGER) is
			-- Rearrange string so that it can accommodate
			-- at least `newsize' characters.
			-- Do not lose any previously entered character.
		require
			new_size_non_negative: newsize >= 0
		do
			if newsize >= count then
				area := str_resize ($area, newsize);
			else
				area := str_resize ($area, count);
			end
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

	left_justify is
			-- Left justify the string using
			-- the capacity as the width
		do
			str_ljustify ($area, count, capacity)
		end

	center_justify is
			-- Center justify the string using
			-- the capacity as the width
		do
			str_cjustify ($area, count, capacity)
		end

	right_justify is
			-- Right justify the string using
			-- the capacity as the width
		do
			str_rjustify ($area, count, capacity)
		end

	character_justify (pivot: CHARACTER; position: INTEGER) is
			-- Justify a string based on a `pivot'
			-- and the `position' it needs to be in
			-- the final string.
			-- This will grow the string if necessary
			-- to get the pivot in the correct place.
		require
			valid_position: position <= capacity
			positive_position: position >= 1
			pivot_not_space: pivot /= ' '
			not_empty: not empty
		do
			if index_of (pivot,1) < position then
				from
					precede (' ')
				until
					index_of (pivot,1) = position
				loop
					precede (' ')
				end
			elseif index_of (pivot,1 ) > position then
				from
					remove (1)
				until
					index_of (pivot,1) = position
				loop
					remove (1)
				end
			end
			from
			until
				count = capacity
			loop
				extend (' ')
			end
		end

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
			is_integer: is_integer
		do
			Result := str_atoi ($area, count)
		end;

	to_real: REAL is
			-- Real value;
			-- for example, when applied to "123.0", will yield 123.0
		require
			is_real: is_real
		do
			Result := str_ator ($area, count)
		end;

	to_double: DOUBLE is
			-- "Double" value;
			-- for example, when applied to "123.0", will yield 123.0 (double)
		require
			is_double: is_double
		do
			Result := str_atod ($area, count)
		end;

	to_boolean: BOOLEAN is
			-- Boolean value;
			-- "true" yields `True', "false" yields `False'
			-- (case-insensitive)
		require
			is_boolean: is_boolean
		local
			s: STRING
		do
			s := clone (Current);
			s.right_adjust;
			s.left_adjust;
			s.to_lower;
			Result := s.is_equal (True_constant)
		end;

	linear_representation: LINEAR [CHARACTER] is
			-- Representation as a linear structure
		local
			temp: ARRAYED_LIST [CHARACTER];
			i: INTEGER;
		do
			!! temp.make (capacity);
			from
				i := 1;
			until
				i > count
			loop
				temp.extend (item (i));
				i := i + 1;
			end;
			Result := temp;
		end;

	frozen to_c: ANY is
			-- A reference to a C form of current string.
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
		local
			other_area: like area
		do
			if (1 <= n1) and (n1 <= n2) and (n2 <= count) then
				!! Result.make (n2 - n1 + 1);
				other_area := Result.area;
				str_take ($area, $other_area, n1, n2);
				Result.set_count (n2 - n1 + 1);
			else
				!! Result.make (0)
			end
		ensure
			new_result_count: Result.count = n2 - n1 + 1 or Result.count = 0
			-- original_characters: For every `i' in 1..`n2'-`n1', `Result'.`item' (`i') = `item' (`n1'+`i'-1)
		end;

	multiply (n: INTEGER) is
			-- Duplicate a string within itself
			-- ("hello").multiply(3) => "hellohellohello"
		require
			meaningful_multiplier: n >= 1
		local
			s : STRING
			i : INTEGER
		do
			s := clone (Current)
			grow (n * count)
			from
				i := n
			until
				i = 1
			loop
				append (s)
				i := i - 1
			end
		end

feature -- Output

	out: like Current is
			-- Printable representation
		do
			Result := clone (Current);
		end;

feature {STRING, IO_MEDIUM} -- Implementation

	frozen set_count (number: INTEGER) is
			-- Set `count' to `number' of characters.
		require
			valid_count: 0 <= number and number <= capacity
		do
			count := number
		ensure
			new_count: count = number
		end;

feature {STRING} -- Implementation

	str_code (c_string: POINTER; i: INTEGER): INTEGER is
			-- Numeric code of `i'-th character in `c_string'
		external
			"C | %"eif_str.h%""
		end;

	hashcode (c_string: POINTER; len: INTEGER): INTEGER is
			-- Hash code value of `c_string'
		external
			"C | %"eif_tools.h%""
		end;

	str_search (c_str: POINTER; c: CHARACTER; i, len: INTEGER): INTEGER is
			-- Index of first occurrence of `c' in `c_str',
			-- equal or following `i'-th position
			-- 0 if no occurrence
		external
			"C | %"eif_str.h%""
		end;

	str_last_search (c_str: POINTER; c: CHARACTER; len: INTEGER): INTEGER is
			-- Index of last occurrence of `c' in `c_str',
			-- 0 if no occurrence
		external
			"C | %"eif_str.h%""
		end;

	str_str (c_str, o_str: like area; clen, olen, i, fuzzy: INTEGER): INTEGER is
			-- Forward search of `o_str' within `c_str' starting at `i'.
			-- Return the index within `c_str' where the pattern was
			-- located, 0 if not found.
			-- The 'fuzzy' parameter is the maximum allowed number of
			-- mismatches within the pattern. A 0 means an exact match.
		external
			"C | %"eif_eiffel.h%""
		end;

	c_p_i: INTEGER is
			-- Number of characters per INTEGER
		do
			Result := Integer_bits // Character_bits;
		end;

	str_len (c_string: POINTER): INTEGER is
			-- Length of the C string: `c_string'
		external
			"C | %"eif_str.h%""
		end;

	str_ljustify (c_string: POINTER; length,cap: INTEGER) is
			-- Left justify in a field of `capacity'
			-- the `c_string' of length `length'
		external
			"C | %"eif_str.h%""
		end;

	str_cjustify (c_string: POINTER; length,cap: INTEGER) is
			-- Center justify in a field of `capacity'
			-- the `c_string' of length `length'
		external
			"C | %"eif_str.h%""
		end;

	str_rjustify (c_string: POINTER; length,cap: INTEGER) is
			-- Right justify in a field of `capacity'
			-- the `c_string' of length `length'
		external
			"C | %"eif_str.h%""
		end;

	str_strict_cmp (this, other: POINTER; len: INTEGER ): INTEGER is
			-- Compare `this' and `other' C strings 
			-- for the first `len' characters.
			-- 0 if equal, < 0 if `this' < `other',
			-- > 0 if `this' > `other'
		external
			"C | <string.h>"
		alias
			"strncmp"
		end;
	
	str_cmp (this, other: POINTER; this_len, other_len: INTEGER ): INTEGER is
			-- Compare `this' and `other' C strings.
			-- 0 if equal, < 0 if `this' < `other',
			-- > 0 if `this' > `other'
		external
			"C | %"eif_str.h%""
		alias
			"str_cmp"
		end;

	str_lower (c_string: POINTER; length: INTEGER) is
			-- Convert `c_string' to lower case.
		external
			"C | %"eif_str.h%""
		end;

	str_upper (c_string: POINTER; length: INTEGER) is
			-- Convert `c_string' to upper case.
		external
			"C | %"eif_str.h%""
		end;

	str_reverse (c_string: POINTER; length: INTEGER) is
			-- In-place reverse string `c_string'.
		external
			"C | %"eif_str.h%""
		end;

	str_atoi (c_string: POINTER; length: INTEGER): INTEGER is
			-- Value of integer in `c_string'
		external
			"C | %"eif_str.h%""
		end;

	str_ator (c_string: POINTER; length: INTEGER): REAL is
			-- Value of real in `c_string'
		external
			"C | %"eif_str.h%""
		end;

	str_atod (c_string: POINTER; length: INTEGER): DOUBLE is
			-- Value of double in `c_string'
		external
			"C | %"eif_str.h%""
		end;

	str_isi (c_string: POINTER; length: INTEGER): BOOLEAN is
			-- Is is an integer?
		external
			"C | %"eif_str.h%""
		end;

	str_isr (c_string: POINTER; length: INTEGER): BOOLEAN is
			-- Is is a real?
		external
			"C | %"eif_str.h%""
		end;

	str_isd (c_string: POINTER; length: INTEGER): BOOLEAN is
			-- Is is a double?
		external
			"C | %"eif_str.h%""
		end;

	str_mirror (c_string, new_string: POINTER; length: INTEGER) is
			-- Build a new string into `new_string' which is the
			-- mirror copy of the original string held in `c_string'.
		external
			"C | %"eif_str.h%""
		end;

	str_cpy (to_str: POINTER; from_str: POINTER; length_from: INTEGER) is
			-- Copy `length_from' characters from `from_str' into `to_str'.
		external
			"C | %"eif_str.h%""
		end;

	str_blank (c_string: POINTER; n: INTEGER) is
			-- Fill `c_string' with `n' blanks.
		external
			"C | %"eif_str.h%""
		end;

	str_fill (c_string: POINTER; n: INTEGER; c: CHARACTER) is
			-- Fill `c_string' with `n' `c's.
		external
			"C | %"eif_str.h%""
		end;

	str_tail (c_string: POINTER; n, length: INTEGER) is
			-- Remove all characters in `c_string'
			-- except for the last `n'.
		external
			"C | %"eif_str.h%""
		end;

	str_take (other_string, c_string: POINTER; n1, n2: INTEGER) is
			-- Make `c_string' the substring of `other_string'
			-- from `n1' .. `n2'.
		external
			"C | %"eif_str.h%""
		end;

	str_cprepend (c_string: POINTER; c: CHARACTER; length: INTEGER) is
			-- Prepend `c' to `c_string'.
		external
			"C | %"eif_str.h%""
		end;

	str_append (c_str, other_str: POINTER; c_len, other_len: INTEGER) is
			-- Append `other_str' to `c_str'.
		external
			"C | %"eif_str.h%""
		end;

	str_insert (c_string, other_string: POINTER; c_length, other_length,
			position: INTEGER) is
			-- Insert `other_string' into `c_string' at `position'.
			-- Insertion occurs at the left of `position'.
		external
			"C | %"eif_str.h%""
		end;

	str_rmchar (c_string: POINTER; length, i: INTEGER) is
			-- Remove `i'-th character from `c_string'.
		external
			"C | %"eif_str.h%""
		end;

	str_replace (c_string, other_string: POINTER; c_length, other_length,
			star_post, end_pos: INTEGER) is
			-- Replace substring (`start_pos', `end_pos') from `c_string'
			-- by `other_string'.
		external
			"C | %"eif_str.h%""
		end;

	str_rmall (c_string: POINTER; c: CHARACTER; length: INTEGER): INTEGER is
			-- Remove all occurrences of `c' in `c_string'.
			-- Return new number of character making up `c_string'
		external
			"C | %"eif_str.h%""
		end;

	str_left (c_string: POINTER; length: INTEGER): INTEGER is
			-- Remove all leading whitespace from `c_string'.
			-- Return the new number of characters making `c_string'
		external
			"C | %"eif_str.h%""
		end;

	str_right (c_string: POINTER; length: INTEGER): INTEGER is
			-- Remove all trailing whitespace from `c_string'.
			-- Return the new number of characters making `c_string'
		external
			"C | %"eif_str.h%""
		end;

	str_resize (a: POINTER; newsize: INTEGER): like area is
			-- Area which can accomodate
			-- at least `newsize' characters
		external
			"C | %"eif_malloc.h%""
		alias
			"sprealloc"
		end;

	spsubcopy (source, target: POINTER; s, e, i: INTEGER) is
			-- Copy characters of `source' within bounds `s'
			-- and `e' to `target' starting at index `i'.
		external
			"C | %"eif_copy.h%""
		end

invariant

	extendible: extendible;
	compare_character: object_comparison = false

end -- class STRING


--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

