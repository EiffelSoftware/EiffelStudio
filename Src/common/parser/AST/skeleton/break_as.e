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
			text
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

	text (a_list: LEAF_AS_LIST): STRING is
			-- Literal text of this token
		do
			Result := internal_text
		end

feature -- Visitor

	process (v: AST_VISITOR) is
		do
			v.process_break_as (Current)
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
