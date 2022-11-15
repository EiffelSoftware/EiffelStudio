note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	-- TODO: Factor out common code of this class and BIN_TILDE_BL to simplify maintainance.

deferred class BIN_EQUAL_B

inherit
	BINARY_B
		rename
			register as left_register,
			set_register as set_left_register
		redefine
			allocates_memory,
			analyze,
			calls_special_features,
			free_register,
			generate,
			generate_real_comparison_routine_name,
			inlined_byte_code,
			is_binary_comparison,
			is_commutative,
			is_type_fixed,
			is_unsafe,
			optimized_byte_node,
			pre_inlined_code,
			print_register, type,
			unanalyze
		end

	SHARED_TYPE_I
		export
			{NONE} all
		end

feature -- Status report

	is_built_in: BOOLEAN = True
			-- Is the current binary operator a built-in one?

	is_commutative: BOOLEAN = True
			-- Operation is commutative.

	is_type_fixed: BOOLEAN = True
			-- Is type of the expression statically fixed,
			-- so that there is no variation at run-time?

	is_binary_comparison: BOOLEAN = True
			-- <Precursor>

feature

	type: TYPE_A
			-- Expression type is boolean.
		do
			Result := Boolean_type
		end

	allocates_memory: BOOLEAN
			-- <Precursor>
		local
			left_type: TYPE_A
			right_type: TYPE_A
		do
			left_type := context.real_type (left.type)
			right_type := context.real_type (right.type)
			Result := Precursor or else
				(left_type.is_basic and not (right_type.is_none or right_type.is_basic)) or else
				(right_type.is_basic and not (left_type.is_none or left_type.is_basic))
		end

	generate_boolean_constant
		deferred
		end

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
			if left_register = Void then
				left.print_register
			else
				left_register.print_register
			end
			buffer.put_string ({C_CONST}.comma_space)
			if right_register = Void then
				right.print_register
			else
				right_register.print_register
			end
			buffer.put_character (')')
		end

	right_register: REGISTRABLE
			-- Where metamorphosed right value is kept.
		do
		end

	set_right_register (r: REGISTRABLE)
			-- Assign `r' to `right_register'.
		do
		end

	get_left_register
			-- Get register for left expression.
		do
			if left_register = Void then
				set_left_register (create {REGISTER}.make (Reference_c_type))
			end
		end

	get_right_register
			-- Get register for right expression.
		do
			if right_register = Void then
				set_right_register (create {REGISTER}.make (Reference_c_type))
			end
		end

	analyze
			-- <Precursor>
		local
			left_type: TYPE_A
			right_type: TYPE_A
		do
			left.analyze
			left_type := context.real_type (left.type)
			right_type := context.real_type (right.type)
			if left_type.is_basic and not (right_type.is_none or right_type.is_basic) then
					-- Release register of `left` because its result will be kept in `left_register`.
				left.free_register
				get_left_register
			end
				-- Make sure the left hand side reference value is tracked by GC
				-- if the right hand side allocates memory.
			if
				left_type.is_reference and then
				right.allocates_memory and then
				not left.is_predefined and then
				not left.stored_register.is_predefined and then
				not attached left_register
			then
					-- Release register of `left` because its result will be kept in `left_register`.
				left.free_register
				get_left_register
			end
			right.analyze
			if
				not left_type.is_none and then not left_type.is_basic and then
				(right_type.is_basic or else right.allocates_memory)
			then
					-- Release register of `right` because its result will be kept in `right_register`.
				right.free_register
				get_right_register
			end
		end

	free_register
			-- <Precursor>
		do
				-- Take into account that if a temporary register is used, the corresponding expression register has been freed.
			if attached left_register as r then
				r.free_register
			else
				left.free_register
			end
			if attached right_register as r then
				r.free_register
			else
				right.free_register
			end
		end

	unanalyze
			-- <Precursor>
		do
			Precursor
			set_left_register (Void)
			set_right_register (Void)
		end

	generate
			-- <Precursor>
		do
			if attached left_register as r then
				left.generate_for_call (r)
			else
				left.generate
			end
			if attached right_register as r then
				right.generate_for_call (r)
			else
				right.generate
			end
		end

	generate_real_comparison_routine_name (buf: GENERATION_BUFFER)
			-- <Precursor>
		do
			generate_negation
			buf.put_string
				(if context.real_type (left.type).is_real_32 then
					"eif_is_equal_real_32"
				else
					"eif_is_equal_real_64"
				end)
		end

	print_register
			-- Print expression value.
		local
			left_type: TYPE_A
			right_type: TYPE_A
			buf: GENERATION_BUFFER
		do
			if is_real_comparison then
				Precursor
			else
				left_type := context.real_type (left.type)
				right_type := context.real_type (right.type)
				if
					left_type.is_none and right_type.is_expanded or
					left_type.is_expanded and right_type.is_none
				then
						-- Expanded type can never be Void.
					generate_boolean_constant
				elseif
					left_type.is_true_expanded or
					right_type.is_true_expanded or
					attached left_register and then left_type.is_basic or
					attached right_register and then right_type.is_basic
				then
					generate_negation
					generate_equal_macro ("RTEQ")
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
						left.print_register
					else
						left_register.print_register
					end
					generate_operator (buf)
					if right_register = Void then
						right.print_register
					else
						right_register.print_register
					end
					buf.put_character (')')
				end
			end
		end

feature -- Array optimization

	is_unsafe: BOOLEAN
		do
			Result := right.is_unsafe or else left.is_unsafe
		end

	optimized_byte_node: EXPR_B
		do
			Result := Current
			left := left.optimized_byte_node
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
			Result := Current
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
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
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
