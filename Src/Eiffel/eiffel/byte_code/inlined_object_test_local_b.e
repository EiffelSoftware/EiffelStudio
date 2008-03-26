indexing
	description: "Access to an inlined object-test local in C code."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class INLINED_OBJECT_TEST_LOCAL_B

inherit

	INLINED_LOCAL_B
		undefine
			array_descriptor,
			assigns_to,
			is_creatable,
			pre_inlined_code,
			process,
			register_name,
			same
		redefine
			print_register, enlarged
		end

	OBJECT_TEST_LOCAL_B
		undefine
			analyze,
			current_register,
			free_register,
			generate,
			is_local,
			print_register,
			propagate,
			set_parent,
			type
		redefine
			print_register, enlarged
		end

create

	make_from

feature {NONE} -- Creation

	make_from (other: OBJECT_TEST_LOCAL_B)
		do
			parent := other.parent
			multi_constraint_static := other.multi_constraint_static
			position := other.position
			type := other.type
			body_id := other.body_id
		ensure
			parent_set: parent = other.parent
			multi_constraint_static_set: multi_constraint_static = other.multi_constraint_static
			position_set: position = other.position
			type_set: type = other.type
			body_id_set: body_id = other.body_id
		end

feature -- C code generation

	enlarged: INLINED_OBJECT_TEST_LOCAL_B is
		do
			Result := Current
		end

	print_register is
		do
			System.remover.inliner.inlined_feature.local_regs.item (position).print_register
		end

indexing
	copyright:	"Copyright (c) 2008, Eiffel Software"
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
