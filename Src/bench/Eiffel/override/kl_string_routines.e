indexing

	description:

		"Routines that ought to be in class STRING"

	note:

		"Unless otherwise specified in their preconditions, %
		%the features of this class can deal with UC_STRING %
		%whenever a STRING is expected."

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 1999-2002, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class KL_STRING_ROUTINES

inherit

	KL_SHARED_PLATFORM

	KL_IMPORTED_CHARACTER_ROUTINES
	UC_IMPORTED_UNICODE_ROUTINES

feature -- Initialization

	make (n: INTEGER): STRING is
			-- Create an empty string. Try to allocate space
			-- for at least `n' characters.
			-- (ELKS 2001 STRING)
			-- Note: This routine should be made obsolete as soon
			-- as VE implements it correctly, which is not the case
			-- as of VE 4.0.
		require
			non_negative_n: n >= 0
		do



			create Result.make (n)

		ensure
			string_not_void: Result /= Void
			string_type: Result.same_type ("")
			empty_string: Result.count = 0
		end

	make_from_string (s: STRING): STRING is
			-- Initialize from the character sequence of `s'.
			-- `s' is considered with its characters which do not fit
			-- in a CHARACTER replaced by a '%U'.
			-- (ELKS 2001 STRING)
			-- Note: Use this routine instead of 'STRING.make_from_string (s)'
			-- when `s' is of dynamic type other than STRING (e.g. UC_STRING)
			-- because the class STRING provided with the Eiffel compilers
			-- is not necessarily aware of the implementation of UC_STRING
			-- and this may lead to run-time errors or crashes.
		require
			s_not_void: s /= Void
		local
			i, j, nb: INTEGER
			uc_string: UC_STRING
		do












































			nb := s.count
			create Result.make (nb)
			uc_string ?= s
			if uc_string /= Void then
				nb := uc_string.byte_count
				from j := 1 until j > nb loop
					Result.append_character (uc_string.character_item_at_byte_index (j))
					j := uc_string.next_byte_index (j)
				end
			else
				from i := 1 until i > nb loop
					Result.append_character (s.item (i))
					i := i + 1
				end
			end

		ensure
			string_not_void: Result /= Void
			new_string: Result /= s
			string_type: Result.same_type ("")
			initialized: elks_same_string (Result, s)
		end

	make_empty: STRING is
			-- Create empty string.
			-- (ELKS 2001 STRING)
			-- Note: This routine should be made obsolete as soon
			-- as it is supported by ISE and HACT, which is not the
			-- case in ISE 5.1.14 and HACT 4.0.1.
		do
			Result := make (0)
		ensure
			string_not_void: Result /= Void
			string_type: Result.same_type ("")
			empty: Result.count = 0
		end

	make_filled (c: CHARACTER; n: INTEGER): STRING is
			-- Create string of length `n' filled with `c'.
			-- (ELKS 2001 STRING)
			-- Note: This routine should be made obsolete as soon
			-- as it is supported by ISE and HACT, which is not the
			-- case in ISE 5.1.14 and HACT 4.0.1.
		require
			valid_count: n >= 0
		do

			create Result.make_filled (c, n)





		ensure
			string_not_void: Result /= Void
			string_type: Result.same_type ("")
			count_set: Result.count = n
			filled: Result.occurrences (c) = Result.count
		end

	make_buffer (n: INTEGER): STRING is
			-- Create a new string containing `n' characters.
		require
			non_negative_n: n >= 0
		do

			create Result.make_filled ('%U', n)








		ensure
			string_not_void: Result /= Void
			string_type: Result.same_type ("")
			count_set: Result.count = n
		end

feature -- Status report

	has_substring (a_string, other: STRING): BOOLEAN is
			-- Does `a_string' contain `other'? `a_string' and `other'
			-- are considered with their characters which do not fit
			-- in a CHARACTER replaced by a '%U'.
			-- (Extended from ELKS 2001 STRING)
			-- Note: Use this feature instead of 'a_string.has_substring
			-- (other)' when `a_string' can be of dynamic type STRING and
			-- `other' of dynamic type other than STRING such as UC_STRING,
			-- because class STRING provided by the Eiffel compilers is
			-- not necessarily aware of the implementation of UC_STRING
			-- and this may lead to run-time errors or crashes.
		require
			a_string_not_void: a_string /= Void
			other_not_void: other /= Void
		do
			Result := substring_index (a_string, other, 1) /= 0
		ensure
			false_if_too_small: a_string.count < other.count implies not Result
			true_if_initial: (a_string.count >= other.count and then
				elks_same_string (other, substring (a_string, 1, other.count))) implies Result
			recurse: (a_string.count >= other.count and then
				not elks_same_string (other, substring (a_string, 1, other.count))) implies
				(Result = has_substring (substring (a_string, 2, a_string.count), other))
		end

	is_integer (a_string: STRING): BOOLEAN is
			-- Is `a_string' only made up of digits?
		require
			a_string_not_void: a_string /= Void
		local
			i, nb: INTEGER
			c: CHARACTER
		do
			nb := a_string.count
			if nb = 0 then
				Result := False
			else
				Result := True
				from i := 1 until i > nb loop
					c := a_string.item (i)
					if c < '0' or c > '9' then
						Result := False
						i := nb + 1 -- Jump out of the loop.
					else
						i := i + 1
					end
				end
			end
		end

	is_hexadecimal (a_string: STRING): BOOLEAN is
			-- Is a string made up of digits or
			-- A-F or a-f?
		require
			a_string_not_void: a_string /= Void
		local
			i, nb: INTEGER
			c: CHARACTER
		do
			nb := a_string.count
			if nb = 0 then
				Result := False
			else
				Result := True
				from i := 1 until i > nb loop
					c := a_string.item (i)
					if (c < '0' or c > '9') and (c < 'a' or c > 'f') and (c < 'A' or c > 'F') then
						Result := False
						i := nb + 1 -- Jump out pf the loop.
					else
						i := i + 1
					end
				end
			end
		end

feature -- Access

	new_empty_string (a_string: STRING; n: INTEGER): STRING is
			-- New empty string with same dynamic type as `a_string';
			-- Try to allocate space for at least `n' characters.
		require
			a_string_not_void: a_string /= Void
			non_negative_n: n >= 0
		local
			uc_string: UC_STRING
		do
			if a_string.same_type (dummy_string) then
				Result := make (n)
			else
				uc_string ?= a_string
				if uc_string /= Void then
					Result := uc_string.new_empty_string (n)
				else
					Result := clone (a_string)
					Result.wipe_out
				end
			end
		ensure
			new_string_not_void: Result /= Void
			same_type: Result.same_type (a_string)
			new_string_empty: Result.count = 0
		end

	string (a_string: STRING): STRING is
			-- New STRING having the same character sequence as `a_string'
			-- where characters which do not fit in a CHARACTER are
			-- replaced by a '%U'
			-- (Extended from ELKS 2001 STRING)
			-- Note: This routine should be made obsolete as soon
			-- as it is supported by ISE and HACT, which is not the
			-- case in ISE 5.1.14 and HACT 4.0.1.
		require
			a_string_not_void: a_string /= Void
		do
			Result := a_string.string
		ensure
			string_not_void: Result /= Void
			string_type: Result.same_type ("")
			first_item: a_string.count > 0 implies Result.item (1) = a_string.item (1)
			recurse: a_string.count > 1 implies substring (Result, 2, a_string.count).is_equal (string (substring (a_string, 2, a_string.count)))
		end

	substring (a_string: STRING; start_index, end_index: INTEGER): STRING is
			-- New object containing all characters of `a_string'
			-- from `start_index' to `end_index' inclusive
			-- (ELKS 2001 STRING)
			-- Note: This routine should be made obsolete as soon
			-- as HACT supports empty substrings, which is not yet
			-- the case as of HACT 4.0.1.
		require
			a_string_not_void: a_string /= Void
			valid_start_index: 1 <= start_index
			valid_end_index: end_index <= a_string.count
			meaningful_interval: start_index <= end_index + 1


















		do
			Result := a_string.substring (start_index, end_index)

		ensure
			substring_not_void: Result /= Void
			substring_same_type: Result.same_type (a_string)
			substring_count: Result.count = end_index - start_index + 1
			first_item: Result.count > 0 implies Result.item (1) = a_string.item (start_index)
			-- Note: Too time and memory consumming with SE -0.74:
			-- recurse: Result.count > 0 implies substring (Result, 2, Result.count).is_equal
			--	(substring (a_string, start_index + 1, end_index))
		end

	substring_index (a_string, other: STRING; start_index: INTEGER): INTEGER is
			-- Index of first occurrence of `other' at or after `start_index' in
			-- `a_string'; 0 if none. `a_string' and `other' are considered with
			-- their characters which do not fit in a CHARACTER replaced by a '%U'.
			-- (ELKS 2001 STRING)
			-- Note: Use this feature instead of 'a_string.substring_index (other,
			-- start_index)' when `a_string' can be of dynamic type STRING and
			-- `other' of dynamic type other than STRING such as UC_STRING, because
			-- class STRING provided by the Eiffel compilers is not necessarily
			-- aware of the implementation of UC_STRING and this may lead to
			-- run-time errors or crashes.
		require
			a_string_not_void: a_string /= Void
			other_not_void: other /= Void
			valid_start_index: start_index >= 1 and start_index <= a_string.count + 1
		local
			i, j, nb: INTEGER
			a_code: INTEGER
			other_unicode: UC_STRING
			k, end_index: INTEGER
			found: BOOLEAN
			uc_string: UC_STRING
			max_code: INTEGER
		do
				-- Note: ISE Eiffel 5.1 is more constraining than ELKS 2001:
				-- other_not_empty: other.count > 0
				-- start_index_large_enough: start_index >= 1
				-- start_index_small_enough: start_index <= a_string.count
				-- Fixed in ISE 5.2.
			if other.count = 0 then
				Result := start_index
			elseif start_index = a_string.count + 1 then
				Result := 0
			elseif a_string.same_type (dummy_string) then
				if other.same_type (dummy_string) then
					Result := a_string.substring_index (other, start_index)
				else
					end_index := a_string.count - other.count + 1
					if start_index <= end_index then
						other_unicode ?= other
						if other_unicode /= Void then
							nb := other_unicode.byte_count
							max_code := Platform.Maximum_character_code
							from k := start_index until k > end_index loop
								j := k
								found := True
								from i := 1 until i > nb loop
									a_code := other_unicode.item_code_at_byte_index (i)
									if a_code > max_code then
										a_code := 0
									end
									if a_string.item_code (j) /= a_code then
										found := False
										i := nb + 1 -- Jump out of the loop.
									else
										j := j + 1
										i := other_unicode.next_byte_index (i)
									end
								end
								if found then
									Result := k
									k := end_index + 1 -- Jump out of the loop.
								else
									k := k + 1
								end
							end
						else
							nb := other.count
							from k := start_index until k > end_index loop
								j := k
								found := True
								from i := 1 until i > nb loop
									if a_string.item (j) /= other.item (i) then
										found := False
										i := nb + 1 -- Jump out of the loop.
									else
										j := j + 1
										i := i + 1
									end
								end
								if found then
									Result := k
									k := end_index + 1 -- Jump out of the loop.
								else
									k := k + 1
								end
							end
						end
					end
				end
			else
				uc_string ?= a_string
				if uc_string /= Void then
					Result := uc_string.substring_index (other, start_index)
				else
					Result := a_string.substring_index (other, start_index)
				end
			end
		ensure
			valid_result: Result = 0 or else (start_index <= Result and Result <= a_string.count - other.count + 1)
			zero_if_absent: (Result = 0) = not has_substring (substring (a_string, start_index, a_string.count), other)
			at_this_index: Result >= start_index implies elks_same_string (other, substring (a_string, Result, Result + other.count - 1))
			none_before: Result > start_index implies not
				has_substring (substring (a_string, start_index, Result + other.count - 2), other)
		end

	case_insensitive_hash_code (a_string: STRING): INTEGER is
			-- Hash code value of `a_string' which doesn't
			-- take case sensitivity into account
		require
			a_string_not_void: a_string /= Void
		local
			i, nb: INTEGER
			a_string_count: INTEGER
		do
			a_string_count := a_string.count
			if a_string_count > 5 then

				Result := a_string_count * a_string.item (a_string_count).lower.code







				nb := 5
			else
				nb := a_string_count
			end
			from i := 1 until i > nb loop

				Result := Result + a_string.item (i).lower.code







				i := i + 1
			end
			Result := Result * a_string_count
			if Result < 0 then
				Result := - (Result + 1)
			end
		ensure
			hash_code_positive: Result >= 0
		end

	concat (a_string, other: STRING): STRING is
			-- New object which contains the characters of `a_string'
			-- followed by the characters of `other'; If `other' is
			-- of dynamic type UC_STRING or one of its descendants and
			-- `a_string' is not, then the dynamic type of the result
			-- is the same as the dynamic type of `other'. Otherwise
			-- the result is similar to 'a_string + other';
			-- Note: Use this routine instead of 'a_string + other' or
			-- 'a_string.append_string (other)' when `a_string'
			-- can be of dynamic type STRING and `other' of dynamic
			-- type other than STRING such as UC_STRING, because class
			-- STRING provided by the Eiffel compilers is not necessarily
			-- aware of the implementation of UC_STRING and this may
			-- lead to run-time errors or crashes.
		require
			a_string_not_void: a_string /= Void
			other_not_void: other /= Void
		local
			uc_string: UC_STRING
		do
			uc_string ?= a_string
			if uc_string /= Void then
				Result := uc_string + other
			else
				uc_string ?= other
				if uc_string /= Void then
					Result := uc_string.prefixed_string (a_string)
				else
					Result := a_string + other
				end
			end
		ensure
			concat_not_void: Result /= Void
			concat_count: Result.count = a_string.count + other.count
			initial: same_string (substring (Result, 1, a_string.count), a_string)
			final: same_string (substring (Result, a_string.count + 1, Result.count), other)
		end

feature -- Comparison

	elks_same_string (a_string, other: STRING): BOOLEAN is
			-- Do `a_string' and `other' have the same character sequence?
			-- `a_string' and `other' are considered with their characters
			-- which do not fit in a CHARACTER replaced by a '%U'.
			-- (Extended from ELKS 2001 STRING)
			-- Note: Use this feature instead of 'a_string.same_string
			-- (other)' when `a_string' can be of dynamic type STRING and
			-- `other' of dynamic type other than STRING such as UC_STRING,
			-- because class STRING provided by the Eiffel compilers is
			-- not necessarily aware of the implementation of UC_STRING
			-- and this may lead to run-time errors or crashes.
		require
			a_string_not_void: a_string /= Void
			other_not_void: other /= Void
		do
			if other = a_string then
				Result := True
			elseif other.count = a_string.count then
				Result := (substring_index (a_string, other, 1) = 1)
			end
		ensure
			definition: Result = string (a_string).is_equal (string (other))
		end

	same_string (a_string, other: STRING): BOOLEAN is
			-- Do `a_string' and `other' have the same unicode character sequence?
			-- Note: the difference with `elks_same_string' is that here the
			-- implementation uses STRING.item_code instead of STRING.item
			-- and hence characters which have different codes are not
			-- considered equal even if they do not fit into a CHARACTER.
		require
			a_string_not_void: a_string /= Void
			other_not_void: other /= Void
		local
			uc_string: UC_STRING
			i, nb: INTEGER
		do
			if other = a_string then
				Result := True
			elseif other.count = a_string.count then
				uc_string ?= a_string
				if uc_string /= Void then
					Result := uc_string.same_unicode_string (other)
				else
					uc_string ?= other
					if uc_string /= Void then
						Result := uc_string.same_unicode_string (a_string)
					elseif a_string.same_type (dummy_string) and other.same_type (dummy_string) then
						Result := elks_same_string (a_string, other)
					else
						Result := True
						nb := a_string.count
						from i := 1 until i > nb loop
							if a_string.item_code (i) /= other.item_code (i) then
								Result := False
								i := nb + 1 -- Jump out of the loop.
							else
								i := i + 1
							end
						end
					end
				end
			end
		ensure
			definition: Result = (a_string.count = other.count and then
				(a_string.count > 0 implies (a_string.item_code (1) = other.item_code (1) and
				(a_string.count >= 2 implies same_string (substring (a_string, 2, a_string.count), substring (other, 2, a_string.count))))))
			elks_same_string: Result implies elks_same_string (a_string, other)
		end

	same_case_insensitive (s1, s2: STRING): BOOLEAN is
			-- Are `s1' and `s2' made up of the same
			-- characters (case insensitive)?
		require
			s1_not_void: s1 /= Void
			s2_not_void: s2 /= Void
		local
			c1, c2: CHARACTER
			a_code1, a_code2: INTEGER
			i, nb: INTEGER
		do
			if s1 = s2 then
				Result := True
			elseif s1.count = s2.count then
				nb := s1.count
				Result := True
				if not (s1.same_type (dummy_string) and s2.same_type (dummy_string)) then
					from i := 1 until i > nb loop
						a_code1 := s1.item_code (i)
						a_code2 := s2.item_code (i)
						if a_code1 = a_code2 then
							i := i + 1
						elseif unicode.lower_code (a_code1) = unicode.lower_code (a_code2) then
							i := i + 1
						else
							Result := False
							i := nb + 1  -- Jump out of the loop
						end
					end
				else
					from i := 1 until i > nb loop
						c1 := s1.item (i)
						c2 := s2.item (i)
						if c1 = c2 then
							i := i + 1

						elseif c1.lower = c2.lower then







							i := i + 1
						else
							Result := False
							i := nb + 1  -- Jump out of the loop
						end
					end
				end
			end
		end

feature -- Element change

	appended_string (a_string, other: STRING): STRING is
			-- If the dynamic type of `other' is UC_STRING or one of
			-- its descendants and `a_string' is not, then return a
			-- new object with the same dynamic type as `other' and
			-- which contains the characters of `a_string' followed
			-- by the characters of `other'. Otherwise append the
			-- characters of `other' to `a_string' and return `a_string'.
			-- Note: Use this routine instead of 'a_string.append_string (other)'
			-- when `a_string' can be of dynamic type STRING and `other'
			-- of dynamic type other than STRING such as UC_STRING, because
			-- class STRING provided by the Eiffel compilers is not necessarily
			-- aware of the implementation of UC_STRING and this may
			-- lead to run-time errors or crashes.
		require
			a_string_not_void: a_string /= Void
			other_not_void: other /= Void
		local
			uc_string: UC_STRING
		do
			uc_string ?= a_string
			if uc_string /= Void then
				uc_string.append_string (other)
				Result := uc_string
			else
				uc_string ?= other
				if uc_string /= Void then
					Result := concat (a_string, other)
				else
					a_string.append_string (other)
					Result := a_string
				end
			end
		ensure
			append_not_void: Result /= Void
			type_if_not_aliased: Result /= a_string implies Result.same_type (other)
			new_count: Result.count = old a_string.count + old other.count
			initial: same_string (substring (Result, 1, old a_string.count), old clone (a_string))
			final: same_string (substring (Result, old a_string.count + 1, Result.count), old clone (other))
		end

	appended_substring (a_string, other: STRING; s, e: INTEGER): STRING is
			-- If the dynamic type of `other' is UC_STRING or one of
			-- its descendants and `a_string' is not, then return a
			-- new object with the same dynamic type as `other' and
			-- which contains the characters of `a_string' followed by
			-- the characters of `other' between indexes `s' and `e'.
			-- Otherwise append the characters of `other' between `s'
			-- and `e' to `a_string' and return `a_string'.
			-- Note: Use this routine instead of 'a_string.append_string
			-- (other.substring (s, e)' when `a_string' can be of dynamic
			-- type STRING and `other' of dynamic type other than STRING
			-- such as UC_STRING, because class STRING provided by the
			-- Eiffel compilers is not necessarily aware of the
			-- implementation of UC_STRING and this may lead to run-time
			-- errors or crashes.
		require
			a_string_not_void: a_string /= Void
			other_not_void: other /= Void
			s_large_enough: s >= 1
			e_small_enough: e <= other.count
			valid_interval: s <= e + 1
		local
			uc_string: UC_STRING
			i: INTEGER
		do
			uc_string ?= a_string
			if uc_string /= Void then
				uc_string.append_substring (other, s, e)
				Result := uc_string
			else
				uc_string ?= other
				if uc_string /= Void then
					uc_string := uc_string.new_empty_string (a_string.count + e - s + 1)
					uc_string.append_string (a_string)
					uc_string.append_substring (other, s, e)
					Result := uc_string
				else
					from i := s until i > e loop
						a_string.append_character (other.item (i))
						i := i + 1
					end
					Result := a_string
				end
			end
		ensure
			append_not_void: Result /= Void
			type_if_not_aliased: Result /= a_string implies Result.same_type (other)
			new_count: Result.count = old a_string.count + e - s + 1
			initial: same_string (substring (Result, 1, old a_string.count), old clone (a_string))
			final: same_string (substring (Result, old a_string.count + 1, Result.count), old substring (other, s, e))
		end

	append_substring_to_string (a_string: STRING; other: STRING; s, e: INTEGER) is
			-- Append substring of `other' between indexes
			-- `s' and `e' at end of `a_string'.
		require
			a_string_not_void: a_string /= Void
			other_not_void: other /= Void
			same_type: other.same_type (a_string)
			s_large_enough: s >= 1
			e_small_enough: e <= other.count
			valid_interval: s <= e + 1
		local
			uc_string: UC_STRING
			i: INTEGER
		do
			uc_string ?= a_string
			if uc_string /= Void then
				uc_string.append_substring (other, s, e)
			else
				from i := s until i > e loop
					a_string.append_character (other.item (i))
					i := i + 1
				end
			end
		ensure
			appended: a_string.is_equal (old clone (a_string) + old substring (other, s, e))
		end

	fill_with (a_string: STRING; c: CHARACTER) is
			-- Replace every character in `a_string' with `c'.
			-- (ELKS 2001 STRING)
			-- Note: This routine should be made obsolete as soon
			-- as it is supported by ISE and HACT, which is not the
			-- case in ISE 5.1.14 and HACT 4.0.1 (implemented in
			-- ISE 5.2).
		require
			a_string_not_void: a_string /= Void











		do
			a_string.fill_with (c)

		ensure
			same_count: old a_string.count = a_string.count
			filled: a_string.occurrences (c) = a_string.count
		end

	insert_character (a_string: STRING; c: CHARACTER; i: INTEGER) is
			-- Insert `c' at index `i' in `a_string', shifting characters
			-- between ranks `i' and `count' rightwards.
			-- (ELKS 2001 STRING)
			-- Note: This routine should be made obsolete as soon
			-- as it is supported by ISE, which is not the
			-- case in ISE 5.1.14.
		require
			a_string_not_void: a_string /= Void
			valid_insertion_index: 1 <= i and i <= a_string.count + 1

















		do
			a_string.insert_character (c, i)

		ensure
			one_more_character: a_string.count = old a_string.count + 1
			inserted: a_string.item (i) = c
			stable_before_i: substring (a_string, 1, i - 1).is_equal (old substring (a_string, 1, i - 1))
			stable_after_i: substring (a_string, i + 1, a_string.count).is_equal (old substring (a_string, i, a_string.count))
		end

feature -- Conversion

	as_string (a_string: STRING): STRING is
			-- String version of `a_string';
			-- Return `a_string' if it is of dynamic type STRING,
			-- return the UTF encoding version if it is a descendant
			-- of UC_STRING, return 'string (a_string)' otherwise.
		require
			a_string_not_void: a_string /= Void
		local
			uc_string: UC_STRING
		do
			if a_string.same_type (dummy_string) then
				Result := a_string
			else
				uc_string ?= a_string
				if uc_string /= Void then
					Result := uc_string.as_string
				else
					Result := string (a_string)
				end
			end
		ensure
			as_string_not_void: Result /= Void
			string_type: Result.same_type ("")
			aliasing: a_string.same_type ("") implies Result = a_string
		end

	to_lower (a_string: STRING): STRING is
			-- Lower case version of `a_string'
			-- (Do not alter `a_string'.)
		require
			a_string_not_void: a_string /= Void
		do
			Result := clone (a_string)
			Result.to_lower
		ensure
			lower_string_not_void: Result /= Void
			lower_string_same_type: Result.same_type (a_string)
			same_count: Result.count = a_string.count
			-- definition: forall i in 1..a_string.count,
			--	Result.item (i) = a_string.item (i).to_lower
		end

	to_upper (a_string: STRING): STRING is
			-- Upper case version of `a_string'
			-- (Do not alter `a_string'.)
		require
			a_string_not_void: a_string /= Void
		do
			Result := clone (a_string)
			Result.to_upper
		ensure
			upper_string_not_void: Result /= Void
			upper_string_same_type: Result.same_type (a_string)
			same_count: Result.count = a_string.count
			-- definition: forall i in 1..a_string.count,
			--	Result.item (i) = a_string.item (i).to_upper
		end

	as_lower (a_string: STRING): STRING is
			-- New object with all letters in lower case
			-- (Extended from ELKS 2001 STRING)
			-- Note: This routine should be made obsolete as soon
			-- as it is supported by ISE and HACT, which is not the
			-- case in ISE 5.1.14 and HACT 4.0.1.
		require
			a_string_not_void: a_string /= Void
		do
			Result := clone (a_string)
			Result.to_lower
		ensure
			as_lower_not_void: Result /= Void
			as_lower_same_type: Result.same_type (a_string)
			length: Result.count = a_string.count
			anchor: a_string.count > 0 implies Result.item (1) = CHARACTER_.as_lower (a_string.item (1))
			recurse: a_string.count > 1 implies Result.substring (2, a_string.count).is_equal (as_lower (a_string.substring (2, a_string.count)))
		end

	as_upper (a_string: STRING): STRING is
			-- New object with all letters in upper case
			-- (Extended from ELKS 2001 STRING)
			-- Note: This routine should be made obsolete as soon
			-- as it is supported by ISE and HACT, which is not the
			-- case in ISE 5.1.14 and HACT 4.0.1.
		require
			a_string_not_void: a_string /= Void
		do
			Result := clone (a_string)
			Result.to_upper
		ensure
			as_upper_not_void: Result /= Void
			as_upper_same_type: Result.same_type (a_string)
			length: Result.count = a_string.count
			anchor: a_string.count > 0 implies Result.item (1) = CHARACTER_.as_upper (a_string.item (1))
			recurse: a_string.count > 1 implies Result.substring (2, a_string.count).is_equal (as_upper (a_string.substring (2, a_string.count)))
		end

	hexadecimal_to_integer (a_string: STRING): INTEGER is
			-- Convert  hexadecimal number string to integer.
		require
			not_void: a_string /= Void
			hexadecimal: is_hexadecimal (a_string)
		local
			i, nb: INTEGER
		do
			nb := a_string.count
			from i := 1 until i > nb loop
					-- Shift previous result.
				Result := Result * 16
					-- Add current digit
					-- (inspect independent of character set)
				inspect a_string.item (i)
				when '0' then
					-- Do nothing.
				when '1' then
					Result := Result + 1
				when '2' then
					Result := Result + 2
				when '3' then
					Result := Result + 3
				when '4' then
					Result := Result + 4
				when '5' then
					Result := Result + 5
				when '6' then
					Result := Result + 6
				when '7' then
					Result := Result + 7
				when '8' then
					Result := Result + 8
				when '9' then
					Result := Result + 9
				when 'a','A' then
					Result := Result + 10
				when 'b','B' then
					Result := Result + 11
				when 'c','C' then
					Result := Result + 12
				when 'd','D' then
					Result := Result + 13
				when 'e','E' then
					Result := Result + 14
				when 'f','F' then
					Result := Result + 15
				end
				i := i + 1
			end
		end

feature -- Removal

	keep_head (a_string: STRING; n: INTEGER) is
			-- Remove all the characters of `a_string' except for the first `n';
			-- if `n' > `a_string.count', do nothing.
			-- (ELKS 2001 STRING)
			-- Note: This routine should be made obsolete as soon as
			-- ISE and HACT support it, which is not yet the case
			-- as of ISE 5.1 and HACT 4.0.1.
		require
			a_string_not_void: a_string /= Void
			n_non_negative: n >= 0
		do



			a_string.keep_head (n)

		ensure
			kept: a_string.is_equal (old substring (a_string, 1, n.min (a_string.count)))
		end

	keep_tail (a_string: STRING; n: INTEGER) is
			-- Remove all the characters of `a_string' except for the last `n';
			-- if `n' > `a_string.count', do nothing.
			-- (ELKS 2001 STRING)
			-- Note: This routine should be made obsolete as soon as
			-- ISE and HACT support it, which is not yet the case
			-- as of ISE 5.1 and HACT 4.0.1.
		require
			a_string_not_void: a_string /= Void
			n_non_negative: n >= 0
		do



			a_string.keep_tail (n)

		ensure
			kept: a_string.is_equal (old substring (a_string, a_string.count - n.min (a_string.count) + 1, a_string.count))
		end

	remove_head (a_string: STRING; n: INTEGER) is
			-- Remove the first `n' characters of `a_string';
			-- if `n' > `a_string.count', remove all.
			-- (ELKS 2001 STRING)
			-- Note: This routine should be made obsolete as soon as
			-- ISE and HACT support it, which is not yet the case
			-- as of ISE 5.1 and HACT 4.0.1.
		require
			a_string_not_void: a_string /= Void
			n_non_negative: n >= 0
		local
			a_string_count: INTEGER
		do
			a_string_count := a_string.count
			if n >= a_string_count then
				keep_tail (a_string, 0)
			elseif n /= 0 then
				keep_tail (a_string, a_string_count - n)
			end
		ensure
			removed: a_string.is_equal (old substring (a_string, n.min (a_string.count) + 1, a_string.count))
		end

	remove_tail (a_string: STRING; n: INTEGER) is
			-- Remove the last `n' characters of `a_string';
			-- if `n' > `a_string.count', remove all.
			-- (ELKS 2001 STRING)
			-- Note: This routine should be made obsolete as soon as
			-- ISE and HACT support it, which is not yet the case
			-- as of ISE 5.1 and HACT 4.0.1.
		require
			a_string_not_void: a_string /= Void
			n_non_negative: n >= 0
		local
			a_string_count: INTEGER
		do
			a_string_count := a_string.count
			if n >= a_string_count then
				keep_head (a_string, 0)
			elseif n /= 0 then
				keep_head (a_string, a_string_count - n)
			end
		ensure
			removed: a_string.is_equal (old substring (a_string, 1, a_string.count - n.min (a_string.count)))
		end

	remove_substring (a_string: STRING; start_index, end_index: INTEGER) is
			-- Remove all characters of `a_string' from `start_index'
			-- to `end_index' inclusive.
			-- (ELKS 2001 STRING)
			-- Note: This routine should be made obsolete as soon as
			-- ISE and HACT support it, which is not yet the case
			-- as of ISE 5.1 and HACT 4.0.1 (implemented in ISE 5.2).
		require
			a_string_not_void: a_string /= Void
			valid_start_index: 1 <= start_index
			valid_end_index: end_index <= a_string.count
			meaningful_interval: start_index <= end_index + 1

		local
			uc_string: UC_STRING
		do
			uc_string ?= a_string
			if uc_string /= Void then
				uc_string.remove_substring (start_index, end_index)
			elseif start_index <= end_index then
				a_string.replace_substring ("", start_index, end_index)
			end





		ensure
			removed: a_string.is_equal (old substring (a_string, 1, start_index - 1) + old substring (a_string, end_index + 1, a_string.count))
		end

	wipe_out (a_string: STRING) is
			-- Remove all characters in `a_string'.
			-- Do not discard allocated memory (i.e. do not
			-- change capacity) when allowed by the underlying
			-- Eiffel compiler. (Note: currently only ISE and
			-- SE will not change capacity, whereas HACT and
			-- VE will reset capacity to zero.)
		require
			a_string_not_void: a_string /= Void
		do

			a_string.clear_all



		ensure
			wiped_out: a_string.count = 0
		end

feature -- Resizing

	resize_buffer (a_string: STRING; n: INTEGER) is
			-- Resize `a_string' so that it contains `n' characters.
			-- Do not lose any previously entered characters.
		require
			a_string_not_void: a_string /= Void
			a_string_is_string: a_string.same_type ("")
			n_large_enough: n >= a_string.count

		local
			i: INTEGER

		do














			from
				i := n - a_string.count
				a_string.resize (n)
			until
				i = 0
			loop
				a_string.append_character ('#')
				i := i - 1
			end

		ensure
			count_set: a_string.count = n
		end

feature -- Obsolete

	same_unicode_string (a_string, other: STRING): BOOLEAN is
			-- Do `a_string' and `other' have the same unicode character sequence?
			-- Note: the difference with `elks_same_string' is that here the
			-- implementation uses STRING.item_code instead of STRING.item
			-- and hence characters which have different codes are not
			-- considered equal even if they do not fit into a CHARACTER.
		obsolete
			"[020722] Use `same_string' instead."
		require
			a_string_not_void: a_string /= Void
			other_not_void: other /= Void
		do
			Result := same_string (a_string, other)
		ensure
			definition: Result = (a_string.count = other.count and then
				(a_string.count > 0 implies (a_string.item_code (1) = other.item_code (1) and
				(a_string.count >= 2 implies same_string (substring (a_string, 2, a_string.count), substring (other, 2, a_string.count))))))
			elks_same_string: Result implies elks_same_string (a_string, other)
		end

feature {NONE} -- Implementation

	dummy_string: STRING is ""
			-- Dummy string

end
