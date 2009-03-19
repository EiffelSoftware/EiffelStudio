note
	description: "Node for verbatim strings. "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VERBATIM_STRING_AS

inherit
	STRING_AS
		rename
			initialize as string_initialize
		redefine
			process
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (s, marker: STRING; indentable: BOOLEAN; l, c, p, n, cc: INTEGER)
			-- Create a new Verbatim string AST node.
		require
			s_not_void: s /= Void
			marker_not_void: marker /= Void
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
			cc_non_negative: cc >= 0
		do
			string_initialize (s, l, c, p, n)
			verbatim_marker := marker
			is_indentable := indentable
			common_columns := cc
		ensure
			value_set: value = s
			verbatim_marker_set: verbatim_marker = marker
			is_indentable_set: is_indentable = indentable
			common_columns_set: common_columns = cc
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_verbatim_string_as (Current)
		end

feature -- Properties

	verbatim_marker: STRING
			-- Delimiter used to mark the beginning and end of the
			-- verbatim string.
			-- If `empty', no marker was used.

	is_indentable: BOOLEAN
			-- Is verbatim string indentable, i.e. can all lines be prepended
			-- by the same white space without changing string value?
			-- Normally, indentable verbatim string is enclosed in '[' and ']'.
			-- Non-indentable verbatim string is enclosed in '{' and '}'.

	common_columns: INTEGER
			-- Number of common columns to all the lines of the verbatim string.

invariant
	verbatim_marker_not_void: verbatim_marker /= Void
	common_columns_non_negative: common_columns >= 0
	valid_common_columns: not is_indentable implies common_columns = 0

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class VERBATIM_STRING_AS

