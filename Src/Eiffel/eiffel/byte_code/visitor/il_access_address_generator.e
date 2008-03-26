indexing
	description: "Generate loading of the address for ACCESS_B node."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_ACCESS_ADDRESS_GENERATOR

inherit
	BYTE_NODE_NULL_VISITOR
		redefine
			process_argument_b,
			process_attribute_b,
			process_current_b,
			process_local_b,
			process_object_test_local_b,
			process_result_b
		end

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end

feature -- IL code generation

	generate_il_address (a_code_generator: like il_generator; a_node: ACCESS_B) is
			-- Generate address loading of `a_node'.
		require
			a_code_generator_not_Void: a_code_generator /= Void
			a_node_not_void: a_node /= Void
		do
			il_generator := a_code_generator
			a_node.process (Current)
			il_generator := Void
		end

feature -- Access

	il_generator: IL_CODE_GENERATOR
			-- Actual IL code generator.

feature {NONE} -- Implementation

	process_argument_b (a_node: ARGUMENT_B) is
			-- Process `a_node'.
		do
			il_generator.generate_argument_address (a_node.position)
		end

	process_attribute_b (a_node: ATTRIBUTE_B) is
			-- Process `a_node'.
		local
			l_cl_type: CL_TYPE_A
		do
			l_cl_type ?= a_node.context_type
			il_generator.generate_current
			il_generator.generate_attribute_address (
				l_cl_type.implemented_type (a_node.written_in),
				context.real_type (a_node.type), a_node.attribute_id)
		end

	process_current_b (a_node: CURRENT_B) is
			-- Process `a_node'.
		do
			il_generator.generate_current_address
		end

	process_local_b (a_node: LOCAL_B) is
			-- Process `a_node'.
		do
			il_generator.generate_local_address (a_node.position)
		end

	process_object_test_local_b (a_node: OBJECT_TEST_LOCAL_B) is
		do
			il_generator.generate_local_address (context.object_test_local_position (a_node))
		end

	process_result_b (a_node: RESULT_B) is
			-- Process `a_node'.
		do
			il_generator.generate_result_address
		end

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
