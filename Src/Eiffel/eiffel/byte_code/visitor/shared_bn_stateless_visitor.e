note
	description: "Collections of stateless BYTE_NODE visitors."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_BN_STATELESS_VISITOR

feature -- Byte code generators

	melted_generator: MELTED_GENERATOR
			-- Generator for melted code.
		once
			create Result
		ensure
			melted_generator_not_void: Result /= Void
		end

	melted_assignment_generator: MELTED_ASSIGNMENT_GENERATOR
			-- Generator assignments for melted code.
		once
			create Result
		ensure
			melted_assignment_generator_not_void: Result /= Void
		end

	attribute_assignment_detector: ATTRIBUTE_ASSIGNMENT_DETECTOR
			-- Visitor to checker whether the byte nodes perform an attachement to an attribute.
		once
			create Result
		ensure
			attribute_assignment_detector_not_void: Result /= Void
		end

feature -- IL code generators

	cil_node_generator: IL_NODE_GENERATOR
			-- Generator for CIL code.
		once
			create Result
		ensure
			cil_node_generator_not_void: Result /= Void
		end

	cil_access_address_generator: IL_ACCESS_ADDRESS_GENERATOR
			-- Generator for loading address of an ACCESS_B node.
		once
			create Result
		ensure
			cil_access_address_generator_not_void: Result /= Void
		end

note
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
