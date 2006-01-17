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
			text
		end

create
	make

feature{NONE} -- Implementation

	make (a_text: STRING; a_leaf: LEAF_AS) is
			--
		require
			a_text_not_void: a_text /= Void
			a_leaf_not_void: a_leaf /= Void
		do
			literal_text := a_text
			make_from_other (a_leaf)
		ensure
			literal_text_set: literal_text = a_text
		end

feature

	text (a_list: LEAF_AS_LIST): STRING is
		do
			Result := literal_text
		end

	literal_text: STRING
			-- Literal text in code

feature

	is_equivalent (other: like Current): BOOLEAN is
		do
			check
				should_not_arrive_here: False
			end
		end

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			check
				should_not_arrive_here: False
			end
		end

	number_of_breakpoint_slots: INTEGER is
		do
			check
				should_not_arrive_here: False
			end
		end

invariant
	literal_text_not_void: literal_text /= Void

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
