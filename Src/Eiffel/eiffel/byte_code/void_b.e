indexing
	description: "Byte node for Void value."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VOID_B

inherit
	EXPR_B
		redefine
			is_simple_expr, is_predefined,
			print_register, is_fast_as_local,
			is_constant_expression
		end

	SHARED_TYPES
		export
			{NONE} all
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_void_b (Current)
		end

feature -- Access

	type: TYPE_A is
			-- Expression type.
		do
			Result := none_type
		ensure then
			type_not_void: Result /= Void
		end

feature -- Status report

	is_simple_expr: BOOLEAN is True
			-- Void is a simple expression

	is_predefined: BOOLEAN is False
			-- Void is not predefined

	is_constant_expression: BOOLEAN is True
			-- Void is a constant.

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local or forthcomming dot calls ?
		do
			-- False
		ensure then
			not_used: not Result
		end

feature -- IL code generation

	is_fast_as_local: BOOLEAN is true
			-- Is expression calculation as fast as loading a local?

feature -- C code generation

	print_register is
			-- Print Void value.
		do
			buffer.put_string ("NULL")
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

end -- class VOID_B
