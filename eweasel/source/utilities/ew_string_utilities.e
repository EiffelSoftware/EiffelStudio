indexing
	description: "String manipulation utilities"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "93/08/30"

class EW_STRING_UTILITIES

feature -- Character properties

	is_white (c: CHARACTER): BOOLEAN is
			-- Is `c' a white space character?
		do
			Result := c = ' ' or c = '%T' or c = '%R' or c = '%N';
		end;

	is_identifier_char (c: CHARACTER): BOOLEAN is
			-- Is `c' an identifier character?
		do
			Result := (c >= 'A' and c <= 'Z') or
				(c >= 'a' and c <= 'z') or
				(c >= '0' and c <= '9') or
				(c = '_');
		end;

feature -- String properties

	is_integer (s: STRING): BOOLEAN is
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

	is_prefix (s, t: STRING): BOOLEAN is
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

	first_white_position (s: STRING): INTEGER is
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
				
	empty_strings_removed (list: LIST [STRING]): DYNAMIC_LIST [STRING] is
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
				
	trim_white_space (list: LIST [STRING]) is
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
				
	broken_into_words (line: STRING): DYNAMIC_LIST [STRING] is
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

	broken_at (line: STRING; sep_char: CHARACTER): DYNAMIC_LIST [STRING] is
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
	
	leading_args_removed (line: STRING n: INTEGER): STRING is
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

indexing
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
