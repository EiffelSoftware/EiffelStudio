indexing
	description: "[
				mute_escape_characters is used to insert escape character in the front of every meta-character."	
				The following is cited from RX_PCRE_MATCHER library.
				-- There are two different sets of meta-characters: those  that
				-- are  recognized anywhere in the pattern except within square
				-- brackets, and those that are recognized in square  brackets.
				-- Outside square brackets, the meta-characters are as follows:
				--   \      general escape character with several uses
				--   ^      assert start of subject (or line, in multiline mode)
				--   $      assert end of subject (or line, in multiline mode)
				--   .      match any character except newline (by default)
				--   [      start character class definition
				--   |      start of alternative branch
				--   (      start subpattern
				--   )      end subpattern
				--   ?      extends the meaning of (
				--          also 0 or 1 quantifier
				--          also quantifier minimizer
				--   *      0 or more quantifier
				--   +      1 or more quantifier
				--   {      start min/max quantifier
				--
				-- Part of a pattern that is in square  brackets  is  called  a
				-- "character  class".  In  a  character  class  the only meta-
				-- characters are:
				--   \      general escape character
				--   ^      negate the class, but only if the first character
				--   -      indicates character range
				--   ]      terminates the character class
			build_match_whole_word is used to build a string with '\b' started and ended
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Tedf"
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_FORMATTER

feature -- Path building

	extend_file_path (a_path: FILE_NAME; file_name: STRING): FILE_NAME is
			-- Make new file path, if no diretory seperator at the end of a_path, add one.
		local
			s: STRING
		do
			s := a_path.out
			if s.item_code (s.count) /= operating_environment.directory_separator.code then
				s.append_character (operating_environment.directory_separator)
			end
			s.append (file_name)
			create Result.make_from_string (s)
		end

feature -- Muter action

	mute_escape_characters (string: STRING_32): STRING_32 is
			-- Mute all escape characters in input string
		require
			string_not_void: string /= Void
		local
			l_item_string: STRING_32
			l_string: STRING_32
		do
			create l_string.make_from_string (string)
			from
				mute_characters.start
			until
				mute_characters.after
			loop
				l_item_string := mute_characters.item
				l_string.replace_substring_all (l_item_string, ("\").as_string_32 + l_item_string)
				mute_characters.forth
			end
			Result := l_string
		end

	build_match_whole_word (p_string: STRING_32): STRING_32 is
			-- Make the p_string starts and ends with "\b"
		require
			p_string_not_void: p_string /= Void
		local
			l_string: STRING_32
		do
			create l_string.make_from_string (p_string)
			l_string.insert_string ("\b",1)
			l_string.append ("\b")
			Result := l_string
		ensure
			build_match_whole_word_not_void: Result /= Void
		end

	replace_RNT_to_space (p_string: STRING_32): STRING_32 is
			-- replace all RNT in p_string to spaces
		require
			p_string_not_void: p_string /= Void
		local
			l_string: STRING_32
		do
			create l_string.make_from_string (p_string)
			l_string.replace_substring_all ("%R"," ")
			l_string.replace_substring_all ("%N"," ")
			l_string.replace_substring_all ("%T"," ")
			Result := l_string
		end

feature -- Status report

	occurrences_in_bound (c: CHARACTER_32; s: STRING_32; start_pos: INTEGER; end_pos: INTEGER) : INTEGER is
			-- count c occurrence in s between start_pos and end_pos
		local
			l_s: STRING_32
		do
			l_s := s.substring (start_pos, end_pos)
			Result := l_s.occurrences (c)
		end

feature {NONE} -- Implementation

	mute_characters: ARRAYED_LIST [STRING] is
			-- Contains all meta-characters
		local
			l_arrayed_list: ARRAYED_LIST [STRING]
		once
			create l_arrayed_list.make (12)
			l_arrayed_list.extend ("\")
			l_arrayed_list.extend ("^")
			l_arrayed_list.extend ("$")
			l_arrayed_list.extend (".")
			l_arrayed_list.extend ("[")
			l_arrayed_list.extend ("|")
			l_arrayed_list.extend ("(")
			l_arrayed_list.extend (")")
			l_arrayed_list.extend ("?")
			l_arrayed_list.extend ("*")
			l_arrayed_list.extend ("+")
			l_arrayed_list.extend ("{")
			Result := l_arrayed_list
		end

invariant
	invariant_clause: True -- Your invariant here
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
