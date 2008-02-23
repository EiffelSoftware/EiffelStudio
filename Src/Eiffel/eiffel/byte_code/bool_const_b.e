indexing
	description: "Boolean constant for code generation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class BOOL_CONST_B

inherit
	EXPR_B
		redefine
			print_register,
			is_simple_expr, is_predefined, evaluate,
			is_fast_as_local, is_constant_expression
		end

	SHARED_TYPES
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (v: BOOLEAN) is
			-- Assign `v' to `value'.
		do
			value := v
		ensure
			value_set: value = v
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bool_const_b (Current)
		end

feature -- Access

	value: BOOLEAN
			-- Boolean value

feature -- Evaluation

	evaluate: VALUE_I is
			-- Evaluation of Current.
		do
			create {BOOL_VALUE_I} Result.make (value)
		end

feature -- Status report

	is_simple_expr: BOOLEAN is True
			-- A constant is a simple expression.

	is_predefined: BOOLEAN is True
			-- A constant is a predefined structure.

	is_constant_expression: BOOLEAN is True
			-- A boolean constant is constant.

	type: TYPE_A is
			-- Boolean type
		do
			Result := boolean_type
		end

feature -- C code generation

	print_register is
			-- Print boolean constant
		do
			if value then
				buffer.put_string ("(EIF_BOOLEAN) 1")
			else
				buffer.put_string ("(EIF_BOOLEAN) 0")
			end
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end

feature -- IL code generation

	is_fast_as_local: BOOLEAN is true;
			-- Is expression calculation as fast as loading a local?

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

end -- class BOOL_CONST_B
