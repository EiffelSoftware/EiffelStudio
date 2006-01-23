indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LEAF_STUB_AS

inherit
	LEAF_AS
		redefine
			literal_text
		end

create
	make

feature{NONE} -- Implementation

	make (a_text: STRING; l, c, p, n: INTEGER) is
			--
		require
			a_text_not_void: a_text /= Void
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
		do
			internal_text := a_text
			set_position (l, c, p, n)
		ensure
			internal_text_set: internal_text = a_text
		end

feature

	literal_text (a_list: LEAF_AS_LIST): STRING is
			-- Literal text of current AST node
		require else
			a_list_can_be_void: a_list = Void
		do
			Result := internal_text
		end

feature

	is_equivalent (other: like Current): BOOLEAN is
		do
			Result := literal_text (Void).is_equal (other.literal_text (Void))
		end

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			v.process_leaf_stub_as (Current)
		end

	number_of_breakpoint_slots: INTEGER is
		do
		end

feature{NONE} -- Implementation

	internal_text: STRING
			-- Literal text in code


invariant
	literal_text_not_void: literal_text (Void) /= Void

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
