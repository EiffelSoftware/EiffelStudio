note
	description: "Byte node for converting a basic type of type integer, natural or real to a smaller size without having to use a conversion call."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NULL_CONVERSION_B

inherit
	PARAN_B
		rename
			make as make_expr
		redefine
			type,
			print_register,
			process
		end

create
	make

feature {NONE} -- Initialize

	make (e: EXPR_B; a_target_type: BASIC_A)
			-- Set `expr' to `e'
		require
			e_not_void: e /= Void
		do
			expr := e
			type := a_target_type
		ensure
			expr_set: expr = e
			type_set: type = a_target_type
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_null_conversion_b (Current)
		end

feature -- Access

	type: BASIC_A
			-- <Precursor>

feature -- Code generation

	print_register
			-- <Precursor>
		local
			l_type, l_expr_type: TYPE_A
		do
			l_type := context.real_type (type)
			l_expr_type := context.real_type (expr.type)
			if not l_type.same_as (l_expr_type) then
				l_type.c_type.generate_cast (buffer)
			end
			expr.print_register
		end

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
end
