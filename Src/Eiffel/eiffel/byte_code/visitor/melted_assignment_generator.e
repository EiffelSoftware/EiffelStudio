indexing
	description: "Visitor for performing assignments."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MELTED_ASSIGNMENT_GENERATOR

inherit
	ASSIGNMENT_GENERATOR
		redefine
			process_local_b, process_attribute_b, process_result_b
		end

	SHARED_BYTE_CONTEXT
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

feature -- Byte code generation

	generate_assignment (a_ba: BYTE_ARRAY; a_node: BYTE_NODE) is
			-- Generate assignment on `a_node'.
		require
			is_valid: is_valid
			a_ba_not_void: a_ba /= Void
			a_node_not_void: a_node /= Void
			a_node_valid: is_node_valid (a_node)
		do
			ba := a_ba
			a_node.process (Current)
			ba := Void
		end

feature -- Access

	ba: BYTE_ARRAY
			-- Byte array where melted code is stored.

feature {NONE} -- Implementation

	process_attribute_b (a_node: ATTRIBUTE_B) is
			-- Process `a_node'.
		local
			l_instant_context_type: CL_TYPE_A
			l_base_class: CLASS_C
			l_rout_info: ROUT_INFO
		do
			l_instant_context_type ?= a_node.context_type
			l_base_class := l_instant_context_type.associated_class
			if l_base_class.is_precompiled then
				l_rout_info := system.rout_info_table.item (a_node.routine_id)
				ba.append_integer (l_rout_info.origin)
				ba.append_integer (l_rout_info.offset)
			else
				ba.append_integer (a_node.attribute_id)
				ba.append_short_integer (l_instant_context_type.static_type_id (context.context_class_type.type) - 1)
			end
			ba.append_uint32_integer (context.real_type (a_node.type).sk_value (context.context_class_type.type))
		end

	process_local_b (a_node: LOCAL_B) is
			-- Process `a_node'.
		do
			ba.append_short_integer (a_node.position)
		end

	process_result_b (a_node: RESULT_B) is
			-- Process `a_node'.
		do
			-- Nothing to be done.
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
