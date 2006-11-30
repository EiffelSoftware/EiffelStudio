indexing
	description: "[
		Sequences of characters, accessible through integer indices
		in a contiguous range.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_8

inherit
	STRING_GENERAL
		redefine
			copy, is_equal, out
		end

	INDEXABLE [CHARACTER, INTEGER]
		rename
			item as item
		redefine
			copy, is_equal, out, prune_all,
			changeable_comparison_criterion
		end

	RESIZABLE [CHARACTER]
		redefine
			copy, is_equal, out,
			changeable_comparison_criterion
		end

	$PARENT

	MISMATCH_CORRECTOR
		redefine
			copy, is_equal, out, correct_mismatch
		end

create
	make,
	make_empty,
	make_filled,
	make_from_string,
	make_from_c,
	make_from_cil

convert
	to_cil: {SYSTEM_STRING},
	as_string_32: {STRING_32},
	make_from_cil ({SYSTEM_STRING})

feature -- Initialization

	make (n: INTEGER) is
			-- Allocate space for at least `n' characters.
		do
		end

	make_empty is
			-- Create empty string.
		do
		end

	make_filled (c: CHARACTER; n: INTEGER) is
			-- Create string of length `n' filled with `c'.
		do
		end

	make_from_string (s: STRING) is
			-- Initialize from the characters of `s'.
			-- (Useful in proper descendants of class STRING,
			-- to initialize a string-like object from a manifest string.)
		do
		end

	make_from_c (c_string: POINTER) is
			-- Initialize from contents of `c_string',
			-- a string created by some C function
		do
		end

	make_from_cil (a_system_string: SYSTEM_STRING) is
			-- Initialize Current with `a_system_string'.
		do
		end

	from_c (c_string: POINTER) is
			-- Reset contents of string from contents of `c_string',
			-- a string created by some C function.
		do
		end

	from_c_substring (c_string: POINTER; start_pos, end_pos: INTEGER) is
			-- Reset contents of string from substring of `c_string',
			-- a string created by some C function.
		do
		end

	adapt (s: STRING): like Current is
			-- Object of a type conforming to the type of `s',
			-- initialized with attributes from `s'
		do
		end

	remake (n: INTEGER) is
			-- Allocate space for at least `n' characters.
		obsolete
			"Use `make' instead"
		do
		end

feature -- Access

	item, infix "@" (i: INTEGER): CHARACTER assign put is
			-- Character at position `i'
		do
		end

	code (i: INTEGER): NATURAL_32 is
			-- Numeric code of character at position `i'
		do
		end

	item_code (i: INTEGER): INTEGER is
			-- Numeric code of character at position `i'
		do
		end

	hash_code: INTEGER is
			-- Hash code value
		do
		end

	false_constant: STRING is "false"
			-- Constant string "false"

	true_constant: STRING is "true"
			-- Constant string "true"

	shared_with (other: STRING): BOOLEAN is
			-- Does string share the text of `other'?
		do
		end

	index_of (c: CHARACTER; start_index: INTEGER): INTEGER is
			-- Position of first occurrence of `c' at or after `start_index';
			-- 0 if none.
		do
		end

	last_index_of (c: CHARACTER; start_index_from_end: INTEGER): INTEGER is
			-- Position of last occurrence of `c'.
			-- 0 if none
		do
		end

	substring_index_in_bounds (other: STRING; start_pos, end_pos: INTEGER): INTEGER is
			-- Position of first occurrence of `other' at or after `start_pos'
			-- and to or before `end_pos';
			-- 0 if none.
		do
		end

	string: STRING is
			-- New STRING having same character sequence as `Current'.
		do
		end

	substring_index (other: STRING; start_index: INTEGER): INTEGER is
			-- Index of first occurrence of other at or after start_index;
			-- 0 if none
		do
		end

	fuzzy_index (other: STRING; start: INTEGER; fuzz: INTEGER): INTEGER is
			-- Position of first occurrence of `other' at or after `start'
			-- with 0..`fuzz' mismatches between the string and `other'.
			-- 0 if there are no fuzzy matches
		do
		end

feature -- Measurement

	capacity: INTEGER is
			-- Allocated space
		do
		end

	count: INTEGER
			-- Actual number of characters making up the string

	occurrences (c: CHARACTER): INTEGER is
			-- Number of times `c' appears in the string
		do
		end

	index_set: INTEGER_INTERVAL is
			-- Range of acceptable indexes
		do
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is string made of same character sequence as `other'
			-- (possibly with a different capacity)?
		do
		end

	is_case_insensitive_equal (other: like Current): BOOLEAN is
			-- Is string made of same character sequence as `other' regardless of casing
			-- (possibly with a different capacity)?
		do
		end

	same_string (other: STRING): BOOLEAN is
			-- Do `Current' and `other' have same character sequence?
		do
		end

	infix "<" (other: like Current): BOOLEAN is
			-- Is string lexicographically lower than `other'?
		do
		end

feature -- Status report

	is_string_8: BOOLEAN is True
			-- Current is not a STRING_8 instance

	is_string_32: BOOLEAN is False
			-- Current is a STRING_32 instance

	is_valid_as_string_8: BOOLEAN is True
			-- Is `Current' convertible to STRING_8 without information loss?

	has (c: CHARACTER): BOOLEAN is
			-- Does string include `c'?
		do
		end

	has_substring (other: STRING): BOOLEAN is
			-- Does `Current' contain `other'?
		do
		end

	extendible: BOOLEAN is True
			-- May new items be added? (Answer: yes.)

	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
		do
		end

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' within the bounds of the string?
		do
		end

	valid_code (v: NATURAL_32): BOOLEAN is
			-- Is `v' a valid code for a CHARACTER_32?
		do
		end

	changeable_comparison_criterion: BOOLEAN is False

	is_number_sequence: BOOLEAN is
			-- Does `Current' represent a number sequence?
		do
		end

	is_real: BOOLEAN is
			-- Does `Current' represent a REAL?
		do
		end

	is_double: BOOLEAN is
			-- Does `Current' represent a DOUBLE?
		do
		end

	is_boolean: BOOLEAN is
			-- Does `Current' represent a BOOLEAN?
		do
		end

	is_integer_8: BOOLEAN is
			-- Does `Current' represent an INTEGER_8?
		do
		end

	is_integer_16: BOOLEAN is
			-- Does `Current' represent an INTEGER_16?
		do
		end

	is_integer, is_integer_32: BOOLEAN is
			-- Does `Current' represent an INTEGER?
		do
		end

	is_integer_64: BOOLEAN is
			-- Does `Current' represent an INTEGER_64?
		do
		end

	is_natural_8: BOOLEAN is
			-- Does `Current' represent a NATURAL_8?
		do
		end

	is_natural_16: BOOLEAN is
			-- Does `Current' represent a NATURAL_16?
		do
		end

	is_natural, is_natural_32: BOOLEAN is
			-- Does `Current' represent a NATURAL_32?
		do
		end

	is_natural_64: BOOLEAN is
			-- Does `Current' represent a NATURAL_64?
		do
		end

feature -- Element change

	set (t: like Current; n1, n2: INTEGER) is
			-- Set current string to substring of `t' from indices `n1'
			-- to `n2', or to empty string if no such substring.
		do
		end

	copy (other: like Current) is
			-- Reinitialize by copying the characters of `other'.
			-- (This is also used by `twin'.)
		do
		end

	subcopy (other: like Current; start_pos, end_pos, index_pos: INTEGER) is
			-- Copy characters of `other' within bounds `start_pos' and
			-- `end_pos' to current string starting at index `index_pos'.
		do
		end

	replace_substring (s: STRING; start_index, end_index: INTEGER) is
			-- Replace characters from `start_index' to `end_index' with `s'.
		do
		end

	replace_substring_all (original, new: like Current) is
			-- Replace every occurrence of `original' with `new'.
		do
		end

	replace_blank is
			-- Replace all current characters with blanks.
		do
		end

	fill_blank is
			-- Fill with `capacity' blank characters.
		do
		end

	fill_with (c: CHARACTER) is
			-- Replace every character with `c'.
		do
		end

	replace_character (c: CHARACTER) is
			-- Replace every character with `c'.
		do
		end

	fill_character (c: CHARACTER) is
			-- Fill with `capacity' characters all equal to `c'.
		do
		end

	head (n: INTEGER) is
			-- Remove all characters except for the first `n';
			-- do nothing if `n' >= `count'.
		do
		end

	keep_head (n: INTEGER) is
			-- Remove all characters except for the first `n';
			-- do nothing if `n' >= `count'.
		do
		end

	tail (n: INTEGER) is
			-- Remove all characters except for the last `n';
			-- do nothing if `n' >= `count'.
		do
		end

	keep_tail (n: INTEGER) is
			-- Remove all characters except for the last `n';
			-- do nothing if `n' >= `count'.
		do
		end

	left_adjust is
			-- Remove leading whitespace.
		do
		end

	right_adjust is
			-- Remove trailing whitespace.
		do
		end

	share (other: STRING) is
			-- Make current string share the text of `other'.
			-- Subsequent changes to the characters of current string
			-- will also affect `other', and conversely.
		do
		end

	put (c: CHARACTER; i: INTEGER) is
			-- Replace character at position `i' by `c'.
		do
		end

	put_code (v: NATURAL_32; i: INTEGER) is
			-- Replace character at position `i' by character of code `v'.
		do
		end

	precede, prepend_character (c: CHARACTER) is
			-- Add `c' at front.
		do
		end

	prepend (s: STRING) is
			-- Prepend a copy of `s' at front.
		do
		end

	prepend_boolean (b: BOOLEAN) is
			-- Prepend the string representation of `b' at front.
		do
		end

	prepend_double (d: DOUBLE) is
			-- Prepend the string representation of `d' at front.
		do
		end

	prepend_integer (i: INTEGER) is
			-- Prepend the string representation of `i' at front.
		do
		end

	prepend_real (r: REAL) is
			-- Prepend the string representation of `r' at front.
		do
		end

	prepend_string (s: STRING) is
			-- Prepend a copy of `s', if not void, at front.
		do
		end

	append (s: STRING) is
			-- Append a copy of `s' at end.
		do
		end

	infix "+" (s: STRING): like Current is
			-- Append a copy of 's' at the end of a copy of Current,
			-- Then return the Result.
		do
		end

	append_string (s: STRING) is
			-- Append a copy of `s', if not void, at end.
		do
		end

	append_integer (i: INTEGER) is
			-- Append the string representation of `i' at end.
		do
		end

	append_real (r: REAL) is
			-- Append the string representation of `r' at end.
		do
		end

	append_double (d: DOUBLE) is
			-- Append the string representation of `d' at end.
		do
		end

	append_character, extend (c: CHARACTER) is
			-- Append `c' at end.
		do
		end

	append_boolean (b: BOOLEAN) is
			-- Append the string representation of `b' at end.
		do
		end

	insert (s: STRING; i: INTEGER) is
			-- Add `s' to left of position `i' in current string.
		do
		end

	insert_string (s: STRING; i: INTEGER) is
			-- Insert `s' at index `i', shifting characters between ranks
			-- `i' and `count' rightwards.
		do
		end

	insert_character (c: CHARACTER; i: INTEGER) is
			-- Insert `c' at index `i', shifting characters between ranks
			-- `i' and `count' rightwards.
		do
		end

feature -- Removal

	remove (i: INTEGER) is
			-- Remove `i'-th character.
		do
		end

	remove_head (n: INTEGER) is
			-- Remove first `n' characters;
			-- if `n' > `count', remove all.
		do
		end

	remove_substring (start_index, end_index: INTEGER) is
			-- Remove all characters from `start_index'
			-- to `end_index' inclusive.
		do
		end

	remove_tail (n: INTEGER) is
			-- Remove last `n' characters;
			-- if `n' > `count', remove all.
		do
		end

	prune (c: CHARACTER) is
			-- Remove first occurrence of `c', if any.
		do
		end

	prune_all (c: CHARACTER) is
			-- Remove all occurrences of `c'.
		do
		end

	prune_all_leading (c: CHARACTER) is
			-- Remove all leading occurrences of `c'.
		do
		end

	prune_all_trailing (c: CHARACTER) is
			-- Remove all trailing occurrences of `c'.
		do
		end

	wipe_out is
			-- Remove all characters.
		do
		end

	clear_all is
			-- Reset all characters.
		do
		end

feature -- Resizing

	adapt_size is
			-- Adapt the size to accommodate `count' characters.
		do
		end

	resize (newsize: INTEGER) is
			-- Rearrange string so that it can accommodate
			-- at least `newsize' characters.
			-- Do not lose any previously entered character.
		do
		end

	grow (newsize: INTEGER) is
			-- Ensure that the capacity is at least `newsize'.
		do
		end

feature -- Conversion

	as_lower: like Current is
			-- New object with all letters in lower case.
		do
		end

	as_upper: like Current is
			-- New object with all letters in upper case
		do
		end

	left_justify is
			-- Left justify Current using `count' as witdth.
		do
		end

	center_justify is
			-- Center justify Current using `count' as width.
		do
		end

	right_justify is
			-- Right justify Current using `count' as width.
		do
		end

	character_justify (pivot: CHARACTER; position: INTEGER) is
			-- Justify a string based on a `pivot'
			-- and the `position' it needs to be in
			-- the final string.
			-- This will grow the string if necessary
			-- to get the pivot in the correct place.
		do
		end

	to_lower is
			-- Convert to lower case.
		do
		end

	to_upper is
			-- Convert to upper case.
		do
		end

	to_integer_8: INTEGER_8 is
			-- 8-bit integer value
		do
		end

	to_integer_16: INTEGER_16 is
			-- 16-bit integer value
		do
		end

	to_integer, to_integer_32: INTEGER is
			-- 32-bit integer value
		do
		end

	to_integer_64: INTEGER_64 is
			-- 64-bit integer value
		do
		end

	to_natural_8: NATURAL_8 is
			-- 8-bit natural value
		do
		end

	to_natural_16: NATURAL_16 is
			-- 16-bit natural value
		do
		end

	to_natural, to_natural_32: NATURAL_32 is
			-- 32-bit natural value
		do
		end

	to_natural_64: NATURAL_64 is
			-- 64-bit natural value
		do
		end

	to_real: REAL is
			-- Real value;
			-- for example, when applied to "123.0", will yield 123.0
		do
		end

	to_double: DOUBLE is
			-- "Double" value;
			-- for example, when applied to "123.0", will yield 123.0 (double)
		do
		end

	to_boolean: BOOLEAN is
			-- Boolean value;
			-- "True" yields `True', "False" yields `False'
			-- (case-insensitive)
		do
		end

	linear_representation: LINEAR [CHARACTER] is
			-- Representation as a linear structure
		do
		end

	split (a_separator: CHARACTER): LIST [STRING] is
			-- Split on `a_separator'.
		do
		end

	frozen to_c: ANY is
			-- A reference to a C form of current string.
			-- Useful only for interfacing with C software.
		do
		end

	mirrored: like Current is
			-- Mirror image of string;
			-- Result for "Hello world" is "dlrow olleH".
		do
		end

	mirror is
			-- Reverse the order of characters.
			-- "Hello world" -> "dlrow olleH".
		do
		end

feature -- Duplication

	substring (start_index, end_index: INTEGER): like Current is
			-- Copy of substring containing all characters at indices
			-- between `start_index' and `end_index'
		do
		end

	multiply (n: INTEGER) is
			-- Duplicate a string within itself
			-- ("hello").multiply(3) => "hellohellohello"
		do
		end

feature -- Output

	out: STRING is
			-- Printable representation
		do
		end

feature {STRING_HANDLER} -- Implementation

	frozen set_count (number: INTEGER) is
			-- Set `count' to `number' of characters.
		do
		end

feature {NONE} -- Empty string implementation

	$ATTRIBUTE
			-- Computed hash-code.

	frozen set_internal_hash_code (v: INTEGER) is
			-- Set `internal_hash_code' with `v'.
		do
		end

feature {NONE} -- Implementation

	new_string (n: INTEGER): like Current is
			-- New instance of current with space for at least `n' characters.
		do
		end

feature {NONE} -- Transformation

	correct_mismatch is
			-- Attempt to correct object mismatch during retrieve using `mismatch_information'.
		do
		end

invariant
	extendible: extendible
	compare_character: not object_comparison
	index_set_has_same_count: index_set.count = count

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
--| Copyright (c) 1993-2006 University of Southern California and contributors.
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
