indexing

	description:

		"Unicode strings"

	remark:

		"Unless specified otherwise, STRING and CHARACTER are %
		%supposed to contain characters whose code follows the %
		%unicode character set. In other words characters whose %
		%code is between 128 and 255 should follow the ISO 8859-1 %
		%Latin-1 character set."

	remark2:

		"By default UC_STRING is implemented using the UTF-8 encoding. %
		%Use UC_UTF*_STRING to specify the encoding explicitly."

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2001-2004, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class UC_STRING

inherit

	KS_STRING
		undefine





		select
				-- Note: The postcondition of `is_equal' in ELKS 2001 STRING
				-- is too constraining and does not allow a redefinition here.
				-- Redefine version from ANY instead.
			is_equal

		end

	STRING
		rename

			capacity as byte_capacity,


			set_count as old_set_count,






			clear_all as old_clear_all,
			left_adjust as old_left_adjust,
			right_adjust as old_right_adjust,


				-- Note: The postconditions of `wipe_out' in
				-- ISE 5.4/5.5 does not allow an optimized ELKS compliant
				-- redefinition here. In particular we don't want to
				-- reset the capacity to zero.
			wipe_out as old_wipe_out,


			empty as old_empty,
				-- Note: The postcondition of `infix "<"' in ELKS 2001 STRING
				-- is too constraining and does not allow a redefinition here.
				-- Redefine version from COMPARABLE instead.
			infix "<" as old_infix_less,
				-- Note: The postcondition of `is_equal' in ELKS 2001 STRING
				-- is too constraining and does not allow a redefinition here.
				-- Redefine version from ANY instead.
			is_equal as old_is_equal,

			is_empty as old_is_empty,
			put_code as old_put_code,
			index_of_code as old_index_of_code,
			has_code as old_has_code,
			append_code as old_append_code
		export




			{STRING} share, area, old_is_empty, mirror, shared_with, is_case_insensitive_equal, to_string_32, code

			{NONE} all
		undefine



			infix ">", infix "<=", infix ">=", max, min
		redefine
			make, make_from_string, make_empty, make_filled,
			put, append_character, item,
			substring, append_string, replace_substring,
			index_of, has, occurrences,
			hash_code, remove, to_lower, to_upper,
			three_way_comparison, item_code,

			byte_capacity,

			has_substring, insert_character,
			string, same_string, insert_string,
			keep_head, keep_tail,
			remove_head, remove_tail,
			remove_substring,
			as_lower, as_upper,
			out, fill_with,




			head, tail,


			infix "@",


			count,
			old_clear_all,
			old_left_adjust,
			old_right_adjust,
			old_wipe_out,



			substring_index,
			infix "+",
			copy

		select
			put, item

		end


	STRING
		rename
			item as old_item,
			put as old_put,
			capacity as byte_capacity,
			set_count as old_set_count,
			is_empty as old_is_empty,
			put_code as old_put_code,
			index_of_code as old_index_of_code,
			has_code as old_has_code,
			append_code as old_append_code,
			clear_all as old_clear_all,
			left_adjust as old_left_adjust,
			right_adjust as old_right_adjust,
				-- Note: The postconditions of `wipe_out' in
				-- ISE 5.4/5.5 does not allow an optimized ELKS compliant
				-- redefinition here. In particular we don't want to
				-- reset the capacity to zero.
			wipe_out as old_wipe_out,
			empty as old_empty,
				-- Note: The postcondition of `is_equal' in ELKS 2001 STRING
				-- is too constraining and does not allow a redefinition here.
				-- Redefine version from ANY instead.
			is_equal as old_is_equal,
				-- Note: The postcondition of `infix "<"' in ELKS 2001 STRING
				-- is too constraining and does not allow a redefinition here.
				-- Redefine version from COMPARABLE instead.
			infix "<" as old_infix_less
		export
			{NONE} all
		undefine
			infix ">", infix "<=", infix ">=", max, min
		redefine
			make, make_from_string, make_empty, make_filled,
			append_character, substring_index,
			substring, append_string, replace_substring,
			index_of, has, occurrences, head, tail,
			hash_code, remove, to_lower, to_upper,
			three_way_comparison, item_code,
			byte_capacity, count,
			has_substring, insert_character,
			string, same_string, insert_string,
			keep_head, keep_tail,
			remove_head, remove_tail,
			remove_substring,
			as_lower, as_upper,
			out, fill_with,
			old_wipe_out,
			old_clear_all,
			old_left_adjust,
			old_right_adjust,
			infix "+",
			copy, infix "@"
		end


	COMPARABLE
		export
			{NONE} all
		undefine




			three_way_comparison,
			is_equal, copy, out

		select
				-- Note: The postcondition of `infix "<"' in ELKS 2001 STRING
				-- is too constraining and does not allow a redefinition here.
				-- Redefine version from COMPARABLE instead.
			infix "<"

		end

	KI_TEXT_OUTPUT_STREAM
		rename
			put_character as append_character,
			put_string as append_string,
			put_substring as append_substring,
			append as append_stream,
			True_constant as stream_true_constant,
			False_constant as stream_false_constant
		undefine




			is_equal, copy, out
		redefine
			append_substring
		end

	UC_STRING_HANDLER
		undefine




			is_equal, copy, out
		end

	UC_IMPORTED_UNICODE_ROUTINES
		undefine




			is_equal, copy, out
		end

	UC_IMPORTED_UTF8_ROUTINES
		undefine




			is_equal, copy, out
		end

	UC_IMPORTED_UTF16_ROUTINES
		undefine




			is_equal, copy, out
		end

	KL_IMPORTED_INTEGER_ROUTINES
		undefine




			is_equal, copy, out
		end

	DEBUG_OUTPUT
		undefine




			is_equal, copy, out
		end

creation

	make, make_empty, make_from_string, make_from_utf8,
	make_filled, make_filled_code, make_filled_unicode,
	make_from_substring, make_from_utf16

feature -- Initialization

	make (suggested_capacity: INTEGER) is
			-- Create empty string, or remove all characters from
			-- existing string.
			-- (Extended from ELKS 2001 STRING)
		do
			reset_byte_index_cache





			count := 0
			if suggested_capacity = 0 then
					-- Make sure that the `area' is not shared.
				precursor (1)
			else
				precursor (suggested_capacity)
			end





			set_count (byte_capacity)
			old_set_count (byte_capacity)
			set_count (0)

			byte_count := 0
		ensure then
			byte_count_set: byte_count = 0
			byte_capacity_set: byte_capacity >= suggested_capacity
		end

	make_from_string (a_string: STRING) is
			-- Initialize from the character sequence of `a_string'.
			-- (ELKS 2001 STRING)
		do
			if a_string /= Current then
				make_from_substring (a_string, 1, a_string.count)
			end
		ensure then
			same_unicode: same_unicode_string (a_string)
		end

feature {NONE} -- Initialization

	make_empty is
			-- Create empty string.
			-- (ELKS 2001 STRING)
		do
			make (0)
		end

	make_from_substring (a_string: STRING; start_index, end_index: INTEGER) is
			-- Initialize from the character sequence of `a_string'
			-- between `start_index' and `end_index' inclusive.
		require
			a_string_not_void: a_string /= Void
			valid_start_index: 1 <= start_index
			valid_end_index: end_index <= a_string.count
			meaningful_interval: start_index <= end_index + 1
		local
			nb: INTEGER
			str: STRING
		do
			if a_string /= Current or else start_index /= 1 or else end_index /= count then
				if end_index < start_index then
					make (0)
				else
					if a_string = Current then
						str := cloned_string
					else
						str := a_string
					end
					nb := utf8.substring_byte_count (str, start_index, end_index)
					make (nb)
					set_count (end_index - start_index + 1)
					byte_count := nb
					put_substring_at_byte_index (str, start_index, end_index, nb, 1)
				end
			end
		ensure
			-- Note: Too memory and time consumming with SmartEiffel:
			-- initialized: same_unicode_string (a_string.substring (start_index, end_index))
		end

	make_filled_unicode (c: UC_CHARACTER; n: INTEGER) is
			-- Create string of length `n' filled with unicode character `c'.
		require
			c_not_void: c /= Void
			valid_count: n >= 0
		do
			make_filled_code (c.code, n)
		ensure
			count_set: count = n
			filled: unicode_occurrences (c) = count
		end

	make_filled_code (a_code: INTEGER; n: INTEGER) is
			-- Create string of length `n' filled with unicode
			-- character of code `a_code'.
		require
			valid_code: unicode.valid_code (a_code)
			valid_count: n >= 0
		local
			i, nb: INTEGER
			new_byte_count: INTEGER
		do
			nb := utf8.code_byte_count (a_code)
			new_byte_count := nb * n
			make (new_byte_count)
			set_count (n)
			byte_count := new_byte_count
			from i := 1 until i > new_byte_count loop
				put_code_at_byte_index (a_code, nb, i)
				i := i + nb
			end
		ensure
			count_set: count = n
			filled: code_occurrences (a_code) = count
		end

	make_filled (c: CHARACTER; n: INTEGER) is
			-- Create string of length `n' filled with character `c'.
			-- (ELKS 2001 STRING)
		local
			i, nb: INTEGER
			new_byte_count: INTEGER
		do
			nb := utf8.character_byte_count (c)
			new_byte_count := nb * n
			make (new_byte_count)
			set_count (n)
			byte_count := new_byte_count
			if nb = 1 then
				from i := 1 until i > new_byte_count loop
					put_byte (c, i)
					i := i + 1
				end
			else
				from i := 1 until i > new_byte_count loop
					put_character_at_byte_index (c, nb, i)
					i := i + nb
				end
			end
		ensure then
			filled_code: code_occurrences (c.code) = count
		end

	make_from_utf8 (s: STRING) is
			-- Initialize from the bytes sequence of `s' corresponding
			-- to the UTF-8 representation of a string.
		require
			s_not_void: s /= Void
			s_is_string: ANY_.same_types (s, "")
			valid_utf8: utf8.valid_utf8 (s)
		do
			make (s.count)
			append_utf8 (s)
		end

	make_from_utf16 (s: STRING) is
			-- Initialize from the bytes sequence of `s' corresponding
			-- to the UTF-16 representation of a string.
		require
			s_not_void: s /= Void
			s_is_string: ANY_.same_types (s, "")
			valid_utf16: utf16.valid_utf16 (s)
		do
			make (s.count // 2)
			append_utf16 (s)
		end

feature -- Access

	unicode_item (i: INTEGER): UC_CHARACTER is
			-- Unicode character at index `i';
			-- Return a new object at each call
		require
			valid_index: valid_index (i)
		do
			create Result.make_from_code (item_code (i))
		ensure
			item_not_void: Result /= Void
			code_set: Result.code = item_code (i)
		end

	item_code (i: INTEGER): INTEGER is
			-- Code of character at index `i'
		local
			k: INTEGER
		do
			if count = byte_count then
				Result := byte_item (i).code
			else
				k := byte_index (i)
				Result := item_code_at_byte_index (k)
			end
		ensure then
			valid_item_code: unicode.valid_code (Result)
		end

	item (i: INTEGER): CHARACTER is
			-- Character at index `i';
			-- '%U' if the unicode character at index
			-- `i' cannot fit into a CHARACTER
			-- (Extended from ELKS 2001 STRING)
			-- Note: Use `item_code' instead of this routine when `Current'
			-- can contain characters which may not fit into a CHARACTER.
		local
			k: INTEGER
		do
			if count = byte_count then
				Result := byte_item (i)
			else
				k := byte_index (i)
				Result := character_item_at_byte_index (k)
			end
		end


	infix "@" (i: INTEGER): CHARACTER is
			-- Character at index `i'
			-- (ELKS 2001 STRING)
		do
			Result := item (i)
		end


	substring (start_index, end_index: INTEGER): like Current is
			-- New object containing all characters
			-- from `start_index' to `end_index' inclusive
			-- (ELKS 2001 STRING)
		do
			if end_index < start_index then
				create Result.make (0)
			else
				create Result.make_from_substring (Current, start_index, end_index)
			end
		ensure then
			first_unicode_item: Result.count > 0 implies Result.item_code (1) = item_code (start_index)
		end

	unicode_substring_index (other: STRING; start_index: INTEGER): INTEGER is
			-- Index of first occurrence of `other' at or after `start_index';
			-- 0 if none
		require
			other_not_void: other /= Void
			valid_start_index: start_index >= 1 and start_index <= count + 1
		local
			i, j, nb: INTEGER
			a_code, a_code2: INTEGER
			other_unicode: UC_STRING
			k, z, end_index: INTEGER
			found: BOOLEAN
			other_count: INTEGER
		do
			if other = Current then
				if start_index = 1 then
					Result := 1
				end
			else
				other_count := other.count
				if other_count = 0 then
					Result := start_index
				else
					end_index := count - other_count + 1
					if start_index <= end_index then
						if count = byte_count then
							other_unicode ?= other
							if other_unicode /= Void then
								nb := other_unicode.byte_count
								from k := start_index until k > end_index loop
									j := k
									found := True
									from i := 1 until i > nb loop
										a_code := other_unicode.item_code_at_byte_index (i)
										if byte_item (j).code /= a_code then
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
								nb := other_count
								from k := start_index until k > end_index loop
									j := k
									found := True
									from i := 1 until i > nb loop
										if byte_item (j).code /= other.item_code (i) then
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
						else
							z := byte_index (start_index)
							other_unicode ?= other
							if other_unicode /= Void then
								nb := other_unicode.byte_count
								from k := start_index until k > end_index loop
									j := z
									found := True
									from i := 1 until i > nb loop
										a_code := item_code_at_byte_index (j)
										a_code2 := other_unicode.item_code_at_byte_index (i)
										if a_code /= a_code2 then
											found := False
											i := nb + 1 -- Jump out of the loop.
										else
											j := next_byte_index (j)
											i := other_unicode.next_byte_index (i)
										end
									end
									if found then
										Result := k
										k := end_index + 1 -- Jump out of the loop.
									else
										z := next_byte_index (z)
										k := k + 1
									end
								end
							else
								nb := other_count
								from k := start_index until k > end_index loop
									j := z
									found := True
									from i := 1 until i > nb loop
										a_code := item_code_at_byte_index (j)
										if a_code /= other.item_code (i) then
											found := False
											i := nb + 1 -- Jump out of the loop.
										else
											j := next_byte_index (j)
											i := i + 1
										end
									end
									if found then
										Result := k
										k := end_index + 1 -- Jump out of the loop.
									else
										z := next_byte_index (z)
										k := k + 1
									end
								end
							end
						end
					end
				end
			end
		ensure
			valid_result: Result = 0 or else (start_index <= Result and Result <= count - other.count + 1)
			zero_if_absent: (Result = 0) = not substring (start_index, count).has_unicode_substring (other)
			at_this_index: Result >= start_index implies substring (Result, Result + other.count - 1).same_unicode_string (other)
			none_before: Result > start_index implies not substring (start_index, Result + other.count - 2).has_unicode_substring (other)
		end

	substring_index (other: STRING; start_index: INTEGER): INTEGER is
			-- Index of first occurrence of `other' at or after `start_index';
			-- 0 if none. `other' and `Current' are considered with their
			-- characters which do not fit in a CHARACTER replaced by a '%U'
			-- (Extended from ELKS 2001 STRING)
		local
			i, j, nb: INTEGER
			a_code, a_code2: INTEGER
			other_unicode: UC_STRING
			k, z, end_index: INTEGER
			found: BOOLEAN
			other_count: INTEGER
		do
			if other = Current then
				if start_index = 1 then
					Result := 1
				end
			else
				other_count := other.count
				if other_count = 0 then
					Result := start_index
				else
					end_index := count - other_count + 1
					if start_index <= end_index then
						if count = byte_count then
							other_unicode ?= other
							if other_unicode /= Void then
								nb := other_unicode.byte_count
								from k := start_index until k > end_index loop
									j := k
									found := True
									from i := 1 until i > nb loop
										a_code := other_unicode.item_code_at_byte_index (i)
										if a_code > Platform.Maximum_character_code then
											a_code := 0
										end
										if byte_item (j).code /= a_code then
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
								nb := other_count
								from k := start_index until k > end_index loop
									j := k
									found := True
									from i := 1 until i > nb loop
										if byte_item (j) /= other.item (i) then
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
						else
							z := byte_index (start_index)
							other_unicode ?= other
							if other_unicode /= Void then
								nb := other_unicode.byte_count
								from k := start_index until k > end_index loop
									j := z
									found := True
									from i := 1 until i > nb loop
										a_code := item_code_at_byte_index (j)
										if a_code > Platform.Maximum_character_code then
											a_code := 0
										end
										a_code2 := other_unicode.item_code_at_byte_index (i)
										if a_code2 > Platform.Maximum_character_code then
											a_code2 := 0
										end
										if a_code /= a_code2 then
											found := False
											i := nb + 1 -- Jump out of the loop.
										else
											j := next_byte_index (j)
											i := other_unicode.next_byte_index (i)
										end
									end
									if found then
										Result := k
										k := end_index + 1 -- Jump out of the loop.
									else
										z := next_byte_index (z)
										k := k + 1
									end
								end
							else
								nb := other_count
								from k := start_index until k > end_index loop
									j := z
									found := True
									from i := 1 until i > nb loop
										a_code := item_code_at_byte_index (j)
										if a_code > Platform.Maximum_character_code then
											a_code := 0
										end
										if a_code /= other.item (i).code then
											found := False
											i := nb + 1 -- Jump out of the loop.
										else
											j := next_byte_index (j)
											i := i + 1
										end
									end
									if found then
										Result := k
										k := end_index + 1 -- Jump out of the loop.
									else
										z := next_byte_index (z)
										k := k + 1
									end
								end
							end
						end
					end
				end
			end
		end

	string: STRING is
			-- New STRING having the same character sequence as `Current'
			-- where characters which do not fit in a CHARACTER are
			-- replaced by a '%U'
			-- (Extended from ELKS 2001 STRING)
		local
			i, nb: INTEGER
			a_code: INTEGER
		do
			nb := count
			create Result.make (nb)
			if nb = byte_count then
				from i := 1 until i > nb loop
					Result.append_character (byte_item (i))
					i := i + 1
				end
			else
				nb := byte_count
				from i := 1 until i > nb loop
					a_code := item_code_at_byte_index (i)
					if a_code <= Platform.Maximum_character_code then
						Result.append_character (INTEGER_.to_character (a_code))
					else
						Result.append_character ('%U')
					end
					i := next_byte_index (i)
				end
			end
		end

	infix "+" (other: STRING): like Current is
			-- New object which is a clone of `Current' extended
			-- by the characters of `other'
			-- (ELKS 2001 STRING)
		do
			create Result.make (byte_count + utf8.substring_byte_count (other, 1, other.count))
			Result.append_string (Current)
			Result.append_string (other)
		ensure then
			final_unicode: Result.substring (count + 1, count + other.count).same_unicode_string (other)
		end

	prefixed_string (other: STRING): like Current is
			-- New object which is a clone of `Current' preceded
			-- by the characters of `other'
		require
			other_not_void: other /= Void
		do
			create Result.make (byte_count + utf8.substring_byte_count (other, 1, other.count))
			Result.append_string (other)
			Result.append_string (Current)
		ensure
			prefixed_string_not_void: Result /= Void
			prefixed_string_count: Result.count = other.count + count
			initial: Result.substring (1, other.count).same_unicode_string (other)
			final: Result.substring (other.count + 1, Result.count).is_equal (Current)
		end

	index_of_unicode (c: UC_CHARACTER; start_index: INTEGER): INTEGER is
			-- Index of first occurrence of `c' at or after `start_index';
			-- 0 if none
		require
			valid_start_index: start_index >= 1 and start_index <= count + 1
		do
			Result := index_of_code (c.code, start_index)
		ensure
			valid_result: Result = 0 or (start_index <= Result and Result <= count)
			zero_if_absent: (Result = 0) = not substring (start_index, count).has_unicode (c)
			found_if_present: substring (start_index, count).has_unicode (c) implies item_code (Result) = c.code
			none_before: substring (start_index, count).has_unicode (c) implies not substring (start_index, Result - 1).has_unicode (c)
		end

	index_of_code (a_code: INTEGER; start_index: INTEGER): INTEGER is
			-- Index of first occurrence of unicode character with
			-- code `a_code' at or after `start_index'; 0 if none
		require
			valid_start_index: start_index >= 1 and start_index <= count + 1
			valid_code: unicode.valid_code (a_code)
		local
			i, k, nb: INTEGER
		do
			nb := count
			if nb = byte_count then
				if a_code > 127 then
					-- Result := 0
				else
					from i := start_index until i > nb loop
						if byte_item (i).code = a_code then
							Result := i
							i := nb + 1 -- Jump out of the loop.
						else
							i := i + 1
						end
					end
				end
			elseif start_index <= nb then
				k := byte_index (start_index)
				from i := start_index until i > nb loop
					if item_code_at_byte_index (k) = a_code then
						Result := i
						i := nb + 1 -- Jump out of the loop.
					else
						k := next_byte_index (k)
						i := i + 1
					end
				end
			end
		ensure
			valid_result: Result = 0 or (start_index <= Result and Result <= count)
			zero_if_absent: (Result = 0) = not substring (start_index, count).has_code (a_code)
			found_if_present: substring (start_index, count).has_code (a_code) implies item_code (Result) = a_code
			none_before: substring (start_index, count).has_code (a_code) implies not substring (start_index, Result - 1).has_code (a_code)
		end

	index_of (c: CHARACTER; start_index: INTEGER): INTEGER is
			-- Index of first occurrence of character `c'
			-- at or after `start_index'; 0 if none
			-- (ELKS 2001 STRING)
		local
			i, k, nb: INTEGER
			max_code: INTEGER
			a_code: INTEGER
		do
			nb := count
			if nb = byte_count then
				from i := start_index until i > nb loop
					if byte_item (i) = c then
						Result := i
						i := nb + 1 -- Jump out of the loop.
					else
						i := i + 1
					end
				end
			elseif c = '%U' then
				if start_index <= nb then
					max_code := Platform.Maximum_character_code
					k := byte_index (start_index)
					from i := start_index until i > nb loop
						a_code := item_code_at_byte_index (k)
						if a_code = 0 or a_code > max_code then
							Result := i
							i := nb + 1 -- Jump out of the loop.
						else
							k := next_byte_index (k)
							i := i + 1
						end
					end
				end
			else
				Result := index_of_code (c.code, start_index)
			end
		end

	hash_code: INTEGER is
			-- Hash code
			-- (ELKS 2001 STRING)
		local
			i, nb: INTEGER
			a_code: INTEGER
			fit_in_string: BOOLEAN
		do
			nb := count
			if nb = byte_count then
				Result := precursor
			else
				fit_in_string := True
				nb := byte_count
				from i := 1 until i > nb loop
					a_code := item_code_at_byte_index (i)
					Result := 5 * Result + a_code
					if a_code > Platform.Maximum_character_code then
						fit_in_string := False
					end
					i := next_byte_index (i)
				end
				if fit_in_string then

					Result := string.hash_code



				end
			end
			if Result < 0 then
				Result := - (Result + 1)
			end
		end

	new_empty_string (suggested_capacity: INTEGER): like Current is
			-- New empty string with same dynamic type as `Current'
		require
			non_negative_suggested_capacity: suggested_capacity >= 0
		do
			create Result.make (suggested_capacity)
		ensure
			new_string_not_void: Result /= Void
			same_type: ANY_.same_types (Result, Current)
			new_string_empty: Result.count = 0
			byte_count_set: Result.byte_count = 0
			byte_capacity_set: Result.byte_capacity >= suggested_capacity
		end

feature -- Measurement

	unicode_occurrences (c: UC_CHARACTER): INTEGER is
			-- Number of times `c' appears in the string
		require
			c_not_void: c /= Void
		do
			Result := code_occurrences (c.code)
		ensure
			zero_if_empty: count = 0 implies Result = 0
			recurse_if_not_found_at_first_position: (count > 0 and then item_code (1) /= c.code) implies
				Result = substring (2, count).unicode_occurrences (c)
			recurse_if_found_at_first_position: (count > 0 and then item_code (1) = c.code) implies
				Result = 1 + substring (2, count).unicode_occurrences (c)
		end

	code_occurrences (a_code: INTEGER): INTEGER is
			-- Number of times unicode character of code
			-- `a_code' appears in the string
		require
			valid_code: unicode.valid_code (a_code)
		local
			i, nb: INTEGER
		do
			nb := count
			if nb = byte_count then
				if a_code > 127 then
					-- Result := 0
				else
					from i := 1 until i > nb loop
						if byte_item (i).code = a_code then
							Result := Result + 1
						end
						i := i + 1
					end
				end
			else
				nb := byte_count
				from i := 1 until i > nb loop
					if item_code_at_byte_index (i) = a_code then
						Result := Result + 1
					end
					i := next_byte_index (i)
				end
			end
		ensure
			zero_if_empty: count = 0 implies Result = 0
			recurse_if_not_found_at_first_position: (count > 0 and then item_code (1) /= a_code) implies
				Result = substring (2, count).code_occurrences (a_code)
			recurse_if_found_at_first_position: (count > 0 and then item_code (1) = a_code) implies
				Result = 1 + substring (2, count).code_occurrences (a_code)
		end

	occurrences (c: CHARACTER): INTEGER is
			-- Number of times character `c' appears in the string
			-- (ELKS 2001 STRING)
		local
			i, nb: INTEGER
			max_code: INTEGER
			a_code: INTEGER
		do
			nb := count
			if nb = byte_count then
				from i := 1 until i > nb loop
					if byte_item (i) = c then
						Result := Result + 1
					end
					i := i + 1
				end
			elseif c = '%U' then
				max_code := Platform.Maximum_character_code
				nb := byte_count
				from i := 1 until i > nb loop
					a_code := item_code_at_byte_index (i)
					if a_code = 0 or a_code > max_code then
						Result := Result + 1
					end
					i := next_byte_index (i)
				end
			else
				Result := code_occurrences (c.code)
			end
		end


	count: INTEGER
			-- Number of characters
			-- (ELKS 2001 STRING)


	byte_count: INTEGER
			-- Number of bytes in internal storage

	byte_capacity: INTEGER is
			-- Maximum number of bytes that can be put in
			-- internal storage
		do






			Result := precursor


		end

feature -- Status report

	has_unicode (c: UC_CHARACTER): BOOLEAN is
			-- Does `Current' contain `c'?
		require
			c_not_void: c /= Void
		do
			Result := has_code (c.code)
		ensure
			false_if_empty: count = 0 implies not Result
			true_if_first: count > 0 and then item_code (1) = c.code implies Result
			recurse: (count > 0 and then item_code (1) /= c.code) implies (Result = substring (2, count).has_unicode (c))
		end

	has_code (a_code: INTEGER): BOOLEAN is
			-- Does `Current' contain the unicode character of code `a_code'?
		require
			valid_code: unicode.valid_code (a_code)
		do
			Result := (index_of_code (a_code, 1) /= 0)
		ensure
			false_if_empty: count = 0 implies not Result
			true_if_first: count > 0 and then item_code (1) = a_code implies Result
			recurse: (count > 0 and then item_code (1) /= a_code) implies (Result = substring (2, count).has_code (a_code))
		end

	has (c: CHARACTER): BOOLEAN is
			-- Does `Current' contain character `c'?
			-- (ELKS 2001 STRING)
		do
			Result := (index_of (c, 1) /= 0)
		end

	has_unicode_substring (other: STRING): BOOLEAN is
			-- Does `Current' contain `other'?
		require
			other_not_void: other /= Void
		do
			if other = Current then
				Result := True
			elseif other.count <= count then
				Result := (unicode_substring_index (other, 1) /= 0)
			end
		ensure
			false_if_too_small: count < other.count implies not Result
			true_if_initial: (count >= other.count and then substring (1, other.count).same_unicode_string (other)) implies Result
			recurse: (count >= other.count and then not substring (1, other.count).same_unicode_string (other)) implies (Result = substring (2, count).has_unicode_substring (other))
			has_substring: Result implies has_substring (other)
		end

	has_substring (other: STRING): BOOLEAN is
			-- Does `Current' contain `other'?
			-- `other' and `Current' are considered with their characters
			-- which do not fit in a CHARACTER replaced by a '%U'.
			-- (Extented from ELKS 2001 STRING)
		do
			if other = Current then
				Result := True
			elseif other.count <= count then
				Result := (substring_index (other, 1) /= 0)
			end
		end

	is_empty: BOOLEAN is
			-- Is string empty?
			-- (ELKS 2001 STRING)
		do
			Result := (count = 0)
		end

	is_ascii: BOOLEAN is
			-- Does string contain only ASCII characters?
		do
			Result := (count = byte_count)
		ensure
			empty: count = 0 implies Result
			recurse: count > 0 implies Result = (unicode_item (1).is_ascii and substring (2, count).is_ascii)
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered equal
			-- to current object?
			-- (Extended from ELKS 2001 STRING)
		local
			i, nb: INTEGER
		do
			if other = Current then
				Result := True
			elseif ANY_.same_types (Current, other) and then other.byte_count = byte_count then
				nb := byte_count
				Result := True
				from i := 1 until i > nb loop
					if byte_item (i) /= other.byte_item (i) then
						Result := False
						i := nb + 1 -- Jump out of the loop.
					else
						i := i + 1
					end
				end
			end
		ensure then
			unicode_definition:
				Result = (ANY_.same_types (Current, other) and then count = other.count and then
				(count > 0 implies (item_code (1) = other.item_code (1) and
				substring (2, count).is_equal (other.substring (2, count)))))
		end

	infix "<" (other: like Current): BOOLEAN is
			-- Is string lexicographically lower than `other'?
			-- (Extended from ELKS 2001 STRING, inherited from COMPARABLE)
		do
			Result := (three_way_comparison (other) = -1)
		ensure then
			unicode_definition: Result = (count = 0 and other.count > 0 or
				count > 0 and then other.count > 0 and then (item_code (1) < other.item_code (1) or
				item_code (1) = other.item_code (1) and substring (2, count) < other.substring (2, other.count)))
		end

	same_string (other: STRING): BOOLEAN is
			-- Do `Current' and `other' have the same character sequence?
			-- `Current' is considered with its characters which do not
			-- fit in a CHARACTER replaced by a '%U'.
			-- (Extended from ELKS 2001 STRING)
		do
			if other = Current then
				Result := True
			elseif other.count = count then
				Result := (substring_index (other, 1) = 1)
			end
		end

	same_unicode_string (other: STRING): BOOLEAN is
			-- Do `Current' and `other' have the same unicode character sequence?
		require
			other_not_void: other /= Void
		do
			if other = Current then
				Result := True
			elseif other.count = count then
				Result := (unicode_substring_index (other, 1) = 1)
			end
		ensure
			definition: Result = (count = other.count and then
				(count > 0 implies (item_code (1) = other.item_code (1) and
				(count >= 2 implies substring (2, count).same_unicode_string (other.substring (2, count))))))
			same_string: Result implies same_string (other)
		end

	three_way_comparison (other: like Current): INTEGER is
			-- If current object equal to `other', 0;
			-- if smaller, -1; if greater, 1
			-- (ELKS 2001 STRING, inherited from COMPARABLE)
			-- Note: there is a bug in the specification of the
			-- contracts of `three_way_comparison' inherited
			-- from COMPARABLE. This routine cannot satisfy
			-- its postconditions if `other' is not of the
			-- same type as `Current' because the postcondition
			-- uses `is_equal' and `is_equal' has a postcondition
			-- inherited from ANY which says if it returns true
			-- then `other' has the same type as `Current'.
		local
			i, nb, nb1, nb2: INTEGER
			b1, b2: CHARACTER
			found: BOOLEAN
		do
			if other /= Current and ANY_.same_types (Current, other) then
				nb1 := byte_count
				nb2 := other.byte_count
				if nb1 < nb2 then
					nb := nb1
				else
					nb := nb2
				end
				from i := 1 until i > nb loop
					b1 := byte_item (i)
					b2 := other.byte_item (i)
					if b1 = b2 then
						i := i + 1
					elseif b1 < b2 then
						found := True
						Result := -1
						i := nb + 1 -- Jump out of the loop.
					else
						found := True
						Result := 1
						i := nb + 1 -- Jump out of the loop.
					end
				end
				if not found then
					if nb1 < nb2 then
						Result := -1
					elseif nb1 /= nb2 then
						Result := 1
					end
				end
			end
		end

	three_way_unicode_comparison (other: STRING): INTEGER is
			-- If current object equal to `other', 0;
			-- if smaller, -1; if greater, 1
			-- Note: there is a bug in the specification of the
			-- contracts of `three_way_comparison' inherited
			-- from COMPARABLE. This routine cannot satisfy
			-- its postconditions if `other' is not of the
			-- same type as `Current' because the postcondition
			-- uses `is_equal' and `is_equal' has a postcondition
			-- inherited from ANY which says if it returns true
			-- then `other' has the same type as `Current'.
			-- `three_way_unicode_comparison' solves this problem
			-- and make the comparison polymorphically safe by
			-- changing the signature from 'like Current' to
			-- 'STRING' and by using `same_unicode_string' instead
			-- of `is_equal' in its postcondition.
		require
			other_not_void: other /= Void
		local
			uc_string: UC_STRING
			i, nb, nb1, nb2: INTEGER
			b1, b2: CHARACTER
			c1, c2: INTEGER
			found: BOOLEAN
		do
			if other = Current then
				Result := 0
			elseif ANY_.same_types (Current, other) then
				uc_string ?= other
				nb1 := byte_count
				nb2 := uc_string.byte_count
				if nb1 < nb2 then
					nb := nb1
				else
					nb := nb2
				end
				from i := 1 until i > nb loop
					b1 := byte_item (i)
					b2 := uc_string.byte_item (i)
					if b1 = b2 then
						i := i + 1
					elseif b1 < b2 then
						found := True
						Result := -1
						i := nb + 1 -- Jump out of the loop.
					else
						found := True
						Result := 1
						i := nb + 1 -- Jump out of the loop.
					end
				end
				if not found then
					if nb1 < nb2 then
						Result := -1
					elseif nb1 /= nb2 then
						Result := 1
					end
				end
			else
				nb1 := count
				nb2 := other.count
				if nb1 < nb2 then
					nb := nb1
				else
					nb := nb2
				end
				from i := 1 until i > nb loop
					c1 := item_code (i)
					c2 := other.item_code (i)
					if c1 = c2 then
						i := i + 1
					elseif c1 < c2 then
						found := True
						Result := -1
						i := nb + 1 -- Jump out of the loop.
					else
						found := True
						Result := 1
						i := nb + 1 -- Jump out of the loop.
					end
				end
				if not found then
					if nb1 < nb2 then
						Result := -1
					elseif nb1 /= nb2 then
						Result := 1
					end
				end
			end
		ensure
			equal_zero: (Result = 0) = same_unicode_string (other)
			-- smaller_negative: (Result = -1) = (Current is less than other)
			-- greater_positive: (Result = 1) = (Current is greater than other)
		end

feature -- Element change

	put_unicode (c: UC_CHARACTER; i: INTEGER) is
			-- Replace unicode character at index `i' by `c'.
		require
			valid_index: valid_index (i)
			c_not_void: c /= Void
		do
			put_code (c.code, i)
		ensure
			stable_count: count = old count
			replaced: item_code (i) = c.code
			stable_before_i: substring (1, i - 1).is_equal (old substring (1, i - 1))
			stable_after_i: substring (i + 1, count).is_equal (old substring (i + 1, count))
		end

	put_code (a_code: INTEGER; i: INTEGER) is
			-- Replace unicode character at index `i'
			-- by unicode character of code `a_code'.
		require
			valid_index: valid_index (i)
			valid_item_code: unicode.valid_code (a_code)
		local
			k, nb: INTEGER
			old_count, new_count: INTEGER
			new_byte_count: INTEGER
			a_byte: CHARACTER
		do
			if count = byte_count then
				k := i
				old_count := 1
			else
				k := byte_index (i)
				a_byte := byte_item (k)
				old_count := utf8.encoded_byte_count (a_byte)
			end
			new_count := utf8.code_byte_count (a_code)
			if new_count = old_count then
				-- Do nothing.
			elseif new_count < old_count then
				move_bytes_left (k + old_count, old_count - new_count)
			else
				nb := new_count - old_count
				new_byte_count := byte_count + nb
				if new_byte_count > byte_capacity then
					resize_byte_storage (new_byte_count)
				end
				move_bytes_right (k + old_count, nb)
			end
			put_code_at_byte_index (a_code, new_count, k)
		ensure
			stable_count: count = old count
			replaced: item_code (i) = a_code
			stable_before_i: substring (1, i - 1).is_equal (old substring (1, i - 1))
			stable_after_i: substring (i + 1, count).is_equal (old substring (i + 1, count))
		end

	put (c: CHARACTER; i: INTEGER) is
			-- Replace unicode character at index `i' by character `c'.
			-- (ELKS 2001 STRING)
		local
			k, nb: INTEGER
			a_byte: CHARACTER
			old_count, new_count: INTEGER
			new_byte_count: INTEGER
		do
			if count = byte_count then
				k := i
				old_count := 1
			else
				k := byte_index (i)
				a_byte := byte_item (k)
				old_count := utf8.encoded_byte_count (a_byte)
			end
			new_count := utf8.character_byte_count (c)
			if new_count = old_count then
				-- Do nothing.
			elseif new_count < old_count then
				move_bytes_left (k + old_count, old_count - new_count)
			else
				nb := new_count - old_count
				new_byte_count := byte_count + nb
				if new_byte_count > byte_capacity then
					resize_byte_storage (new_byte_count)
				end
				move_bytes_right (k + old_count, nb)
			end
			put_character_at_byte_index (c, new_count, k)
		ensure then
			unicode_replaced: item_code (i) = c.code
		end

	append_unicode_character (c: UC_CHARACTER) is
			-- Append unicode character `c' at end.
		require
			c_not_void: c /= Void
		do
			append_code (c.code)
		ensure
			new_count: count = old count + 1
			appended: item_code (count) = c.code
			stable_before: substring (1, count - 1).is_equal (old cloned_string)
		end

	append_code (a_code: INTEGER) is
			-- Append unicode character of code `a_code' at end.
		require
			valid_item_code: unicode.valid_code (a_code)
		local
			k, nb: INTEGER
			new_byte_count: INTEGER
		do
			nb := utf8.code_byte_count (a_code)
			k := byte_count + 1
			new_byte_count := byte_count + nb
			if new_byte_count > byte_capacity then
				resize_byte_storage (new_byte_count)
			end
			byte_count := new_byte_count
			set_count (count + 1)
			put_code_at_byte_index (a_code, nb, k)
		ensure
			new_count: count = old count + 1
			appended: item_code (count) = a_code
			stable_before: substring (1, count - 1).is_equal (old cloned_string)
		end

	append_character (c: CHARACTER) is
			-- Append character `c' at end.
			-- (ELKS 2001 STRING)
		local
			k, nb: INTEGER
			new_byte_count: INTEGER
			new_count: INTEGER
		do
				-- Checking if `c' is an ASCII character here and below,
				-- makes this almost 30% faster for the most common case.
			if c <= '%/127/'  then
				nb := 1
			else
				nb := utf8.character_byte_count (c)
			end
			k := byte_count + 1
			new_byte_count := byte_count + nb
			if new_byte_count > byte_capacity then
				resize_byte_storage (new_byte_count)
			end
			byte_count := new_byte_count
				-- And we check here for a single byte as well to get that
				-- 30% improvement.
			if nb = 1 then
				new_count := count + 1
				set_count (byte_count)

				old_put (c, k)







				set_count (new_count)
			else
				set_count (count + 1)
				put_character_at_byte_index (c, nb, k)
			end
		ensure then
			unicode_appended: item_code (count) = c.code
		end

	append_string (a_string: STRING) is
			-- Append a copy of `a_string' at end.
			-- (ELKS 2001 STRING)

		local
			nb: INTEGER
			old_a_string_byte_count: INTEGER
			old_a_string_count: INTEGER
			new_byte_count: INTEGER
			new_count: INTEGER
			a_utf8_string: UC_UTF8_STRING
			a_uc_string: UC_STRING


			b: BOOLEAN

		do

			if ANY_.same_types (a_string, dummy_string) then
					-- Check if string does not contain non-ascii characters.
					-- Unfortunately, this is a slow but necessary call.
				nb := utf8.substring_byte_count (a_string, 1, a_string.count)
				if nb = a_string.count then
						-- If not, we may use the native `append_string'.
						-- Hopefully this one has a fast move.
					new_byte_count := byte_count + nb
					new_count := count + nb
					set_count (byte_count)

					old_set_count (byte_count)
					b := feature {ISE_RUNTIME}.check_assert (False)

					precursor (a_string)

					b := feature {ISE_RUNTIME}.check_assert (b)
					set_count (byte_capacity)
					old_set_count (byte_capacity)

					set_count (new_count)
					byte_count := new_byte_count
				else
						-- If so, use proper UTF8 encoding.
					append_substring (a_string, 1, a_string.count)
				end
			else
				a_uc_string ?= a_string
				if a_uc_string /= Void then
					a_utf8_string ?= a_string
					if a_utf8_string /= Void or ANY_.same_types (a_uc_string, dummy_uc_string) then
							-- Because bytes are in linear order, we may move bytes.
						if a_uc_string = Current then
							new_byte_count := 2 * byte_count
							new_count := 2 * count
							set_count (byte_count)

							old_set_count (byte_count)
							b := feature {ISE_RUNTIME}.check_assert (False)

							precursor (a_string)

							b := feature {ISE_RUNTIME}.check_assert (b)
							set_count (byte_capacity)
							old_set_count (byte_capacity)

							set_count (new_count)
							byte_count := new_byte_count
						else
							old_a_string_count := a_uc_string.count
							old_a_string_byte_count := a_uc_string.byte_count
							new_byte_count := byte_count + old_a_string_byte_count
							new_count := count + old_a_string_count
							a_uc_string.set_count (old_a_string_byte_count)
							set_count (byte_count)

							old_set_count (byte_count)
							b := feature {ISE_RUNTIME}.check_assert (False)

							precursor (a_string)

							b := feature {ISE_RUNTIME}.check_assert (b)
							set_count (byte_capacity)
							old_set_count (byte_capacity)

							set_count (new_count)
							a_uc_string.set_count (old_a_string_count)
							byte_count := new_byte_count
						end
					else
						append_substring (a_string, 1, a_string.count)
					end
				else
					append_substring (a_string, 1, a_string.count)
				end
			end



		end

	append_substring (a_string: STRING; s, e: INTEGER) is
			-- Append substring of `a_string' between indexes
			-- `s' and `e' at end of current string.
		local
			a_substring_count: INTEGER
			k, nb: INTEGER
			new_byte_count: INTEGER
			str: STRING
		do
			a_substring_count := e - s + 1
			if a_substring_count /= 0 then
				if a_string = Current then
					str := cloned_string
				else
					str := a_string
				end
				nb := utf8.substring_byte_count (str, s, e)
				k := byte_count + 1
				new_byte_count := byte_count + nb
				if new_byte_count > byte_capacity then
					resize_byte_storage (new_byte_count)
				end
				byte_count := new_byte_count
				set_count (count + a_substring_count)
				put_substring_at_byte_index (str, s, e, nb, k)
			end
		ensure then
			appended: is_equal (old cloned_string + old a_string.substring (s, e))
		end

	append_utf8 (s: STRING) is
			-- Append UTF-8 encoded string `s' at end of current string.
		require
			s_not_void: s /= Void
			s_is_string: ANY_.same_types (s, "")
			valid_utf8: utf8.valid_utf8 (s)
		local
			i, k, nb: INTEGER
			a_byte: CHARACTER
			j, nb2: INTEGER
			a_count: INTEGER
			new_byte_count: INTEGER
		do
			nb := s.count
			new_byte_count := byte_count + nb
			if new_byte_count > byte_capacity then
				resize_byte_storage (new_byte_count)
			end
			k := byte_count + 1
			byte_count := new_byte_count
			from i := 1 until i > nb loop
				from
					a_count := a_count + 1
					a_byte := s.item (i)
					put_byte (a_byte, k)
					i := i + 1
					k := k + 1
					nb2 := utf8.encoded_byte_count (a_byte)
					j := 1
				until
					j >= nb2
				loop
					put_byte (s.item (i), k)
					i := i + 1
					k := k + 1
					j := j + 1
				end
			end
			set_count (count + a_count)
		end

	append_utf16 (s: STRING) is
			-- Append UTF-16 encoded string `s' at end of current string.
		require
			s_not_void: s /= Void
			s_is_string: ANY_.same_types (s, "")
			valid_utf16: utf16.valid_utf16 (s)
		local
			msb_first: BOOLEAN
			i, nb: INTEGER
			a_most, a_least: INTEGER
			a_low_most, a_low_least: INTEGER
		do
			nb := s.count
			if nb >= 2 then
				if s.item_code (1) = 254 and s.item_code (2) = 255 then
					msb_first := True
					i := 3
				elseif s.item_code (1) = 255 and s.item_code (2) = 254 then
					msb_first := False
					i := 3
				end
			end
			from until i > nb loop
				if msb_first then
					a_most := s.item_code (i)
					a_least := s.item_code (i + 1)
				else
					a_least := s.item_code (i)
					a_most := s.item_code (i + 1)
				end
				if utf16.is_surrogate (a_most) then
					check valid_pre_implies_high: utf16.is_high_surrogate (a_most) end

					check valid_pre_implies_size: i + 2 < nb end
					i := i + 2

					if msb_first then
						a_low_most := s.item_code (i)
						a_low_least := s.item_code (i + 1)
					else
						a_low_least := s.item_code (i)
						a_low_most := s.item_code (i + 1)
					end

					check valid_pre_implies_low: utf16.is_low_surrogate (a_low_most) end
					append_code (utf16.surrogate_from_bytes (a_most, a_least, a_low_most, a_low_least))
				else
					append_code (a_most * 256 + a_least)
				end
				i := i + 2
			end
		end

	fill_with_unicode (c: UC_CHARACTER) is
			-- Replace every character with unicode character `c'.
		require
			c_not_void: c /= Void
		do
			fill_with_code (c.code)
		ensure
			same_count: old count = count
			filled: unicode_occurrences (c) = count
		end

	fill_with_code (a_code: INTEGER) is
			-- Replace every character with unicode character of code `a_code'.
		require
			valid_code: unicode.valid_code (a_code)
		local
			i, nb: INTEGER
			new_byte_count: INTEGER
		do
			reset_byte_index_cache
			nb := utf8.code_byte_count (a_code)
			new_byte_count := nb * count
			if new_byte_count > byte_capacity then
				resize_byte_storage (new_byte_count)
			end
			byte_count := new_byte_count
			from i := 1 until i > new_byte_count loop
				put_code_at_byte_index (a_code, nb, i)
				i := i + nb
			end
		ensure
			same_count: old count = count
			filled: code_occurrences (a_code) = count
		end

	fill_with (c: CHARACTER) is
			-- Replace every character with character `c'.
			-- (ELKS 2001 STRING)
		local
			i, nb: INTEGER
			new_byte_count: INTEGER
		do
			reset_byte_index_cache
			nb := utf8.character_byte_count (c)
			new_byte_count := nb * count
			if new_byte_count > byte_capacity then
				resize_byte_storage (new_byte_count)
			end
			byte_count := new_byte_count
			if nb = 1 then
				from i := 1 until i > new_byte_count loop
					put_byte (c, i)
					i := i + 1
				end
			else
				from i := 1 until i > new_byte_count loop
					put_character_at_byte_index (c, nb, i)
					i := i + nb
				end
			end
		ensure then
			all_code: code_occurrences (c.code) = count
		end

	insert_unicode_character (c: UC_CHARACTER; i: INTEGER) is
			-- Insert unicode character `c' at index `i', shifting
			-- characters between ranks `i' and `count' rightwards.
		require
			c_not_void: c /= Void
			valid_insertion_index: 1 <= i and i <= count + 1
		do
			insert_code (c.code, i)
		ensure
			one_more_character: count = old count + 1
			inserted: item_code (i) = c.code
			stable_before_i: substring (1, i - 1).is_equal (old substring (1, i - 1))
			stable_after_i: substring (i + 1, count).is_equal (old substring (i, count))
		end

	insert_code (a_code: INTEGER; i: INTEGER) is
			-- Insert unicode character of code `a_code'
			-- at index `i', shifting characters between
			-- ranks `i' and `count' rightwards.
		require
			valid_code: unicode.valid_code (a_code)
			valid_insertion_index: 1 <= i and i <= count + 1
		local
			k, nb: INTEGER
			new_byte_count: INTEGER
		do
			if i = count + 1 then
				append_code (a_code)
			else
				if count = byte_count then
					k := i
				else
					k := byte_index (i)
				end
				nb := utf8.code_byte_count (a_code)
				new_byte_count := byte_count + nb
				if new_byte_count > byte_capacity then
					resize_byte_storage (new_byte_count)
				end
				set_count (count + 1)
				move_bytes_right (k, nb)
				put_code_at_byte_index (a_code, nb, k)
			end
		ensure
			one_more_character: count = old count + 1
			inserted: item_code (i) = a_code
			stable_before_i: substring (1, i - 1).is_equal (old substring (1, i - 1))
			stable_after_i: substring (i + 1, count).is_equal (old substring (i, count))
		end

	insert_character (c: CHARACTER; i: INTEGER) is
			-- Insert character `c' at index `i', shifting
			-- characters between ranks `i' and `count' rightwards.
			-- (ELKS 2001 STRING)
		local
			k, nb: INTEGER
			new_byte_count: INTEGER
		do
			if i = count + 1 then
				append_character (c)
			else
				if count = byte_count then
					k := i
				else
					k := byte_index (i)
				end
				nb := utf8.character_byte_count (c)
				new_byte_count := byte_count + nb
				if new_byte_count > byte_capacity then
					resize_byte_storage (new_byte_count)
				end
				set_count (count + 1)
				move_bytes_right (k, nb)
				put_character_at_byte_index (c, nb, k)
			end
		ensure then
			code_inserted: item_code (i) = c.code
		end

	insert_string (a_string: STRING; i: INTEGER) is
			-- Insert `a_string' at index `i', shifting characters between ranks
			-- `i' and `count' rightwards.
			-- (ELKS 2001 STRING)
		require else
			string_not_void: a_string /= Void
			valid_insertion_index: 1 <= i and i <= count + 1
		local
			a_string_count: INTEGER
			k, nb: INTEGER
			new_byte_count: INTEGER
			str: STRING
		do
			a_string_count := a_string.count
			if a_string_count /= 0 then
				if i = count + 1 then
					append_string (a_string)
				else
					if a_string = Current then
						str := cloned_string
					else
						str := a_string
					end
					if count = byte_count then
						k := i
					else
						k := byte_index (i)
					end
					nb := utf8.substring_byte_count (str, 1, a_string_count)
					new_byte_count := byte_count + nb
					if new_byte_count > byte_capacity then
						resize_byte_storage (new_byte_count)
					end
					move_bytes_right (k, nb)
					set_count (count + a_string_count)
					put_substring_at_byte_index (str, 1, a_string_count, nb, k)
				end
			end
		end

	replace_substring (a_string: like Current; start_index, end_index: INTEGER) is
	-- Note: VE 4.1 has 'like Current' in its signature instead
	-- of STRING as specified in ELKS 2001:
	-- replace_substring (a_string: STRING; start_index, end_index: INTEGER) is
			-- Replace the substring from `start_index' to `end_index',
			-- inclusive, with `a_string'.
			-- (ELKS 2001 STRING)
		do
			replace_substring_by_string (a_string, start_index, end_index)
		end

	replace_substring_by_string (a_string: STRING; start_index, end_index: INTEGER) is
			-- Replace the substring from `start_index' to `end_index',
			-- inclusive, with `a_string'.
		local
			a_string_count: INTEGER
			k, nb: INTEGER
			a_range: INTEGER
			old_count, new_count: INTEGER
			new_byte_count: INTEGER
			str: STRING
		do
			a_string_count := a_string.count
			if a_string_count = 0 then
				remove_substring (start_index, end_index)
			else
				if start_index = count + 1 then
					append_string (a_string)
				else
					if a_string = Current then
						str := cloned_string
					else
						str := a_string
					end
					a_range := end_index - start_index + 1
					if count = byte_count then
						k := start_index
						old_count := a_range
					else
						k := byte_index (start_index)
						if end_index < start_index then
							old_count := 0
						elseif end_index = count then
							old_count := byte_count - k + 1
						else
							old_count := shifted_byte_index (k, a_range) - k
						end
					end
					new_count := utf8.substring_byte_count (str, 1, a_string_count)
					if new_count = old_count then
						-- Do nothing.
					elseif new_count < old_count then
						move_bytes_left (k + old_count, old_count - new_count)
					else
						nb := new_count - old_count
						new_byte_count := byte_count + nb
						if new_byte_count > byte_capacity then
							resize_byte_storage (new_byte_count)
						end
						move_bytes_right (k + old_count, nb)
					end
					set_count (count + a_string_count - a_range)
					put_substring_at_byte_index (str, 1, a_string_count, new_count, k)
				end
			end
		end

feature -- Removal

	keep_head (n: INTEGER) is
			-- Remove all the characters except for the first `n';
			-- if `n' > `count', do nothing.
			-- (ELKS 2001 STRING)
		do
			if n = 0 then
				byte_count := 0
				set_count (0)
			elseif n < count then
				if count = byte_count then
					byte_count := n
				else
					byte_count := byte_index (n + 1) - 1
				end
				set_count (n)
			end
		end

	keep_tail (n: INTEGER) is
			-- Remove all the characters except for the last `n';
			-- if `n' > `count', do nothing.
			-- (ELKS 2001 STRING)
		local
			removed_byte_count: INTEGER
		do
			if n = 0 then
				byte_count := 0
				set_count (0)
			elseif n < count then
				if count = byte_count then
					removed_byte_count := byte_count - n
				else
					removed_byte_count := byte_index (count - n + 1) - 1
				end
				move_bytes_left (removed_byte_count + 1, removed_byte_count)
				set_count (n)
			end
		end

	remove_head (n: INTEGER) is
			-- Remove the first `n' characters;
			-- if `n' > `count', remove all.
			-- (ELKS 2001 STRING)
		do
			if n >= count then
				wipe_out
			elseif n /= 0 then
				keep_tail (count - n)
			end
		end

	remove_tail (n: INTEGER) is
			-- Remove the last `n' characters;
			-- if `n' > `count', remove all.
			-- (ELKS 2001 STRING)
		do
			if n >= count then
				wipe_out
			elseif n /= 0 then
				keep_head (count - n)
			end
		end

	remove (i: INTEGER) is
			-- Remove `i'-th character, shifting characters between
			-- ranks i + 1 and `count' leftwards.
			-- (ELKS 2001 STRING)
		local
			k, nb: INTEGER
		do
			if count = byte_count then
				k := i
				nb := 1
			else
				k := byte_index (i)
				nb := utf8.encoded_byte_count (byte_item (k))
			end
			move_bytes_left (k + nb, nb)
			set_count (count - 1)
		end

	remove_substring (start_index, end_index: INTEGER) is
			-- Remove all characters from `start_index'
			-- to `end_index' inclusive.
			-- (ELKS 2001 STRING)
		local
			k, nb: INTEGER
			s: INTEGER
			a_count: INTEGER
		do
			if start_index = end_index then
				remove (start_index)
			elseif start_index < end_index then
				a_count := end_index - start_index + 1
				if count = byte_count then
					k := end_index + 1
					nb := a_count
				else
					s := byte_index (start_index)
					if end_index = count then
						k := byte_count + 1
					else
						k := shifted_byte_index (s, a_count)
					end
					nb := k - s
				end
				move_bytes_left (k, nb)
				set_count (count - a_count)
			end
		end

	wipe_out is
			-- Remove all characters.
			-- (ELKS 2001 STRING)
		do
			byte_count := 0
			set_count (0)
		end

feature -- Duplication

	copy (other: like Current) is
			-- Reinitialize by copying the characters of `other'.
			-- (This is also used by clone.)
			-- (ELKS 2001 STRING)

		local

			other_count: INTEGER





		do
			if other /= Current then

				other_count := other.count
				other.set_count (other.byte_count)
				precursor {STRING} (other)
				set_count (other_count)
				other.set_count (other_count)






















			end
		end

	cloned_string: like Current is
			-- New object equal to `Current'
		do



			Result := twin

		ensure
			twin_not_void: Result /= Void
			is_equal: Result.is_equal (Current)
		end

feature -- Output

	out: STRING is
			-- New STRING containing terse printable representation
			-- of current object; Non-ascii characters are represented
			-- with the %/code/ convention.
			-- (ELKS 2001 STRING)
		local
			i, nb: INTEGER
			a_code: INTEGER
			c: CHARACTER
			max_ascii_char: CHARACTER
			max_ascii_code: INTEGER
		do
			nb := count
			create Result.make (nb)
			if nb = byte_count then
				max_ascii_char := unicode.maximum_ascii_character
				from i := 1 until i > nb loop
					c := byte_item (i)
					if c <= max_ascii_char then
						Result.append_character (c)
					else
						Result.append_character ('%%')
						Result.append_character ('/')
						Result.append_string (c.code.out)
						Result.append_character ('/')
					end
					i := i + 1
				end
			else
				nb := byte_count
				max_ascii_code := unicode.maximum_ascii_character_code
				from i := 1 until i > nb loop
					a_code := item_code_at_byte_index (i)
					if a_code <= max_ascii_code then
						Result.append_character (INTEGER_.to_character (a_code))
					else
						Result.append_character ('%%')
						Result.append_character ('/')
						Result.append_string (a_code.out)
						Result.append_character ('/')
					end
					i := next_byte_index (i)
				end
			end
		end

	debug_output: STRING is
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := out
		end

feature -- Conversion

	as_lower: like Current is
			-- New object with all letters in lower case
			-- (Extended from ELKS 2001 STRING)
		do
			Result := cloned_string
			Result.to_lower
		ensure then
			unicode_anchor: count > 0 implies Result.unicode_item (1).is_equal (unicode_item (1).as_lower)
			unicode_recurse: count > 1 implies Result.substring (2, count).is_equal (substring (2, count).as_lower)
		end

	as_upper: like Current is
			-- New object with all letters in upper case
			-- (Extended from ELKS 2001 STRING)
		do
			Result := cloned_string
			Result.to_upper
		ensure then
			unicode_anchor: count > 0 implies Result.unicode_item (1).is_equal (unicode_item (1).as_upper)
			unicode_recurse: count > 1 implies Result.substring (2, count).is_equal (substring (2, count).as_upper)
		end

	to_lower is
			-- Convert all letters to lower case.
			-- (ELKS 2001 STRING)
		local
			i, nb: INTEGER
			old_count, new_count: INTEGER
			new_byte_count: INTEGER
			a_code, new_code: INTEGER
		do
			nb := byte_count
			from i := 1 until i > nb loop
				a_code := item_code_at_byte_index (i)
				new_code := unicode.lower_code (a_code)
				if new_code /= a_code then
					old_count := utf8.code_byte_count (a_code)
					new_count := utf8.code_byte_count (new_code)
					if new_count = old_count then
						-- Do nothing.
					elseif new_count < old_count then
						move_bytes_left (i + old_count, old_count - new_count)
					else
						nb := new_count - old_count
						new_byte_count := byte_count + nb
						if new_byte_count > byte_capacity then
							resize_byte_storage (new_byte_count)
						end
						move_bytes_right (i + old_count, nb)
					end
					put_code_at_byte_index (new_code, new_count, i)
				end
				i := next_byte_index (i)
			end
		end

	to_upper is
			-- Convert all letters to upper case.
			-- (ELKS 2001 STRING)
		local
			i, nb: INTEGER
			old_count, new_count: INTEGER
			new_byte_count: INTEGER
			a_code, new_code: INTEGER
		do
			nb := byte_count
			from i := 1 until i > nb loop
				a_code := item_code_at_byte_index (i)
				new_code := unicode.upper_code (a_code)
				if new_code /= a_code then
					old_count := utf8.code_byte_count (a_code)
					new_count := utf8.code_byte_count (new_code)
					if new_count = old_count then
						-- Do nothing.
					elseif new_count < old_count then
						move_bytes_left (i + old_count, old_count - new_count)
					else
						nb := new_count - old_count
						new_byte_count := byte_count + nb
						if new_byte_count > byte_capacity then
							resize_byte_storage (new_byte_count)
						end
						move_bytes_right (i + old_count, nb)
					end
					put_code_at_byte_index (new_code, new_count, i)
				end
				i := next_byte_index (i)
			end
		end

	to_utf8: STRING is
			-- New STRING made up of bytes corresponding to
			-- the UTF-8 representation of current string
		local
			i, nb: INTEGER
		do
			nb := byte_count
			create Result.make (nb)
			from i := 1 until i > nb loop
				Result.append_character (byte_item (i))
				i := i + 1
			end
		ensure
			to_utf8_not_void: Result /= Void
			string_type: ANY_.same_types (Result, "")
			valid_utf8: utf8.valid_utf8 (Result)
		end

	as_string: STRING is
			-- STRING version of current string;
			-- Return the UTF8 representation if it is encoded
			-- with UTF8, the UTF16 representation if it is
			-- encoded with UTF16, etc.
		do
			Result := to_utf8
		ensure
			as_string_not_void: Result /= Void
			string_type: ANY_.same_types (Result, "")
		end

feature -- Output stream

	name: STRING is "UC_STRING"
			-- Name of output stream

	eol: STRING is "%N"
			-- Line separator

	is_open_write: BOOLEAN is
			-- Can characters be written to output stream?
		do
			Result := True
		end

	flush is
			-- Do nothing (operation does not apply to string).
		do
		end

feature -- Traversal

	item_code_at_byte_index (i: INTEGER): INTEGER is
			-- Code of character at byte index `i'
		require
			i_large_enough: i >= 1
			i_small_enough: i <= byte_count
			is_encoded_first_byte: is_encoded_first_byte (i)
		local
			k, nb: INTEGER
			a_byte: CHARACTER
		do
			k := i
			a_byte := byte_item (k)
			Result := utf8.encoded_first_value (a_byte)
			nb := k + utf8.encoded_byte_count (a_byte) - 1
			from k := k + 1 until k > nb loop
				a_byte := byte_item (k)
				Result := Result * 64 + utf8.encoded_next_value (a_byte)
				k := k + 1
			end
		ensure
			valid_item_code: unicode.valid_code (Result)
		end

	character_item_at_byte_index (i: INTEGER): CHARACTER is
			-- Character at byte_index `i';
			-- '%U' is the unicode character at byte index
			-- `i' cannot fit into a CHARACTER
		require
			i_large_enough: i >= 1
			i_small_enough: i <= byte_count
			is_encoded_first_byte: is_encoded_first_byte (i)
		local
			a_byte: CHARACTER
			a_code: INTEGER
		do
			a_byte := byte_item (i)
			inspect utf8.encoded_byte_count (a_byte)
			when 1 then
				Result := a_byte
			when 2 then
				a_code := utf8.encoded_first_value (a_byte)
				a_byte := byte_item (i + 1)
				a_code := a_code * 64 + utf8.encoded_next_value (a_byte)
				if a_code <= Platform.Maximum_character_code then
					Result := INTEGER_.to_character (a_code)
				else
						-- Overflow.
					Result := '%U'
				end
			else
				a_code := item_code_at_byte_index (i)
				if a_code <= Platform.Maximum_character_code then
					Result := INTEGER_.to_character (a_code)
				else
						-- Overflow.
					Result := '%U'
				end
			end
		ensure
			code_small_enough: item_code_at_byte_index (i) <= Platform.Maximum_character_code implies Result.code = item_code_at_byte_index (i)
			overflow: item_code_at_byte_index (i) > Platform.Maximum_character_code implies Result = '%U'
		end

	next_byte_index (i: INTEGER): INTEGER is
			-- Byte index of unicode character after character
			-- at byte index `i'; Return 'byte_count + 1' if
			-- character at byte index `i' is the last character
			-- in the string
		require
			i_large_enough: i >= 1
			i_small_enough: i <= byte_count
			is_encoded_first_byte: is_encoded_first_byte (i)
		do
			Result := i + utf8.encoded_byte_count (byte_item (i))
		ensure
			next_byte_index_large_enough: Result > i
			next_byte_index_small_enough: Result <= byte_count + 1
		end

	shifted_byte_index (i: INTEGER; n: INTEGER): INTEGER is
			-- Byte index of unicode character `n' positions after
			-- character at byte index `i'; Return 'byte_count + 1'
			-- if no such character in the string
		require
			i_large_enough: i >= 1
			i_small_enough: i <= byte_count
			is_encoded_first_byte: is_encoded_first_byte (i)
			n_positive: n >= 0
		local
			j: INTEGER
		do
			Result := i
			from j := 1 until j > n loop
				Result := Result + utf8.encoded_byte_count (byte_item (Result))
				if Result > byte_count then
					j := n + 1 -- Jump out of the loop.
				else
					j := j + 1
				end
			end
		ensure
			next_byte_index_large_enough: Result >= i
			next_byte_index_small_enough: Result <= byte_count + 1
		end

	byte_index (i: INTEGER): INTEGER is
			-- Byte index of character at index `i'
		require
			valid_index: valid_index (i)
		local
			j: INTEGER
			a_byte: CHARACTER
		do
			if byte_count = count then
				Result := i
			else
				from
					if i < last_byte_index_input then
						j := 1
						Result := 1
					else
						j := last_byte_index_input
						Result := last_byte_index_result
					end
				invariant
					j <= i
				until
					j = i
				loop
					a_byte := byte_item (Result)
					Result := Result + utf8.encoded_byte_count (a_byte)
					j := j + 1
				end
			end
				-- Save cache.
			last_byte_index_input := i
			last_byte_index_result := Result
		ensure
			byte_index_large_enough: Result >= 1
			byte_index_small_enough: Result <= byte_count
			is_encoded_first_byte: is_encoded_first_byte (Result)
		end

	is_encoded_first_byte (i: INTEGER): BOOLEAN is
			-- Is byte at index `i' the first byte of an encoded unicode character?
		require
			i_large_enough: i >= 1
			i_small_enough: i <= byte_count
		do
			Result := utf8.is_encoded_first_byte (byte_item (i))
		end

feature {UC_STRING} -- Byte index cache

	last_byte_index_input: INTEGER
			-- Last `byte_index' requested
			-- (Cache for 'i := i + 1' iterations and similar)

	last_byte_index_result: INTEGER
			-- Last `byte_index' Result
			-- (Cache for 'i := i + 1' iterations and similar)

	reset_byte_index_cache is
			-- Reset byte index (after write operation for example).
		do
			last_byte_index_input := 1
			last_byte_index_result := 1
		end

feature -- Implementation

	current_string: STRING is
			-- Current string
		do
			Result := Current
		end

feature -- Obsolete

	empty: BOOLEAN is
			-- Is string empty?
		obsolete
			"[011225] Use `is_empty' instead."
		do
			Result := is_empty
		end


	head (n: INTEGER) is
			-- Remove all the characters except for the first `n';
			-- if `n' > `count', do nothing.
		obsolete
			"[020602] Use `keep_head' instead."
		do
			keep_head (n)
		end

	tail (n: INTEGER) is
			-- Remove all the characters except for the last `n';
			-- if `n' > `count', do nothing.
		obsolete
			"[020602] Use `keep_tail' instead."
		do
			keep_tail (n)
		end


	append_uc_string (a_string: UC_STRING) is
			-- Append a copy of `a_string' at end.
		obsolete
			"[011225] Use `append_string' instead."
		require
			a_string_not_void: a_string /= Void
		do
			append_string (a_string)
		end

	append_unicode, append_uc_character (c: UC_CHARACTER) is
			-- Append unicode character `c' at end.
		obsolete
			"[020720] Use `append_unicode_character' instead."
		require
			c_not_void: c /= Void
		do
			append_unicode_character (c)
		end

	insert_unicode (c: UC_CHARACTER; i: INTEGER) is
			-- Insert unicode character `c' at index `i', shifting
			-- characters between ranks `i' and `count' rightwards.
		obsolete
			"[020720] Use `insert_unicode_character' instead."
		require
			c_not_void: c /= Void
			valid_insertion_index: 1 <= i and i <= count + 1
		do
			insert_unicode_character (c, i)
		ensure
			one_more_character: count = old count + 1
			inserted: item_code (i) = c.code
			stable_before_i: substring (1, i - 1).is_equal (old substring (1, i - 1))
			stable_after_i: substring (i + 1, count).is_equal (old substring (i, count))
		end

feature {UC_STRING_HANDLER} -- Implementation






	byte_item (i: INTEGER): CHARACTER is
			-- Byte at index `i'
		require
			i_large_enough: i >= 1
			i_small_enough: i <= byte_count

		local
			old_count: INTEGER

		do

			old_count := count
			set_count (byte_count)
			Result := old_item (i)
			set_count (old_count)







		end

	put_byte (c: CHARACTER; i: INTEGER) is
			-- Replace byte at index `i' by `c'.
		require
			i_large_enough: i >= 1
			i_small_enough: i <= byte_count

		local
			old_count: INTEGER

		do

			old_count := count
			set_count (byte_count)
			old_put (c, i)
			set_count (old_count)







		end

	resize_byte_storage (n: INTEGER) is
			-- Resize space for `n' bytes.
			-- Do not lose previously stored bytes.
		require
			n_large_enough: n >= byte_capacity

		local
			old_count: INTEGER

		do
			if n > byte_capacity then

				resize (n)
				old_count := count
				set_count (n)
				old_set_count (n)
				set_count (old_count)












			end
		ensure
			byte_capacity_set: byte_capacity = n
		end

	move_bytes_right (i, offset: INTEGER) is
			-- Move bytes at and after position `i'
			-- by `offset' positions to the right.
		require
			valid_index: 1 <= i and i <= byte_count + 1
			positive_offset: offset >= 0
			offset_small_enough: offset <= (byte_capacity - byte_count)
		local
			j, nb: INTEGER

			old_count: INTEGER

		do
			if last_byte_index_result > i then
				reset_byte_index_cache
			end
			from

				j := byte_count
				nb := i




				byte_count := byte_count + offset

				old_count := count
				set_count (byte_count)

			until
				j < nb
			loop

				old_put (old_item (j), j + offset)







				j := j - 1
			end

			set_count (old_count)

		ensure
			byte_count_set: byte_count = old byte_count + offset
		end

	move_bytes_left (i, offset: INTEGER) is
			-- Move bytes at and after position `i'
			-- by `offset' positions to the left.
		require
			valid_index: 1 <= i and i <= byte_count + 1
			positive_offset: offset >= 0
			constraint: offset < i
		local
			j, nb: INTEGER

			old_count: INTEGER

		do
			if last_byte_index_result > i - offset then
				reset_byte_index_cache
			end
			from

				j := i
				nb := byte_count





				old_count := count
				set_count (byte_count)

			until
				j > nb
			loop

				old_put (old_item (j), j - offset)







				j := j + 1
			end

			set_count (old_count)

			byte_count := byte_count - offset
		ensure
			byte_count_set: byte_count = old byte_count - offset
		end

	set_byte_count (nb: INTEGER) is
			-- Set `byte_count' to `nb'.
		require
			nb_large_enough: nb >= 0
			nb_small_enough: nb <= byte_capacity
		do
			if last_byte_index_result > nb then
				reset_byte_index_cache
			end
			byte_count := nb
		ensure
			byte_count_set: byte_count = nb
		end

	set_count (nb: INTEGER) is
			-- Set `count' to `nb'.
		require
			nb_positive: nb >= 0




		do
			if last_byte_index_input > nb then
				reset_byte_index_cache
			end









			count := nb

		ensure
			count_set: count = nb
		end

feature {NONE} -- Implementation

	put_code_at_byte_index (a_code: INTEGER; b: INTEGER; i: INTEGER) is
			-- Put unicode character of code `a_code'
			-- at byte index `i'. `b' is the number of
			-- bytes necessary to encode this character.
		require
			i_large_enough: i >= 1
			enough_space: (i + b - 1) <= byte_count
			valid_code: unicode.valid_code (a_code)
		local
			j: INTEGER
			a_byte: CHARACTER
			c: INTEGER
		do
			check
				valid_utf8: b = utf8.code_byte_count (a_code)
			end
			from
				c := a_code
				j := i + b - 1
			until
				j = i
			loop
				a_byte := INTEGER_.to_character ((c \\ 64) + 128)
				put_byte (a_byte, j)
				c := c // 64
				j := j - 1
			end
				-- Write first byte.
			inspect b
			when 1 then
					-- 0xxxxxxx
				a_byte := INTEGER_.to_character (c)
			when 2 then
					-- 110xxxxx
				a_byte := INTEGER_.to_character (c + 192)
			when 3 then
					-- 1110xxxx
				a_byte := INTEGER_.to_character (c + 224)
			when 4 then
					-- 11110xxx
				a_byte := INTEGER_.to_character (c + 240)
			when 5 then
					-- 111110xx
				a_byte := INTEGER_.to_character (c + 248)
			when 6 then
					-- 1111110x
				a_byte := INTEGER_.to_character (c + 252)
			end
			put_byte (a_byte, i)
		end

	put_character_at_byte_index (c: CHARACTER; b: INTEGER; i: INTEGER) is
			-- Put character `c' at byte index `i'.
			-- `b' is the number of bytes necessary to encode `c'.
		require
			i_large_enough: i >= 1
			enough_space: (i + b - 1) <= byte_count
		local
			a_byte: CHARACTER
			a_code: INTEGER
		do
			check
				valid_utf8: b = utf8.character_byte_count (c)
			end
			inspect b
			when 1 then
					-- 0xxxxxxx
				put_byte (c, i)
			when 2 then
					-- 110xxxxx 10xxxxxx
				a_code := c.code
				a_byte := INTEGER_.to_character ((a_code // 64) + 192)
				put_byte (a_byte, i)
				a_byte := INTEGER_.to_character ((a_code \\ 64) + 128)
				put_byte (a_byte, i + 1)
			else
				put_code_at_byte_index (c.code, b, i)
			end
		end

	put_substring_at_byte_index (a_string: STRING; start_index, end_index, b: INTEGER; i: INTEGER) is
			-- Put characters of `a_string' between `start_index'
			-- and `end_index' at byte index `i'. `b' is the number
			-- of bytes necessary to encode these characters.
		require
			a_string_not_void: a_string /= Void
			a_string_not_current: a_string /= Current
			valid_start_index: 1 <= start_index
			valid_end_index: end_index <= a_string.count
			meaningful_interval: start_index <= end_index + 1
			i_large_enough: i >= 1
			enough_space: (i + b - 1) <= byte_count
		local
			j, nb: INTEGER
			k, z: INTEGER
			c: CHARACTER
			a_code: INTEGER
			a_utf8_string: UC_UTF8_STRING
			a_uc_string: UC_STRING
		do
			check
				valid_utf8: b = utf8.substring_byte_count (a_string, start_index, end_index)
			end
			if b > 0 then
				if ANY_.same_types (a_string, dummy_string) then
					nb := end_index - start_index + 1
					if nb = b then
						k := i
						from j := start_index until j > end_index loop
							put_byte (a_string.item (j), k)
							k := k + 1
							j := j + 1
						end
					else
						k := i
						from j := start_index until j > end_index loop
							c := a_string.item (j)
							z := utf8.character_byte_count (c)
							put_character_at_byte_index (c, z, k)
							k := k + z
							j := j + 1
						end
					end
				elseif ANY_.same_types (a_string, Current) then
					a_uc_string ?= a_string
					check is_uc_string: a_uc_string /= Void end
					k := i
					j := a_uc_string.byte_index (start_index)
					nb := j + b - 1
					from until j > nb loop
						put_byte (a_uc_string.byte_item (j), k)
						k := k + 1
						j := j + 1
					end
				else
					a_utf8_string ?= a_string
					if a_utf8_string /= Void then
						k := i
						j := a_utf8_string.byte_index (start_index)
						nb := j + b - 1
						from until j > nb loop
							put_byte (a_utf8_string.byte_item (j), k)
							k := k + 1
							j := j + 1
						end
					else
						a_uc_string ?= a_string
						if a_uc_string /= Void then
							k := i
							j := a_uc_string.byte_index (start_index)
							nb := j + b - 1
							from until j > nb loop
								a_code := a_uc_string.item_code_at_byte_index (j)
								z := utf8.code_byte_count (a_code)
								put_code_at_byte_index (a_code, z, k)
								k := k + z
								j := a_uc_string.next_byte_index (j)
							end
						else
							k := i
							from j := start_index until j > end_index loop
								a_code := a_string.item_code (j)
								z := utf8.code_byte_count (a_code)
								put_code_at_byte_index (a_code, z, k)
								k := k + z
								j := j + 1
							end
						end
					end
				end
			end
		end

	dummy_string: STRING is ""
			-- Dummy string

	dummy_uc_string: UC_STRING is
			-- Dummy Unicode string
		once
			create Result.make_empty
		ensure
			dummy_uc_string_not_void: Result /= Void
		end



































feature {NONE} -- Inapplicable

































	old_wipe_out is
			-- Remove all characters.
			-- (ELKS 2001 STRING)
		do
				-- Preserve postcondition inherited from STRING.
			count := 0
			precursor
			wipe_out
		end

	old_clear_all is
			-- Remove all characters.
		do
			wipe_out
		end

	old_left_adjust is
			-- Remove leading whitespace.
		local
			i, nb: INTEGER
		do
			nb := count
			from i := 1 until i > nb loop
				inspect item (i)
				when ' ', '%T', '%R', '%N' then
					i := i + 1
				else
						-- Jump out of the loop.
					nb := 0
				end
			end
			remove_head (i - 1)
		end

	old_right_adjust is
			-- Remove trailing whitespace.
		local
			i, nb: INTEGER
		do
			nb := count
			from i := 1 until i > nb loop
				inspect item (nb)
				when ' ', '%T', '%R', '%N' then
					nb := nb - 1
				else
						-- Jump out of the loop.
					i := nb + 1
				end
			end
			keep_head (nb)
		end



invariant

	non_negative_byte_count: byte_count >= 0
	byte_count_small_enough: byte_count <= byte_capacity
	count_small_enough: count <= byte_count




end
