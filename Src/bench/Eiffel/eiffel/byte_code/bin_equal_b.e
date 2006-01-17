indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
deferred class BIN_EQUAL_B

inherit
	BINARY_B
		rename
			register as left_register,
			set_register as set_left_register
		redefine
			free_register, unanalyze,
			is_commutative, print_register, type,
			generate, analyze, is_unsafe, optimized_byte_node,
			calls_special_features, pre_inlined_code, inlined_byte_code
		end

feature -- Status

	is_built_in: BOOLEAN is True
			-- Is the current binary operator a built-in one ?

	is_commutative: BOOLEAN is True
			-- Operation is commutative.

feature

	set_register: ANY is do end;

	register: ANY is do end;

	type: TYPE_I is
			-- Expression type is boolean
		do
			Result := Boolean_c_type;
		end;

	generate_boolean_constant is
		deferred
		end;

	generate_equal is
			-- Generate equality if one side at least is an expanded
		do
			buffer.put_string ("RTEQ(");
			generate_equal_end;
		end;

	generate_equal_end is
			-- Generate last portion of equality.
		do
			if left_register = Void then
				left.print_register;
			else
				left_register.print_register;
			end;
			buffer.put_string (gc_comma);
			if right_register = Void then
				right.print_register;
			else
				right_register.print_register;
			end;
			buffer.put_character (')');
		end;

	generate_bit_equal is
			-- Generate equality if one side at least is a bit.
		do
			buffer.put_string ("RTEB(");
			generate_equal_end
		end;

	right_register: REGISTRABLE is
			-- Where metamorphosed right value is kept
		do
		end;

	set_right_register (r: REGISTRABLE) is
			-- Assign `r' to `right_register'
		do
		end;

	get_left_register is
			-- Get register for left expression
		local
			tmp_register: REGISTER;
		do
			if left_register = Void then
				create tmp_register.make (Reference_c_type);
				set_left_register (tmp_register);
			end;
		end;

	get_right_register is
			-- Get register for right expression
		local
			tmp_register: REGISTER;
		do
			if right_register = Void then
				create tmp_register.make (Reference_c_type);
				set_right_register (tmp_register);
			end;
		end;

	analyze is
			-- Analyze expression
		local
			left_type: TYPE_I;
			right_type: TYPE_I;
		do
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
		end;

	unanalyze is
			-- Undo the analysis
		local
			void_register: REGISTER;
		do
			Precursor {BINARY_B}
			set_left_register (void_register);
			set_right_register (void_register);
		end;

	free_register is
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

	generate is
			-- Generate expression
		local
			basic_i: BASIC_I;
			buf: GENERATION_BUFFER
		do
			left.generate;
			right.generate;
			buf := buffer
			if left_register /= Void then
				basic_i ?= context.real_type (left.type);
				basic_i.metamorphose
					(left_register, left, buf, context.workbench_mode);
				buf.put_character (';');
				buf.put_new_line;
			end;
			if right_register /= Void then
				basic_i ?= context.real_type (right.type);
				basic_i.metamorphose
					(right_register, right, buf, context.workbench_mode);
				buf.put_character (';');
				buf.put_new_line;
			end;
		end;

	print_register is
			-- Print expression value
		local
			left_type: TYPE_I;
			right_type: TYPE_I;
			buf: GENERATION_BUFFER
		do
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
				generate_equal;
			elseif left_type.is_bit or right_type.is_bit then
				generate_bit_equal
			else
				buf := buffer
				buf.put_string ("(EIF_BOOLEAN)(")
				if left_register = Void then
					left.print_register;
				else
					left_register.print_register;
				end;
				generate_operator;
				if right_register = Void then
					right.print_register;
				else
					right_register.print_register;
				end;
				buf.put_character (')')
			end;
		end;

feature -- Array optimization

	is_unsafe: BOOLEAN is
		do
			Result := right.is_unsafe or else
				left.is_unsafe
		end

	optimized_byte_node: EXPR_B is
		do
			Result := Current;
			left := left.optimized_byte_node;
			right := right.optimized_byte_node
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := left.calls_special_features (array_desc)
				or else right.calls_special_features (array_desc)
		end

feature -- Inlining

	pre_inlined_code: like Current is
		do
			Result := Current;
			left := left.pre_inlined_code
			right := right.pre_inlined_code
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			left := left.inlined_byte_code
			right := right.inlined_byte_code
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
