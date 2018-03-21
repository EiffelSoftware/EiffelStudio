note
	description: "String manipulation utilities"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class EW_STRING_UTILITIES

inherit
	UTF_CONVERTER

feature {NONE} -- Character properties

	is_white (c: CHARACTER): BOOLEAN
			-- Is `c' a white space character?
		do
			Result := c = ' ' or c = '%T' or c = '%R' or c = '%N'
		end

	is_identifier_char (c: CHARACTER_32): BOOLEAN
			-- Is `c' an identifier character?
		do
			inspect
				c
			when
				{CHARACTER_32} 'A' .. {CHARACTER_32} 'Z',
				{CHARACTER_32} 'a' .. {CHARACTER_32} 'z',
				{CHARACTER_32} '0' .. {CHARACTER_32} '9',
				{CHARACTER_32} '_'
			then
				Result := True
			else
					-- Result := False
			end
		end

feature {NONE} -- String properties

	is_prefix (s, t: STRING): BOOLEAN
			-- Is `s' a prefix of `t'?
		require
			string1_not_void: s /= Void;
			string2_not_void: t /= Void;
		local
			pos, count: INTEGER
		do
			from
				count := s.count
				Result := count <= t.count
			until
				pos = count or not Result
			loop
				pos := pos + 1
				Result := s.item (pos) = t.item (pos)
			end
		end

	first_white_position (s: READABLE_STRING_32): INTEGER
			-- Position of first white space character in
			-- `s' or 0 if no white space characters.
		require
			string_not_void: s /= Void
		local
			n: like {READABLE_STRING_32}.count
		do
			from
				Result := 1
				n := s.count
			until
				Result > n or else s [Result].is_space
			loop
				Result := Result + 1
			end
			if Result > n then
				Result := 0
			end
		ensure
			nonnegative_result: Result >= 0
		end

	first_white_position_8 (s: STRING): INTEGER
			-- Position of first white space character in
			-- `s' or 0 if no white space characters.
		require
			string_not_void: s /= Void
		local
			pos: INTEGER
			found: BOOLEAN
		do
			from
				pos := 1
			until
				pos > s.count or found
			loop
				if is_white (s.item (pos)) then
					found := True
				else
					pos := pos + 1
				end
			end
			if found then
				Result := pos
			else
				Result := 0
			end
		ensure
			nonnegative_result: Result >= 0
		end

feature -- String list routines

	empty_strings_removed (list: LIST [STRING_32]): DYNAMIC_LIST [STRING_32]
			-- `list' with all elements which are empty strings
			-- or are Void removed
		require
			list_not_void: list /= Void
		do
			create {ARRAYED_LIST [STRING_32]} Result.make (list.count)
			across
				list as l
			loop
				if attached l.item as item and then not item.is_empty then
					Result.extend (item)
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	trim_white_space (list: LIST [STRING_32])
			-- Remove leading and trailing blanks
			-- from each string in `list'
		require
			list_not_void: list /= Void
		do
			across
				list as l
			loop
				if attached l.item as item then
					item.adjust
				end
			end
		end

	broken_into_words (line: READABLE_STRING_32): DYNAMIC_LIST [READABLE_STRING_32]
			-- Result of breaking `line' into words, where each
			-- word is terminated by white space
		require
			line_exists: line /= Void;
		local
			pos, first, last: INTEGER
			word: STRING_32
			in_word, is_white_char: BOOLEAN
		do
			from
				create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (4)
				pos := 1
			until
				pos > line.count
			loop
				is_white_char := line [pos].is_space
				if in_word then
					if is_white_char then
						in_word := False
						last := pos - 1
						create word.make (last - first + 1)
						word.set (line, first, last)
						Result.extend (word)
					end
				else
					if not is_white_char then
						in_word := True
						first := pos
					end
				end
				pos := pos + 1
			end
			if in_word then
				last := pos - 1
				create word.make (last - first + 1)
				word.set (line, first, last)
				Result.extend (word)
			end
		end

	broken_into_words_8 (line: STRING): DYNAMIC_LIST [STRING]
			-- Result of breaking `line' into words, where each
			-- word is terminated by white space
		require
			line_exists: line /= Void;
		local
			pos, first, last: INTEGER
			word: STRING
			in_word, is_white_char: BOOLEAN
		do
			from
				create {ARRAYED_LIST [STRING]} Result.make (4)
				pos := 1
			until
				pos > line.count
			loop
				is_white_char := line [pos].is_space
				if in_word then
					if is_white_char then
						in_word := False
						last := pos - 1
						create word.make (last - first + 1)
						word.set (line, first, last)
						Result.extend (word)
					end
				else
					if not is_white_char then
						in_word := True
						first := pos
					end
				end
				pos := pos + 1
			end
			if in_word then
				last := pos - 1
				create word.make (last - first + 1)
				word.set (line, first, last)
				Result.extend (word)
			end
		end

	broken_into_arguments (line: READABLE_STRING_32): DYNAMIC_LIST [READABLE_STRING_32]
			-- Result of breaking `line' into arguments.
			-- Arguments are separated by whitespace.
			-- Multi-word arguments are specified
			-- by wrapping them in double quotes.
			-- If the line contains an odd number of
			-- double quotes characters, the last
			-- occurrence is ignored
		require
			line_exists: line /= Void;
		local
			l_line: STRING_32
			l_quote1, l_quote2: INTEGER
			l_word_list: DYNAMIC_LIST [READABLE_STRING_32]
			l_done: BOOLEAN
		do
			create l_line.make_from_string (line)
			from
				create {ARRAYED_LIST [READABLE_STRING_32]} Result.make (8)
			until
				l_done
			loop
				l_quote1 := l_line.index_of ('%"', 1)
				if l_quote1 = 0 then
					l_quote2 := 0
				else
					l_quote2 := l_line.index_of ('%"', l_quote1 + 1)
				end
				if l_quote1 = 0 or l_quote2 = 0 then
						-- We have zero or one double quotes characters ahead, ignore them.
					l_word_list := broken_into_words (l_line)
					Result.merge_right (l_word_list)
					l_done := true
				else
						-- We have at least one block wrapped by double quotes.
					l_word_list := broken_into_words (l_line.head (l_quote1 - 1))
					Result.merge_right (l_word_list)
					Result.extend (l_line.substring (l_quote1 + 1, l_quote2 - 1))
					Result.finish
					l_line.remove_head (l_quote2)
				end
			end
		end

	broken_at (line: READABLE_STRING_32; sep_char: CHARACTER_32): DYNAMIC_LIST [STRING_32]
			-- Result of breaking `line' into strings separated
			-- by character `char'.  Empty strings resulting
			-- from two consecutive occurrences of `char' are
			-- retained.
		require
			line_exists: line /= Void
		local
			pos, count, first, last: INTEGER
			phrase: STRING_32
			char: CHARACTER_32
		do
			from
				create {LINKED_LIST [STRING_32]} Result.make
				pos := 1
				first := 1
				count := line.count
			until
				pos > count
			loop
				char := line.item (pos)
				if char = sep_char then
						last := pos - 1
						create phrase.make (last - first + 1)
						phrase.set (line, first, last)
						Result.extend (phrase)
						first := pos + 1
				end
				pos := pos + 1
			end
			if first <= count then
				last := pos - 1
				create phrase.make (last - first + 1)
				phrase.set (line, first, last)
				Result.extend (phrase)
			end
		end

	merged_with_separator (a_strings: LIST [READABLE_STRING_32]; a_separator: READABLE_STRING_32): STRING_32
			-- Result of concatenating all the strings in `a_strings',
			-- separated by `a_separator'.
		do
			create Result.make_empty
			if attached a_strings and then not a_strings.is_empty then
				across a_strings as ic loop
					if not ic.is_first then
						Result.append (a_separator)
					end
					Result.append (ic.item)
				end
			end
		end

	leading_args_removed (line: READABLE_STRING_32 n: INTEGER): STRING_32
			-- `line' with the first `n' white-space delimited
			-- arguments removed
		require
			line_not_void: line /= Void
			count_nonnegative: n >= 0
		local
			k, pos: INTEGER
		do
			create Result.make_from_string (line)
			Result.adjust
			from
				k := 1
			until
				k > n
			loop
				pos :=  first_white_position (Result)
				if pos <= 0 then
					Result.keep_head (0)
				else
					Result := Result.substring (pos, Result.count)
					Result.left_adjust
				end
				k := k + 1
			end
		ensure
			result_exists: Result /= Void
		end

	leading_args_removed_8 (line: READABLE_STRING_8; n: INTEGER): STRING
			-- `line' with the first `n' white-space delimited
			-- arguments removed
		require
			line_not_void: line /= Void
			count_nonnegative: n >= 0
		local
			k, pos: INTEGER
		do
			create Result.make_from_string (line)
			Result.adjust
			from
				k := 1
			until
				k > n
			loop
				pos :=  first_white_position_8 (Result)
				if pos <= 0 then
					Result.keep_head (0)
				else
					Result := Result.substring (pos, Result.count)
					Result.left_adjust
				end
				k := k + 1
			end
		ensure
			result_exists: Result /= Void
		end

feature {NONE} -- Conversion

	from_utf_8 (s: READABLE_STRING_8): READABLE_STRING_32
			-- A string built from UTF-8 string `s`.
		do
			Result := utf_8_string_8_to_string_32 (s)
		end

	to_utf_8 (s: READABLE_STRING_32): READABLE_STRING_8
			-- UTF-8 encoding of `s`.
		do
			Result := string_32_to_utf_8_string_8 (s)
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "[
			Copyright (c) 1984-2018, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
			]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"

end
