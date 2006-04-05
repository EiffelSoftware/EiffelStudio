indexing
	description: "Real constant for code generation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class REAL_CONST_B

inherit
	EXPR_B
		redefine
			print_register, evaluate,
			is_simple_expr, is_predefined,
			is_fast_as_local, is_constant_expression
		end

create
	make

feature {NONE} -- Initialization

	make (v: STRING; a_type: TYPE_A) is
			-- Assign `v' to `value'.
			-- Remove the '_' signs in the real number.
		require
			v_not_void: v /= Void
			no_undescores_in_v: not v.has ('_')
			a_type_not_void: a_type /= Void
		do
			value := v
			if a_type.is_real_64 then
				real_size := 64
			else
				real_size := 32
			end
		ensure
			value_set: value = v
			real_size_set: real_size = 32 or real_size = 64
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_real_const_b (Current)
		end

feature -- Access

	value: STRING
			-- Value to generate

feature -- Evaluation

	evaluate: VALUE_I is
			-- Evaluation of Current.
		do
			if real_size = 64 then
				create {REAL_VALUE_I} Result.make_real_64 (value.to_double)
			else
				create {REAL_VALUE_I} Result.make_real_32 (value.to_real)
			end
		end

feature -- Status report

	is_simple_expr: BOOLEAN is True
			-- A constant is a simple expresion

	is_predefined: BOOLEAN is True
			-- A constant is a predefined structure.

	is_constant_expression: BOOLEAN is True
			-- A real constant is constant.

	real_size: NATURAL_8
			-- Size of REAL constant

	type: TYPE_I is
			-- Float type
		do
			if real_size = 64 then
				Result := real64_c_type
			else
				Result := real32_c_type
			end
		end

feature -- C code generation

	print_register is
			-- Print real value
		do
			if real_size = 64 then
				buffer.put_string ("(EIF_REAL_64) ")
			else
				buffer.put_string ("(EIF_REAL_32) ")
			end
			buffer.put_string (value)
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- False
		do
		end

feature -- IL code generation

	is_fast_as_local: BOOLEAN is True
			-- Is expression calculation as fast as loading a local?

invariant
	value_not_void: value /= Void
	value_has_no_undescores: not value.has ('_')
	real_size_valid: real_size = 32 or real_size = 64
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
