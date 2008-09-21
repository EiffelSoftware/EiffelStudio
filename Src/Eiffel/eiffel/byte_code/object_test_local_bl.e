indexing
	description: "Access to an object-test local in C code."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class OBJECT_TEST_LOCAL_BL

inherit

	LOCAL_BL
		rename
			make as make_local
		undefine
			array_descriptor,
			assigns_to,
			enlarged,
			is_creatable,
			pre_inlined_code,
			process,
			register_name,
			same,
			used
		redefine
			analyze,
			parent
		end

	OBJECT_TEST_LOCAL_B
		undefine
			free_register,
			generate,
			propagate,
			set_parent,
			type
		redefine
			analyze,
			parent,
			used
		end

create
	make_from

feature {NONE} -- Creation

	make_from (other: OBJECT_TEST_LOCAL_B)
		do
			multi_constraint_static := other.multi_constraint_static
			position := other.position
			type := other.type
			body_id := other.body_id
			initialization_byte_code := other.initialization_byte_code
		ensure
			multi_constraint_static_set: multi_constraint_static = other.multi_constraint_static
			position_set: position = other.position
			type_set: type = other.type
			body_id_set: body_id = other.body_id
			initialization_byte_code_set: initialization_byte_code = other.initialization_byte_code
		end

feature -- Access

	parent: NESTED_BL
			-- Parent of access

feature -- Status report

	used (r: REGISTRABLE): BOOLEAN
			-- Is `r' the same as `Current'?
		do
			if {o: OBJECT_TEST_LOCAL_B} r then
				Result := same (o)
			end
		end

feature -- Code generation

	analyze
			-- Register object test local.
		do
			if c_type.is_pointer then
				context.set_local_index (register_name, Current)
			end
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
