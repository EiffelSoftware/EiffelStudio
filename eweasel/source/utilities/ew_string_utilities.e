note
	description: "String manipulation utilities"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/08/30"

class EW_STRING_UTILITIES

feature -- Character properties

	is_white (c: CHARACTER): BOOLEAN
			-- Is `c' a white space character?
		do
			Result := c = ' ' or c = '%T' or c = '%R' or c = '%N';
		end;

	is_identifier_char (c: CHARACTER): BOOLEAN
			-- Is `c' an identifier character?
		do
			Result := (c >= 'A' and c <= 'Z') or
				(c >= 'a' and c <= 'z') or
				(c >= '0' and c <= '9') or
				(c = '_');
		end;

feature -- String properties

	is_integer (s: STRING): BOOLEAN
			-- Does `s' represent a valid integer?
		require
			string_not_void: s /= Void
		local
			pos: INTEGER;
			failure: BOOLEAN;
			char: CHARACTER;
		do
			if s.count = 0 then
				failure := True;
			else
				char := s.item (1);
				if char = '+' or char = '-' then
					pos := 2
				else
					pos := 1;
				end
			end;

			if pos > s.count then
				failure := True;
			end;

			from
			until
				pos > s.count or failure
			loop
				char := s.item (pos);
				if char < '0' or char > '9' then
					failure := True;
				else
					pos := pos + 1;
				end
			end;
			Result := not failure;
		end;

	is_prefix (s, t: STRING): BOOLEAN
			-- Is `s' a prefix of `t'?
		require
			string1_not_void: s /= Void;
			string2_not_void: t /= Void;
		local
			pos, count: INTEGER
		do
			from
				count := s.count;
				Result := count <= t.count
			until
				pos = count or not Result
			loop
				pos := pos + 1;
				Result := s.item (pos) = t.item (pos)
			end
		end;

	first_white_position (s: STRING): INTEGER
			-- Position of first white space character in
			-- `s' or 0 if no white space characters.
		require
			string_not_void: s /= Void
		local
			pos: INTEGER;
			found: BOOLEAN;
			char: CHARACTER;
		do
			from
				pos := 1;
			until
				pos > s.count or found
			loop
				char := s.item (pos);
				if is_white (char) then
					found := True;
				else
					pos := pos + 1;
				end
			end;
			if found then
				Result := pos;
			else
				Result := 0;
			end
		ensure
			nonnegative_result: Result >= 0;
		end;

feature -- String list routines

	empty_strings_removed (list: LIST [STRING]): DYNAMIC_LIST [STRING]
			-- `list' with all elements which are empty strings
			-- or are Void removed
		require
			list_not_void: list /= Void
		local
			item: STRING;
			res: ARRAYED_LIST [STRING]; -- ??? Temp due to bug
		do
			from
				create res.make (list.count);
				Result := res;
				list.start
			until
				list.after
			loop
				item := list.item;
				if item /= Void and then item.count > 0 then
					Result.extend (item);
				end;
				list.forth;
			end;
		ensure
			result_not_void: Result /= Void;
		end;

	trim_white_space (list: LIST [STRING])
			-- Remove leading and trailing blanks
			-- from each string in `list'
		require
			list_not_void: list /= Void
		local
			item: STRING;
		do
			from
				list.start
			until
				list.after
			loop
				item := list.item;
				if item /= Void then
					item.left_adjust;
					item.right_adjust;
				end;
				list.forth;
			end;
		end;

	broken_into_words (line: STRING): DYNAMIC_LIST [STRING]
			-- Result of breaking `line' into words, where each
			-- word is terminated by white space
		require
			line_exists: line /= Void;
		local
			pos, first, last: INTEGER;
			word: STRING;
			char: CHARACTER;
			in_word, is_white_char: BOOLEAN;
		do
			from
				create {ARRAYED_LIST [STRING]} Result.make (4)
				pos := 1;
			until
				pos > line.count
			loop
				char := line.item (pos);
				is_white_char := is_white (char);
				if in_word then
					if is_white_char then
						in_word := False;
						last := pos - 1;
						create word.make (last - first + 1);
						word.set (line, first, last);
						Result.extend (word);
					end
				else
					if not is_white_char then
						in_word := True;
						first := pos;
					end
				end;
				pos := pos + 1;
			end;
			if in_word then
				last := pos - 1;
				create word.make (last - first + 1);
				word.set (line, first, last);
				Result.extend (word);
			end
		end;

	broken_into_arguments (line: STRING): DYNAMIC_LIST [STRING]
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
			l_line: STRING
			l_quote1, l_quote2: INTEGER
			l_word_list: DYNAMIC_LIST [STRING]
			l_done: BOOLEAN
		do
			l_line := line.twin

			from
				create {ARRAYED_LIST [STRING]} Result.make (8)
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
		end;

	broken_at (line: STRING; sep_char: CHARACTER): DYNAMIC_LIST [STRING]
			-- Result of breaking `line' into strings separated
			-- by character `char'.  Empty strings resulting
			-- from two consecutive occurrences of `char' are
			-- retained.
		require
			line_exists: line /= Void;
		local
			pos, count, first, last: INTEGER;
			phrase: STRING;
			char: CHARACTER;
		do
			from
				create {LINKED_LIST [STRING]} Result.make;
				pos := 1;
				first := 1;
				count := line.count;
			until
				pos > count
			loop
				char := line.item (pos);
				if char = sep_char then
						last := pos - 1;
						create phrase.make (last - first + 1);
						phrase.set (line, first, last);
						Result.extend (phrase);
						first := pos + 1;
				end;
				pos := pos + 1;
			end;
			if first <= count then
				last := pos - 1;
				create phrase.make (last - first + 1);
				phrase.set (line, first, last);
				Result.extend (phrase);
			end
		end;

	merged_with_separator (a_strings: LIST [STRING]; a_separator: STRING): STRING
			-- Result of concatenating all the strings in `a_strings',
			-- separated by `a_separator'.
		do
			create Result.make_empty

			if attached a_strings and then not a_strings.is_empty then
				across a_strings as ic loop
					Result.append (ic.item + a_separator)
				end
				Result.remove_tail (a_separator.count)
			end
		end

	leading_args_removed (line: STRING n: INTEGER): STRING
			-- `line' with the first `n' white-space delimited
			-- arguments removed
		require
			line_not_void: line /= Void
			count_nonnegative: n >= 0
		local
			k, pos: INTEGER
		do
			Result := line.twin
			Result.left_adjust
			Result.right_adjust
			from
				k := 1
			until
				k > n
			loop
				pos :=  first_white_position (Result);
				if pos <= 0 then
					Result.keep_head (0)
				else
					Result := Result.substring (pos, Result.count);
					Result.left_adjust
				end
				k := k + 1
			end
		ensure
			result_exists: Result /= Void
		end

note
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
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
