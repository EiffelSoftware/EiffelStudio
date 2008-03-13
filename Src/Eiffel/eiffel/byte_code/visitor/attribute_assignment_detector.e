indexing
	description: "Find whether or not a BYTE_NODE has an assignment to an attribute."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ATTRIBUTE_ASSIGNMENT_DETECTOR

inherit
	BYTE_NODE_ITERATOR
		redefine
			process_assign_b,
			process_reverse_b
		end

feature -- Status report

	has_attribute_assignment (a_node: BYTE_NODE): BOOLEAN is
			-- Does `a_node' contain an assignment to an attribute?
		do
			internal_has_attribute_assignment := False
			a_node.process (Current)
			Result := internal_has_attribute_assignment
		end

feature {NONE} -- Implementation: access

	internal_has_attribute_assignment: BOOLEAN
			-- Storage for `has_attribute_assignment'.

feature -- Node processing

	process_assign_b (a_node: ASSIGN_B) is
			-- <Precursor>
		do
			if a_node.target.is_attribute then
				internal_has_attribute_assignment := True
			end
		end

	process_reverse_b (a_node: REVERSE_B)  is
			-- <Precursor>
		do
			if a_node.target.is_attribute then
				internal_has_attribute_assignment := True
			end
		end

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
