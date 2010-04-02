note
	legal: "See notice at end of class."
	status: "See notice at end of class."
deferred class BIN_EQUAL_B

inherit
	BINARY_B
		rename
			register as left_register,
			set_register as set_left_register
		redefine
			allocates_memory,
			free_register, unanalyze, is_type_fixed,
			is_commutative, print_register, type,
			generate, analyze, is_unsafe, optimized_byte_node,
			calls_special_features, pre_inlined_code, inlined_byte_code,
			is_binary_comparison, generate_real_comparison_routine_name
		end

	SHARED_TYPE_I
		export
			{NONE} all
		end

feature -- Status report

	is_built_in: BOOLEAN = True
			-- Is the current binary operator a built-in one ?

	is_commutative: BOOLEAN = True
			-- Operation is commutative.

	is_type_fixed: BOOLEAN = True
			-- Is type of the expression statically fixed,
			-- so that there is no variation at run-time?

	is_binary_comparison: BOOLEAN = True
			-- <Precursor>

feature

	set_register: ANY do end;

	register: ANY do end;

	type: TYPE_A
			-- Expression type is boolean
		do
			Result := Boolean_type;
		end;

	allocates_memory: BOOLEAN
			-- Does the expression allocates memory ?
		local
			left_type: TYPE_A;
			right_type: TYPE_A;
		do
			left_type := context.real_type (left.type);
			right_type := context.real_type (right.type);
			Result := Precursor or else
				(left_type.is_basic and not (right_type.is_none or right_type.is_basic)) or else
				(right_type.is_basic and not (left_type.is_none or left_type.is_basic))
		end

	generate_boolean_constant
		deferred
		end;

	generate_negation
			-- Generate negation of an equality test (if required).
		do
				-- Nothing by default
		end

	generate_equal_macro (name: STRING)
			-- Generate a macro that performs an equality test.
		require
			name_attached: name /= Void
		do
			buffer.put_string (name)
			buffer.put_character ('(')
			generate_equal_end
		end

	generate_equal_end
			-- Generate last portion of equality.
		do
			if left_register = Void then
				left.print_register;
			else
				left_register.print_register;
			end;
			buffer.put_string ({C_CONST}.comma_space);
			if right_register = Void then
				right.print_register;
			else
				right_register.print_register;
			end;
			buffer.put_character (')');
		end;

	right_register: REGISTRABLE
			-- Where metamorphosed right value is kept
		do
		end;

	set_right_register (r: REGISTRABLE)
			-- Assign `r' to `right_register'
		do
		end;

	get_left_register
			-- Get register for left expression
		do
			if left_register = Void then
				set_left_register (create {REGISTER}.make (Reference_c_type));
			end;
		end;

	get_right_register
			-- Get register for right expression
		do
			if right_register = Void then
				set_right_register (create {REGISTER}.make (Reference_c_type));
			end;
		end;

	analyze
			-- Analyze expression
		local
			left_type: TYPE_A;
			right_type: TYPE_A;
		do
			if is_real_comparison then
				Precursor
			else
				left_type := context.real_type (left.type);
				right_type := context.real_type (right.type);
				left.analyze;
				right.analyze;
				if (left_type.is_basic and not (right_type.is_none or
					right_type.is_basic)) or (right_type.is_basic and not
					(left_type.is_none or left_type.is_basic))
				then
					if left_type.is_basic then
						get_left_register;
					else
						get_right_register;
					end;
				end;
			end
		end;

	unanalyze
			-- Undo the analysis
		local
			void_register: REGISTER;
		do
			Precursor {BINARY_B}
			set_left_register (void_register);
			set_right_register (void_register);
		end;

	free_register
			-- Free registers used
		do
			Precursor {BINARY_B}
			if left_register /= Void then
				left_register.free_register;
			end;
			if right_register /= Void then
				right_register.free_register;
			end;
		end;

	generate
			-- Generate expression
		local
			basic_i: BASIC_A
			buf: GENERATION_BUFFER
		do
			left.generate
			right.generate
			buf := buffer
			if left_register /= Void then
				basic_i ?= context.real_type (left.type)
				basic_i.metamorphose (left_register, left, buf)
				buf.put_character (';')
			end
			if right_register /= Void then
				basic_i ?= context.real_type (right.type)
				basic_i.metamorphose (right_register, right, buf)
				buf.put_character (';')
			end
		end

	generate_real_comparison_routine_name (buf: GENERATION_BUFFER)
			-- <Precursor>
		do
			if attached {BIN_NE_B} Current then
				buf.put_character ('!')
			end
			buf.put_string ("eif_is_equal_real_")
			if context.real_type (left.type).is_real_32 then
				buf.put_two_character ('3', '2')
			else
				buf.put_two_character ('6', '4')
			end
		end

	print_register
			-- Print expression value
		local
			left_type: TYPE_A;
			right_type: TYPE_A;
			buf: GENERATION_BUFFER
		do
			if is_real_comparison then
				Precursor
			else
				left_type := context.real_type (left.type);
				right_type := context.real_type (right.type);

				if
					(left_type.is_none and right_type.is_basic) or
					(left_type.is_basic and right_type.is_none)
				then
						-- Simple type can never be Void
					generate_boolean_constant;
				elseif left_type.is_true_expanded or right_type.is_true_expanded or
					left_register /= Void or right_register /= Void
				then
					generate_negation
					generate_equal_macro ("RTEQ")
				elseif left_type.is_bit or right_type.is_bit then
					generate_negation
					generate_equal_macro ("RTEB")
				elseif
					left_type.is_reference and then
					right_type.is_reference and then
					left.is_dynamic_clone_required (left_type) and then
					right.is_dynamic_clone_required (right_type)
				then
					generate_negation
					generate_equal_macro ("RTCEQ")
				else
					buf := buffer
					buf.put_string ("(EIF_BOOLEAN)(")
					if left_register = Void then
						left.print_register;
					else
						left_register.print_register;
					end;
					generate_operator (buf)
					if right_register = Void then
						right.print_register;
					else
						right_register.print_register;
					end;
					buf.put_character (')')
				end;
			end
		end;

feature -- Array optimization

	is_unsafe: BOOLEAN
		do
			Result := right.is_unsafe or else
				left.is_unsafe
		end

	optimized_byte_node: EXPR_B
		do
			Result := Current;
			left := left.optimized_byte_node;
			right := right.optimized_byte_node
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN
		do
			Result := left.calls_special_features (array_desc)
				or else right.calls_special_features (array_desc)
		end

feature -- Inlining

	pre_inlined_code: like Current
		do
			Result := Current;
			left := left.pre_inlined_code
			right := right.pre_inlined_code
		end

	inlined_byte_code: like Current
		do
			Result := Current
			left := left.inlined_byte_code
			right := right.inlined_byte_code
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
