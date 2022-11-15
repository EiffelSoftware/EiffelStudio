note
	description: "Node for ~ equality operator for C code generation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_TILDE_BL

inherit
	BIN_TILDE_B
		redefine
			analyze, unanalyze, free_register,
			generate, print_register,
			generate_operator, generate_real_comparison_routine_name
		end

create
	make

feature -- Access

	left_register: REGISTRABLE
			-- Where metamorphosed left value is kept.

	right_register: REGISTRABLE
			-- Where metamorphosed right value is kept.

feature -- C code generation

	generate_negation
			-- Generate negation of an equality test (if required).
		do
				-- Nothing by default
		end

	generate_operator (a_buffer: GENERATION_BUFFER)
			-- <Precursor>
		do
			a_buffer.put_four_character (' ', '=', '=', ' ')
		end

	generate_boolean_constant
			-- Generate false constant.
		do
			buffer.put_string ("EIF_FALSE")
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

					-- For values of the same basic type the equality test is generated.
				if left_type.is_basic and right_type.is_basic and then left_type.same_as (right_type) then
					buf := buffer
					buf.put_character ('(')
					left.print_register
					generate_operator (buffer)
					right.print_register
					buf.put_character (')')
				elseif
					(left_type.is_none and right_type.is_expanded) or else
					(left_type.is_expanded and right_type.is_none) or else
					(left_type.is_expanded and then right_type.is_expanded and then
					left_type.has_associated_class and then right_type.has_associated_class and then
					left_type.base_class.class_id /= right_type.base_class.class_id)
				then
						-- A value of an expanded type is not Void.
						-- Two values of different expanded types are not equal.
						-- In both cases result is known at compile time.
					generate_boolean_constant
				else
					buf := buffer
					generate_negation
						-- FIXME: This call assumes that `is_equal' from ANY always takes
						-- `like Current' as argument, but actually it could be different.
					buf.put_string ("RTEQ")
					buf.put_character ('(')
					if left_register = Void then
						left.print_register
					else
						left_register.print_register
					end
					buf.put_string ({C_CONST}.comma_space)
					if right_register = Void then
						right.print_register
					else
						right_register.print_register
					end
					buf.put_character (')')
				end
			end
		end

feature -- Settings

	set_left_register (r: REGISTRABLE)
			-- Assign `r' to `left_register'.
		do
			left_register := r
		ensure
			left_register_set: left_register = r
		end

	set_right_register (r: REGISTRABLE)
			-- Assign `r' to `right_register'.
		do
			right_register := r
		ensure
			right_register_set: right_register = r
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
