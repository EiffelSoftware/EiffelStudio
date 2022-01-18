note
	description: "Helper class to create Boogie code."

class
	E2B_BOOGIE_TEXT

inherit

	ANY
		redefine
			default_create,
			out
		end

feature {NONE} -- Initialization

	default_create
			-- <Precursor>
		do
			create internal_string.make (1024)
		ensure then
			string_empty: string.is_empty
			no_indentation: indentation_level = 0
		end

feature -- Access

	string: attached STRING
			-- String representation of Boogie text.
		do
			Result := internal_string.twin
		end

	indentation_level: INTEGER
			-- Indentation level.

	indentation_string: attached STRING
			-- String for indentation.
		do
			create Result.make_filled (' ', indentation_level * 2)
		end

	out: attached STRING
			-- <Precursor>
		do
			Result := internal_string.twin
		end

feature -- Basic operations

	append_text (a_text: E2B_BOOGIE_TEXT)
			-- Append `a_text'.
		require
			a_text_attached: attached a_text
		local
			l_string: STRING
		do
			l_string := a_text.string
			if not l_string.is_empty then
				if l_string.ends_with ("%N") then
					l_string.remove_tail (1)
				end
				across
					a_text.string.split ('%N') as l
				loop
					if l.ends_with (":") and indentation_level > 0 then
						unindent
						put_line ("  " + l)
						indent
					else
						put_line (l)
					end
				end
			end
		end

	put (a_string: READABLE_STRING_8)
			-- Append `a_string'.
		require
			a_string_attached: attached a_string
		do
			internal_string.append (a_string)
		ensure
--			a_string_added: string.ends_with (a_string)
		end

	put_literal_string (s: READABLE_STRING_8)
			-- Append string `s` making sure it can be read back.
		require
			s_attached: attached s
			only_regular_spaces: across s as c all c.is_space implies c = ' ' end
		local
			e: STRING
		do
			if s.has (' ') then
				e := s.to_string_8
				if e = s then
					e := e.twin
				end
					-- Replace all spaces with no-break space.
				e.replace_substring_all (" ", "%/194/%/160/")
				internal_string.append (e)
			else
				internal_string.append (s)
			end
		end

	put_comment_line (a_comment: STRING)
			-- Append comment `a_comment' and start a new line.
		require
			a_string_attached: attached a_comment
		do
			put (indentation_string)
			put ("// ")
			put (a_comment)
			put_new_line
		end

	put_line (a_line: STRING)
			-- Append `a_line' and start a new line.
		require
			a_string_attached: attached a_line
		do
			put (indentation_string)
			put (a_line)
			put_new_line
		end

	put_new_line
			-- Append a new line.
		do
			internal_string.append_character ('%N')
		end

	put_indentation
			-- Append indentation string.
		do
			put (indentation_string)
		end

	indent
			-- Add an indentation level.
		do
			indentation_level := indentation_level + 1
		ensure
			indentation_level_increased: indentation_level = old indentation_level + 1
		end

	unindent
			-- Remove an indentation level.
		require
			has_indentation: indentation_level > 0
		do
			indentation_level := indentation_level - 1
		ensure
			indentation_level_decreased: indentation_level = old indentation_level - 1
		end

	wipe_out
			-- Clear text.
		do
			internal_string.wipe_out
		ensure
			string_cleared: string.is_empty
		end

feature -- Boogie commands

	put_label (a_label: STRING)
			-- Put label `a_label'.
		do
			put_line (a_label + ":")
		end

	put_goto (a_labels: ARRAY [STRING])
			-- Put goto to labes in `a_labels'.
		require
			not_empty: not a_labels.is_empty
		local
			l_text: STRING
			i: INTEGER
		do
			l_text := "goto "
			from
				i := 1
			until
				i > a_labels.count
			loop
				l_text.append (a_labels.item (i))
				if i /= a_labels.count then
					l_text.append (", ")
				end
				i := i + 1
			end
			put_line (l_text + ";")
		end

	put_assume (a_expression: STRING)
			-- Put assume with expression `a_expression'.
		do
			put_line ("assume (" + a_expression + ");")
		end

	put_assume_not (a_expression: STRING)
			-- Put assume with negated expression `a_expression'.
		do
			put_line ("assume (!(" + a_expression + "));")
		end

feature {NONE} -- Implementation

	internal_string: attached STRING
			-- String used internally.

;note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
