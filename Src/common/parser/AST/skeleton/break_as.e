indexing
	description: "Object that represents a break AST node"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BREAK_AS

inherit
	LEAF_AS
		redefine
			is_separator, literal_text
		end

create
	make, make_with_data

feature -- Initialization

	make (a_scn: EIFFEL_SCANNER) is
			-- Create an comment object using information included in `a_scn'.
			-- `l', `c', `p', `s' are positions. See `make_with_location' for more information.
		require
			a_scn_not_void: a_scn /= Void
		do
			set_internal_text (a_scn.text)
			make_with_location (a_scn.line, a_scn.column, a_scn.position, a_scn.text_count)
		end

	make_with_data (a_text: STRING; l, c, p, s: INTEGER) is
			-- Create an comment object with `a_text' as literal text of this comment in source code.
			-- `l', `c', `p', `s' are positions. See `make_with_location' for more information.
		require
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		do
			set_internal_text (a_text.string)
			make_with_location (l, c, p, s)
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
		do
		end

feature -- Visitor

	process (v: AST_VISITOR) is
		do
			v.process_break_as (Current)
		end

feature -- Separator

	is_separator: BOOLEAN is
			-- Is current leaf AST node a separator (break or semicolon)?
		do
			Result := True
		end

feature -- Text

	literal_text (a_list: LEAF_AS_LIST): STRING is
			-- Literal text of current AST node
		require else
			a_list_can_be_void: a_list = Void
		do
			Result := internal_text
		end

feature -- Comment extraction

	has_comment: BOOLEAN is
			-- Doese current node has comment?
		do
			Result := internal_text.index_of ('-', 1) > 0
		end

	extract_comment: EIFFEL_COMMENTS is
			-- Extract comment lines in current.
		local
			l, c, p, n: INTEGER
			l_own_line: BOOLEAN
			l_cmt_start: CHARACTER
			l_new_line: CHARACTER
			l_in_comment: BOOLEAN
			l_c: CHARACTER
			i: INTEGER
			l_comment_start: INTEGER
			l_str: STRING
			l_is_imp: BOOLEAN
		do
			l_cmt_start := '-'
			l_new_line := '%N'
			l_own_line := column = 1
			l := line
			c := column
			p := 1
			n := location_count
			i := 1
			from
				create Result.make
				l_in_comment := False
			until
				i > n
			loop
				l_c := internal_text.item (i)
				if l_in_comment then
					if l_c = l_new_line then
						l_is_imp := False
						if l_comment_start + 2 <= i - 1 then
							l_str := internal_text.substring (l_comment_start + 2, i - 1)
							if l_str.item (1) = '|' then
								l_is_imp := True
							end
							l_str.replace_substring_all ("%R", "")
						else
							l_str := ""
						end
						Result.extend (create{EIFFEL_COMMENT_LINE}.make_with_data (l_str, l, c, position + l_comment_start - 1, l_own_line, l_is_imp, index, l_comment_start))
						l_in_comment := False
						l := l + 1
						c := 1
						l_own_line := True
					end
				else
					if l_c = l_cmt_start then
						check internal_text.item (i + 1) = l_cmt_start end
						l_comment_start := i
						l_in_comment := True
						i := i + 1
					elseif l_c = l_new_line then
						l := l + 1
						c := 1
						l_own_line := True
					else
						c := c + 1
					end
				end
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
		do
			Result := text (Void).is_equal (other.text (Void))
		end

feature{NONE} -- Implementation

	set_internal_text (s: STRING) is
			-- Set `internal_text' with `s'.
		do
			internal_text := s
		ensure
			internal_text_set: internal_text = s
		end

	internal_text: STRING
			-- Literal string

invariant
	internal_text_not_void: internal_text /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
