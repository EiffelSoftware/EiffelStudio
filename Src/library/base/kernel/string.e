indexing

	description: "[
		Sequences of characters, accessible through integer indices 
		in a contiguous range.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class STRING inherit

	INDEXABLE [CHARACTER, INTEGER]
		redefine
			copy, is_equal, out, prune_all,
			changeable_comparison_criterion
		end

	RESIZABLE [CHARACTER]
		redefine
			copy, is_equal, out,
			changeable_comparison_criterion
		end

	HASHABLE
		redefine
			copy, is_equal, out
		end

	COMPARABLE
		redefine
			copy, is_equal, out
		end

	TO_SPECIAL [CHARACTER]
		redefine
			copy, is_equal, out
		end

	STRING_HANDLER
		redefine
			copy, is_equal, out
		end

create
	make, make_from_string, make_from_c

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Allocate space for at least `n' characters.
		require
			non_negative_size: n >= 0
		do
			count := 0
			if n = 0 then
				area := empty_area
			else
				make_area (n + 1)
			end
		ensure
			empty_string: count = 0
			area_allocated: capacity >= n
		end

feature -- Initialization

	remake (n: INTEGER) is
			-- Allocate space for at least `n' characters.
		obsolete
			"Use `make' instead"
		require
			non_negative_size: n >= 0
		do
			count := 0
			make (n)
		ensure
			empty_string: count = 0
			area_allocated: capacity >= n
		end

	make_from_string (s: STRING) is
			-- Initialize from the characters of `s'.
			-- (Useful in proper descendants of class STRING,
			-- to initialize a string-like object from a manifest string.)
		require
			string_exists: s /= Void
		do
			area := s.area
			count := s.count
		ensure
			shared_implementation: shared_with (s)
		end

	make_from_c (c_string: POINTER) is
			-- Initialize from contents of `c_string',
			-- a string created by some external C function
		require
			c_string_exists: c_string /= default_pointer
		local
			length: INTEGER
		do
			length := str_len (c_string)
			make_area (length + 1)
			($area).memory_copy (c_string, length)
			count := length
		end

	from_c (c_string: POINTER) is
			-- Reset contents of string from contents of `c_string',
			-- a string created by some external C function.
		require
			c_string_exists: c_string /= default_pointer
		local
			length: INTEGER
		do
			length := str_len (c_string)
			if capacity < length then
				make_area (length + 1)
			end
			($area).memory_copy (c_string, length)
			count := length
		ensure
			no_zero_byte: not has ('%/0/')
			-- characters: for all i in 1..count, item (i) equals
			--             ASCII character at address c_string + (i - 1)
			-- correct_count: the ASCII character at address c_string + count
			--             is NULL
		end

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
			length := end_pos - start_pos + 1
			if capacity < length then
				make_area (length + 1)
			end
				-- Make `$area' the substring of `c_string'
				-- from `start_pos' .. `end_pos'.
			($area).memory_copy (c_string + (start_pos - 1), (end_pos - start_pos + 1))
			count := length
		ensure
			valid_count: count = end_pos - start_pos + 1
			-- characters: for all i in 1..count, item (i) equals
			--             ASCII character at address c_string + (i - 1)
		end

	adapt (s: STRING): like Current is
			-- Object of a type conforming to the type of `s',
			-- initialized with attributes from `s'
		do
			create Result.make (0)
			Result.share (s)
		end

feature -- Access

	item, infix "@" (i: INTEGER): CHARACTER is
			-- Character at position `i'
		do
			Result := area.item (i - 1)
		end

	item_code (i: INTEGER): INTEGER is
			-- Numeric code of character at position `i'
		require
			index_small_enough: i <= count
			index_large_enough: i > 0
		do
			Result := area.item (i - 1).code
		end

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := hashcode ($area, count)
		end

	False_constant: STRING is "false"
			-- Constant string "false"

	True_constant: STRING is "true"
			-- Constant string "true"

	shared_with (other: like Current): BOOLEAN is
			-- Does string share the text of `other'?
		do
			Result := (other /= Void) and then (area = other.area)
		end

	has (c: CHARACTER): BOOLEAN is
			-- Does string include `c'?
		local
			counter: INTEGER
		do
			if not is_empty then
				from
					counter := 1
				until
					counter > count or else (item (counter) = c)
				loop
					counter := counter + 1
				end
				Result := (counter <= count)
			end
		end

	index_of (c: CHARACTER; start: INTEGER): INTEGER is
			-- Position of first occurrence of `c' at or after `start';
			-- 0 if none.
		require
			start_large_enough: start >= 1
			start_small_enough: start <= count + 1
		local
			a: like area
			i, nb: INTEGER
		do
			nb := count
			if start <= nb then
				from
					i := start - 1
					nb := nb - 1
					a := area
				until
					i > nb or else a.item (i) = c
				loop
					i := i + 1
				end
				if i <= nb then
						-- We add +1 due to the area starting at 0 and not at 1.
					Result := i + 1
				end
			end
		ensure
			correct_place: Result > 0 implies item (Result) = c
			-- forall x : start..Result, item (x) /= c
		end

	last_index_of (c: CHARACTER; start_index_from_end: INTEGER): INTEGER is
			-- Position of last occurrence of `c'.
			-- 0 if none
		require
			start_index_small_enough: start_index_from_end <= count
			start_index_large_enough: start_index_from_end >= 1
		local
			a: like area
			i: INTEGER
		do
			from
				i := start_index_from_end - 1
				a := area
			until
				i < 0 or else a.item (i) = c
			loop
				i := i - 1
			end
			if i >= 0 then
					-- We add +1 due to the area starting at 0 and not at 1.
				Result := i + 1
			end
		ensure
			correct_place: Result > 0 implies item (Result) = c
			-- forall x : Result..last, item (x) /= c
		end

	substring_index (other: STRING; start: INTEGER): INTEGER is
			-- Position of first occurrence of `other' at or after `start';
			-- 0 if none.
		require
			other_nonvoid: other /= Void
			other_notempty: not other.is_empty
			start_large_enough: start >= 1
			start_small_enough: start <= count
		local
			a: ANY
		do
			a := other.area
			Result := str_str ($area, $a, count, other.count, start, 0)
		ensure
			correct_place: Result > 0 implies
				substring (Result, Result + other.count - 1).is_equal (other)
			-- forall x : start..Result
			--	not substring (x, x+other.count -1).is_equal (other)
		end

	fuzzy_index (other: STRING; start: INTEGER; fuzz: INTEGER): INTEGER is
			-- Position of first occurrence of `other' at or after `start'
			-- with 0..`fuzz' mismatches between the string and `other'.
			-- 0 if there are no fuzzy matches
		require
			other_exists: other /= Void
			other_not_empty: not other.is_empty
			start_large_enough: start >= 1
			start_small_enough: start <= count
			acceptable_fuzzy: fuzz <= other.count
		local
			a: ANY
		do
			a := other.area
			Result := str_str ($area, $a, count, other.count, start, fuzz)
		end

feature -- Measurement

	capacity: INTEGER is
			-- Allocated space
		do
			Result := area.count - 1
		end

	count: INTEGER
			-- Actual number of characters making up the string

	occurrences (c: CHARACTER): INTEGER is
			-- Number of times `c' appears in the string
		local
			counter, nb: INTEGER
			a: SPECIAL [CHARACTER]
		do
			from
				counter := 0
				nb := count - 1
				a := area
			until
				counter > nb
			loop
				if a.item (counter) = c then
					Result := Result + 1
				end
				counter := counter + 1
			end
		end

	index_set: INTEGER_INTERVAL is
			-- Range of acceptable indexes
		do
			create Result.make (1, count)
		ensure then
			Result.count = count
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is string made of same character sequence as `other'
			-- (possibly with a different capacity)?
		local
			o_area: like area
		do
			if other = Current then
				Result := True
			elseif count = other.count then
				o_area := other.area
				Result := str_strict_cmp ($area, $o_area, count) = 0
			end
		end

	infix "<" (other: like Current): BOOLEAN is
			-- Is string lexicographically lower than `other'?
		local
			other_area: like area
			other_count: INTEGER
			current_count: INTEGER
		do
			other_area := other.area
			other_count := other.count
			current_count := count
			if other_count = current_count then
				Result := str_strict_cmp ($other_area, $area, other_count) > 0
			else
				if current_count < other_count then
					Result := str_strict_cmp ($other_area, $area, current_count) >= 0
				else
					Result := str_strict_cmp ($other_area, $area, other_count) > 0
				end
			end
		end

feature -- Status report

	extendible: BOOLEAN is True
			-- May new items be added? (Answer: yes.)

	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
		do
			Result := True
		end

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' within the bounds of the string?
		do
			Result := (i > 0) and (i <= count)
		end

	changeable_comparison_criterion: BOOLEAN is False

	is_integer: BOOLEAN is
			-- Does `Current' represent an INTEGER?
		do
			Result := str_isi ($area, count)
		end

	is_real: BOOLEAN is
			-- Does `Current' represent a REAL?
		do
			Result := str_isr ($area, count)
		ensure
			syntax_and_range:
				-- 'result' is True if and only if the following two
				-- conditions are satisfied:
				--
				-- 1. In the following BNF grammar, the value of
				--    'Current' can be produced by "Real_literal":
				--
				-- Real_literal    = Mantissa [Exponent_part]
				-- Exponent_part   = "E" Exponent
				--                 | "e" Exponent
				-- Exponent        = Integer_literal
				-- Mantissa        = Decimal_literal
				-- Decimal_literal = Integer_literal ["." Integer]
				-- Integer_literal = [Sign] Integer
				-- Sign            = "+" | "-"
				-- Integer         = Digit | Digit Integer
				-- Digit           = "0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"
				--
				-- 2. The numerical value represented by 'Current'
				--    is within the range that can be represented
				--    by an instance of type REAL.
		end

	is_double: BOOLEAN is
			-- Does `Current' represent a DOUBLE?
		do
			Result := str_isd ($area, count)
		ensure
			syntax_and_range:
				-- 'result' is True if and only if the following two
				-- conditions are satisfied:
				--
				-- 1. In the following BNF grammar, the value of
				--    'Current' can be produced by "Real_literal":
				--
				-- Real_literal    = Mantissa [Exponent_part]
				-- Exponent_part   = "E" Exponent
				--                 | "e" Exponent
				-- Exponent        = Integer_literal
				-- Mantissa        = Decimal_literal
				-- Decimal_literal = Integer_literal ["." Integer]
				-- Integer_literal = [Sign] Integer
				-- Sign            = "+" | "-"
				-- Integer         = Digit | Digit Integer
				-- Digit           = "0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"
				--
				-- 2. The numerical value represented by 'Current'
				--    is within the range that can be represented
				--    by an instance of type DOUBLE.
		end
	
	is_boolean: BOOLEAN is
			-- Does `Current' represent a BOOLEAN?
		local
			s: STRING
		do
			s := clone (Current)
			s.right_adjust
			s.left_adjust
			s.to_lower
			Result := s.is_equal (True_constant) or else s.is_equal (False_constant)
		end

feature -- Element change

	set (t: like Current; n1, n2: INTEGER) is
			-- Set current string to substring of `t' from indices `n1'
			-- to `n2', or to empty string if no such substring.
		require
			argument_not_void: t /= Void
		local
			s: STRING
		do
			s := t.substring (n1, n2)
			area := s.area
			count := s.count
		ensure
			is_substring: is_equal (t.substring (n1, n2))
		end

	copy (other: like Current) is
			-- Reinitialize by copying the characters of `other'.
			-- (This is also used by `clone'.)
		local
			old_area: like area
		do
			if other /= Current then
				old_area := area
				standard_copy (other)
				if old_area = Void or else old_area.count < area.count then
					area := standard_clone (area)
				else
					($old_area).memory_copy ($area, count)
					area := old_area
				end
			end
		ensure then
			new_result_count: count = other.count
			-- same_characters: For every `i' in 1..`count', `item' (`i') = `other'.`item' (`i')
		end

	subcopy (other: like Current; start_pos, end_pos, index_pos: INTEGER) is
			-- Copy characters of `other' within bounds `start_pos' and
			-- `end_pos' to current string starting at index `index_pos'.
		require
			other_not_void: other /= Void
			valid_start_pos: other.valid_index (start_pos)
			valid_end_pos: other.valid_index (end_pos)
			valid_bounds: (start_pos <= end_pos) or (start_pos = end_pos + 1)
			valid_index_pos: valid_index (index_pos)
			enough_space: (count - index_pos) >= (end_pos - start_pos)
		local
			other_area: like area
			start0, end0, index0: INTEGER
		do
			other_area := other.area
			start0 := start_pos - 1
			end0 := end_pos - 1
			index0 := index_pos - 1
			spsubcopy ($other_area, $area, start0, end0, index0)
		ensure
			-- copied: forall `i' in 0 .. (`end_pos'-`start_pos'),
			--     item (index_pos + i) = other.item (start_pos + i)
		end

	replace_substring (s: like Current; start_pos, end_pos: INTEGER) is
			-- Copy the characters of `s' to positions
			-- `start_pos' .. `end_pos'.
		require
			string_exists: s /= Void
			index_small_enough: end_pos <= count
			order_respected: start_pos <= end_pos
			index_large_enough: start_pos > 0
		local
			new_size, substring_size: INTEGER
			s_area: like area
		do
			substring_size := end_pos - start_pos + 1
			new_size := s.count + count - substring_size
			if new_size > capacity then
				resize (new_size + additional_space)
			end
			s_area := s.area
			str_replace ($area, $s_area, count, s.count, start_pos, end_pos)
			count := new_size
		ensure
			new_count: count = old count + s.count - end_pos + start_pos - 1
		end

	replace_substring_all (original, new: like Current) is
			-- Replace every occurrence of `original' with `new'.
		require
			original_exists: original /= Void
			new_exists: new /= Void
			original_not_empty: not original.is_empty
		local
			change_pos: INTEGER
		do
			if not is_empty then
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
			replace_character (' ')
		ensure
			same_size: (count = old count) and (capacity = old capacity)
			-- all_blank: For every `i' in 1..`count, `item' (`i') = `Blank'
		end

	fill_blank is
			-- Fill with `capacity' blank characters.
		do
			fill_character (' ')
		ensure
			filled: full
			same_size: (count = capacity) and (capacity = old capacity)
			-- all_blank: For every `i' in 1..`capacity', `item' (`i') = `Blank'
		end

	replace_character (c: CHARACTER) is
			-- Replace all current characters with characters all equal to `c'.
		do
			($area).memory_set (c.code, count)
		ensure
			same_size: (count = old count) and (capacity = old capacity)
			-- all_char: For every `i' in 1..`count', `item' (`i') = `c'
		end

	fill_character (c: CHARACTER) is
			-- Fill with `capacity' characters all equal to `c'.
		do
			($area).memory_set (c.code, capacity)
			count := capacity
		ensure
			filled: full
			same_size: (count = capacity) and (capacity = old capacity)
			-- all_char: For every `i' in 1..`capacity', `item' (`i') = `c'
		end

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
		end

	tail (n: INTEGER) is
			-- Remove all characters except for the last `n';
			-- do nothing if `n' >= `count'.
		require
			non_negative_argument: n >= 0
		local
			i, j: INTEGER
		do
			if n < count then
				from
					j := (count - n)
					i := 0
				until
					i = n
				loop
					area.put (area.item (j), i)
					i := i + 1
					j := j + 1
				end
				count := n
			end
		ensure
			new_count: count = n.min (old count)
		end

	left_adjust is
			-- Remove leading whitespace.
		do
			count := str_left ($area, count)
		ensure
			new_count: (count /= 0) implies
				((item (1) /= ' ') and
				 (item (1) /= '%T') and
				 (item (1) /= '%R') and
				 (item (1) /= '%N'))
		end

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
		end

	share (other: like Current) is
			-- Make current string share the text of `other'.
			-- Subsequent changes to the characters of current string
			-- will also affect `other', and conversely.
		require
			argument_not_void: other /= Void
		do
			area := other.area
			count := other.count
		ensure
			shared_count: other.count = count
			-- sharing: For every `i' in 1..`count', `Result'.`item' (`i') = `item' (`i')
		end

	put (c: CHARACTER; i: INTEGER) is
			-- Replace character at position `i' by `c'.
		do
			area.put (c, i - 1)
		end

	precede (c: CHARACTER) is
			-- Add `c' at front.
		do
			if count = capacity then
				resize (count + additional_space)
			end
			str_cprepend ($area, c, count)
			count := count + 1
		ensure
			new_count: count = old count + 1
		end

	prepend (s: STRING) is
			-- Prepend a copy of `s' at front.
		require
			argument_not_void: s /= Void
		local
			new_size: INTEGER
			s_area: like area
		do
			new_size := count + s.count
			if new_size > capacity then
				resize (new_size + additional_space)
			end
			s_area := s.area
			str_insert ($area, $s_area, count, s.count, 1)
			count := new_size
		ensure
			new_count: count = old count + s.count
		end

	prepend_boolean (b: BOOLEAN) is
			-- Prepend the string representation of `b' at front.
		do
			prepend (b.out)
		end

	prepend_character (c: CHARACTER) is
			-- Prepend the string representation of `c' at front.
		do
			prepend (c.out)
		end

	prepend_double (d: DOUBLE) is
			-- Prepend the string representation of `d' at front.
		do
			prepend (d.out)
		end

	prepend_integer (i: INTEGER) is
			-- Prepend the string representation of `i' at front.
		do
			prepend (i.out)
		end

	prepend_real (r: REAL) is
			-- Prepend the string representation of `r' at front.
		do
			prepend (r.out)
		end

	prepend_string (s: STRING) is
			-- Prepend a copy of `s', if not void, at front.
		do
			if s /= Void then
				prepend (s)
			end
		end

	append (s: STRING) is
			-- Append a copy of `s' at end.
		require
			argument_not_void: s /= Void
		local
			new_size: INTEGER
			s_area: like area
		do
			new_size := s.count + count
			if new_size > capacity then
				resize (new_size + additional_space)
			end
			s_area := s.area;
			($area + count).memory_copy ($s_area, s.count)
			count := new_size
		ensure
			new_count: count = old count + old s.count
			-- appended: For every `i' in 1..`s'.`count', `item' (old `count'+`i') = `s'.`item' (`i')
		end

	infix "+" (s: STRING): STRING is
			-- Append a copy of 's' at the end of a copy of Current,
			-- Then return the Result.
		require
			argument_not_void: s /= Void	
		do
			create Result.make (count + s.count)
			Result.append_string (Current)
			Result.append_string (s)
		ensure
			Result_exists: Result /= Void
			new_count: Result.count = count + s.count
		end

	append_string (s: STRING) is
			-- Append a copy of `s', if not void, at end.
		do
			if s /= Void then
				append (s)
			end
		end

	append_integer (i: INTEGER) is
			-- Append the string representation of `i' at end.
		do
			append (i.out)
		end

	append_real (r: REAL) is
			-- Append the string representation of `r' at end.
		do
			append (r.out)
		end

	append_double (d: DOUBLE) is
			-- Append the string representation of `d' at end.
		do
			append (d.out)
		end

	append_character, extend (c: CHARACTER) is
			-- Append `c' at end.
		local
			current_count: INTEGER
		do
			current_count := count
			if current_count = capacity then
				resize (current_count + additional_space)
			end
			area.put (c, current_count)
			count := current_count + 1
		ensure then
			item_inserted: item (count) = c
			new_count: count = old count + 1
		end

	append_boolean (b: BOOLEAN) is
			-- Append the string representation of `b' at end.
		do
			append (b.out)
		end

	insert (s: STRING; i: INTEGER) is
			-- Add `s' to the left of position `i' in current string.
		require
			string_exists: s /= Void
			index_small_enough: i <= count
			index_large_enough: i > 0
		local
			new_size: INTEGER
			s_area: like area
		do
			new_size := s.count + count
			if new_size > capacity then
				resize (new_size + additional_space)
			end
			s_area := s.area
			str_insert ($area, $s_area, count, s.count, i)
			count := new_size
		ensure
			new_count: count = old count + s.count
		end

feature -- Removal

	remove (i: INTEGER) is
			-- Remove `i'-th character.
		require
			index_small_enough: i <= count
			index_large_enough: i > 0
		do
			str_rmchar ($area, count, i)
			count := count - 1
		ensure
			new_count: count = old count - 1
		end

	prune (c: CHARACTER) is
			-- Remove first occurrence of `c', if any.
		require else
			True
		local
			counter: INTEGER
		do
			from
				counter := 1
			until
				counter > count or else (item (counter) = c)
			loop
				counter := counter + 1
			end
			if counter <= count then
				remove (counter)
			end
		end

	prune_all (c: CHARACTER) is
			-- Remove all occurrences of `c'.
		require else
			True
		do
			count := str_rmall ($area, c, count)
		ensure then
			changed_count: count = (old count) - (old occurrences (c))
			-- removed: For every `i' in 1..`count', `item' (`i') /= `c'
		end

	prune_all_leading (c: CHARACTER) is
			-- Remove all leading occurrences of `c'.
		do
			from
			until
				is_empty or else item (1) /= c
			loop
				remove (1)
			end
		end

	prune_all_trailing (c: CHARACTER) is
			-- Remove all trailing occurrences of `c'.
		do
			from
			until
				is_empty or else item (count) /= c
			loop
				remove (count)
			end
		end

	wipe_out is
			-- Remove all characters.
		do
			area := empty_area
			count := 0
		ensure then
			is_empty: count = 0
			empty_capacity: capacity = 0
		end

	clear_all is
			-- Reset all characters.
		do
			count := 0
		ensure
			is_empty: count = 0
			same_capacity: capacity = old capacity
		end

feature -- Resizing

	adapt_size is
			-- Adapt the size to accommodate `count' characters.
		do
			resize (count)
		end

	resize (newsize: INTEGER) is
			-- Rearrange string so that it can accommodate
			-- at least `newsize' characters.
			-- Do not lose any previously entered character.
		require
			new_size_non_negative: newsize >= 0
		local
			area_count: INTEGER
		do
			area_count := area.count
			if newsize >= area_count then
				if area_count = 1 then
					make_area (newsize + 1)
				else
					area := str_resize ($area, newsize + 1)
				end
			end
		end

	grow (newsize: INTEGER) is
			-- Ensure that the capacity is at least `newsize'.
		require else
			new_size_non_negative: newsize >= 0
		do
			if newsize > capacity then
				resize (newsize)
			end
		end

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
			not_empty: not is_empty
		do
			if index_of (pivot, 1) < position then
				from
					precede (' ')
				until
					index_of (pivot, 1) = position
				loop
					precede (' ')
				end
			elseif index_of (pivot, 1) > position then
				from
					remove (1)
				until
					index_of (pivot, 1) = position
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
		local
			i: INTEGER
			a: like area
		do
			from
				i := count - 1
				a := area
			until
				i < 0
			loop
				a.put (a.item (i).lower, i)
				i := i - 1
			end
		end

	to_upper is
			-- Convert to upper case.
		local
			i: INTEGER
			a: like area
		do
			from
				i := count - 1
				a := area
			until
				i < 0
			loop
				a.put (a.item (i).upper, i)
				i := i - 1
			end
		end

	to_integer: INTEGER is
			-- Integer value;
			-- for example, when applied to "123", will yield 123
		require
			is_integer: is_integer
		do
			Result := str_atoi ($area, count)
		end

	to_real: REAL is
			-- Real value;
			-- for example, when applied to "123.0", will yield 123.0
		require
			represents_a_real: is_real
		do
			Result := str_ator ($area, count)
		end

	to_double: DOUBLE is
			-- "Double" value;
			-- for example, when applied to "123.0", will yield 123.0 (double)
		require
			represents_a_double: is_double
		do
			Result := str_atod ($area, count)
		end

	to_boolean: BOOLEAN is
			-- Boolean value;
			-- "True" yields `True', "False" yields `False'
			-- (case-insensitive)
		require
			is_boolean: is_boolean
		local
			s: STRING
		do
			s := clone (Current)
			s.right_adjust
			s.left_adjust
			s.to_lower
			Result := s.is_equal (True_constant)
		end

	linear_representation: LINEAR [CHARACTER] is
			-- Representation as a linear structure
		local
			temp: ARRAYED_LIST [CHARACTER]
			i: INTEGER
		do
			create temp.make (capacity)
			from
				i := 1
			until
				i > count
			loop
				temp.extend (item (i))
				i := i + 1
			end
			Result := temp
		end
	
	split (a_separator: CHARACTER): LIST [STRING] is
			-- Split on `a_separator'.
		local
			l_list: ARRAYED_LIST [STRING]
			part: STRING
			i, j, c: INTEGER
		do
			c := count
				-- Worse case allocation: every character is a separator
			create l_list.make (c + 1)
			if c > 0 then
				from
					i := 1
				until
					i > c
				loop
					j := index_of (a_separator, i)
					if j = 0 then
							-- No separator was found, we will
							-- simply create a list with a copy of
							-- Current in it.
						j := c + 1
					end
					part := substring (i, j - 1)
					l_list.extend (part)
					i := j + 1
				end
				if j = c then
					check
						last_character_is_a_separator: item (j) = a_separator
					end
						-- A separator was found at the end of the string
					l_list.extend ("")
				end
			else
					-- Extend empty string, since Current is empty.
				l_list.extend ("")	
			end
			Result := l_list
			check 
				l_list.count = occurrences (a_separator) + 1
			end
		ensure
			Result /= Void
		end
	
	frozen to_c: ANY is
			-- A reference to a C form of current string.
			-- Useful only for interfacing with C software.
		do
			area.put ('%U', count)
			Result := area
		end

	mirrored: like Current is
			-- Mirror image of string;
			-- result for "Hello world" is "dlrow olleH".
		do
			Result := clone (Current)
			if count > 0 then
				Result.mirror
			end
		ensure
			same_count: Result.count = count
			-- reversed: For every `i' in 1..`count', `Result'.`item' (`i') = `item' (`count'+1-`i')
		end

	mirror is
			-- Reverse the order of characters.
			-- "Hello world" -> "dlrow olleH".
		local
			a: like area
			c: CHARACTER
			i, j: INTEGER
		do
			if count > 0 then
				from
					i := count - 1
					a := area
				until
					i <= j
				loop
					c := a.item (i)
					a.put (a.item (j), i)
					a.put (c, j)
					i := i - 1
					j := j + 1
				end
			end
		ensure
			same_count: count = old count
			-- reversed: For every `i' in 1..`count', `item' (`i') = old `item' (`count'+1-`i')
		end

feature -- Duplication

	substring (n1, n2: INTEGER): like Current is
			-- Copy of substring containing all characters at indices
			-- between `n1' and `n2'
		local
			other_area: like area
		do
			if (1 <= n1) and (n1 <= n2) and (n2 <= count) then
				create Result.make (n2 - n1 + 1)
				other_area := Result.area;
				($other_area).memory_copy ($area + (n1 - 1), n2 - n1 + 1)
				Result.set_count (n2 - n1 + 1)
			else
				create Result.make (0)
			end
		ensure
			new_result_count: Result.count = n2 - n1 + 1 or Result.count = 0
			-- original_characters: For every `i' in 1..`n2'-`n1', `Result'.`item' (`i') = `item' (`n1'+`i'-1)
		end

	multiply (n: INTEGER) is
			-- Duplicate a string within itself
			-- ("hello").multiply(3) => "hellohellohello"
		require
			meaningful_multiplier: n >= 1
		local
			s: STRING
			i: INTEGER
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
			Result := clone (Current)
		end

feature {STRING_HANDLER} -- Implementation

	frozen set_count (number: INTEGER) is
			-- Set `count' to `number' of characters.
		require
			valid_count: 0 <= number and number <= capacity
		do
			count := number
		ensure
			new_count: count = number
		end

feature {NONE} -- Empty string implementation

	empty_area: SPECIAL [CHARACTER] is
			-- Empty `area' used when calling `make (0)'.
		local
			old_area: like area
		once
			old_area := area
			make_area (1)
			Result := area
			area := old_area
		end

feature {STRING} -- Implementation

	hashcode (c_string: POINTER; len: INTEGER): INTEGER is
			-- Hash code value of `c_string'
		external
			"C use %"eif_tools.h%""
		end

	str_str (c_str, o_str: POINTER; clen, olen, i, fuzzy: INTEGER): INTEGER is
			-- Forward search of `o_str' within `c_str' starting at `i'.
			-- Return the index within `c_str' where the pattern was
			-- located, 0 if not found.
			-- The 'fuzzy' parameter is the maximum allowed number of
			-- mismatches within the pattern. A 0 means an exact match.
		external
			"C use %"eif_eiffel.h%""
		end

	str_len (c_string: POINTER): INTEGER is
			-- Length of the C string: `c_string'
		external
			"C signature (char *): EIF_INTEGER use %"eif_str.h%""
		alias
			"strlen"
		end

	c_p_i: INTEGER is
			-- Number of characters per INTEGER
		obsolete
			"You now have to implement it yourself by inheriting from PLATFORM."
		do
				-- Example of implementation using features from PLATFORM
				-- Result := Integer_bits // Character_bits;
		end

	str_ljustify (c_string: POINTER; length, cap: INTEGER) is
			-- Left justify in a field of `capacity'
			-- the `c_string' of length `length'
		external
			"C signature (EIF_CHARACTER *, EIF_INTEGER, EIF_INTEGER) use %"eif_str.h%""
		end

	str_cjustify (c_string: POINTER; length, cap: INTEGER) is
			-- Center justify in a field of `capacity'
			-- the `c_string' of length `length'
		external
			"C signature (EIF_CHARACTER *, EIF_INTEGER, EIF_INTEGER) use %"eif_str.h%""
		end

	str_rjustify (c_string: POINTER; length, cap: INTEGER) is
			-- Right justify in a field of `capacity'
			-- the `c_string' of length `length'
		external
			"C signature (EIF_CHARACTER *, EIF_INTEGER, EIF_INTEGER) use %"eif_str.h%""
		end

	str_strict_cmp (this, other: POINTER; len: INTEGER): INTEGER is
			-- Compare `this' and `other' C strings 
			-- for the first `len' characters.
			-- 0 if equal, < 0 if `this' < `other',
			-- > 0 if `this' > `other'
		external
			"C signature (char *, char *, size_t): EIF_INTEGER use <string.h>"
		alias
			"strncmp"
		end

	str_atoi (c_string: POINTER; length: INTEGER): INTEGER is
			-- Value of integer in `c_string'
		external
			"C signature (EIF_CHARACTER *, EIF_INTEGER): EIF_INTEGER use %"eif_str.h%""
		end

	str_ator (c_string: POINTER; length: INTEGER): REAL is
			-- Value of real in `c_string'
		external
			"C signature (EIF_CHARACTER *, EIF_INTEGER): EIF_REAL use %"eif_str.h%""
		end

	str_atod (c_string: POINTER; length: INTEGER): DOUBLE is
			-- Value of double in `c_string'
		external
			"C signature (EIF_CHARACTER *, EIF_INTEGER): EIF_DOUBLE use %"eif_str.h%""
		end

	str_isi (c_string: POINTER; length: INTEGER): BOOLEAN is
			-- Is is an integer?
		external
			"C signature (EIF_CHARACTER *, EIF_INTEGER): EIF_BOOLEAN use %"eif_str.h%""
		end

	str_isr (c_string: POINTER; length: INTEGER): BOOLEAN is
			-- Is is a real?
		external
			"C signature (EIF_CHARACTER *, EIF_INTEGER): EIF_BOOLEAN use %"eif_str.h%""
		end

	str_isd (c_string: POINTER; length: INTEGER): BOOLEAN is
			-- Is is a double?
		external
			"C signature (EIF_CHARACTER *, EIF_INTEGER): EIF_BOOLEAN use %"eif_str.h%""
		end

	str_cprepend (c_string: POINTER; c: CHARACTER; length: INTEGER) is
			-- Prepend `c' to `c_string'.
		external
			"C signature (EIF_CHARACTER *, EIF_CHARACTER, EIF_INTEGER) use %"eif_str.h%""
		end

	str_insert (c_string, other_string: POINTER; c_length, other_length,
			position: INTEGER) is
			-- Insert `other_string' into `c_string' at `position'.
			-- Insertion occurs at the left of `position'.
		external
			"C signature (EIF_CHARACTER *, EIF_CHARACTER *, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER) use %"eif_str.h%""
		end

	str_rmchar (c_string: POINTER; length, i: INTEGER) is
			-- Remove `i'-th character from `c_string'.
		external
			"C signature (EIF_CHARACTER *, EIF_INTEGER, EIF_INTEGER) use %"eif_str.h%""
		end

	str_replace (c_string, other_string: POINTER; c_length, other_length,
			star_post, end_pos: INTEGER) is
			-- Replace substring (`start_pos', `end_pos') from `c_string'
			-- by `other_string'.
		external
			"C signature (EIF_CHARACTER *, EIF_CHARACTER *, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER) use %"eif_str.h%""
		end

	str_rmall (c_string: POINTER; c: CHARACTER; length: INTEGER): INTEGER is
			-- Remove all occurrences of `c' in `c_string'.
			-- Return new number of character making up `c_string'
		external
			"C signature (EIF_CHARACTER *, EIF_CHARACTER, EIF_INTEGER): EIF_INTEGER use %"eif_str.h%""
		end

	str_left (c_string: POINTER; length: INTEGER): INTEGER is
			-- Remove all leading whitespace from `c_string'.
			-- Return the new number of characters making `c_string'
		external
			"C signature (EIF_CHARACTER *, EIF_INTEGER): EIF_INTEGER use %"eif_str.h%""
		end

	str_right (c_string: POINTER; length: INTEGER): INTEGER is
			-- Remove all trailing whitespace from `c_string'.
			-- Return the new number of characters making `c_string'
		external
			"C signature (EIF_CHARACTER *, EIF_INTEGER): EIF_INTEGER use %"eif_str.h%""
		end

	str_resize (a: POINTER; newsize: INTEGER): like area is
			-- Area which can accomodate
			-- at least `newsize' characters
		external
			"C use %"eif_malloc.h%""
		alias
			"sprealloc"
		end

	spsubcopy (source, target: POINTER; s, e, i: INTEGER) is
			-- Copy characters of `source' within bounds `s'
			-- and `e' to `target' starting at index `i'.
		external
			"C use %"eif_copy.h%""
		end

invariant
	extendible: extendible
	compare_character: not object_comparison
	index_set_has_same_count: index_set.count = count

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class STRING



