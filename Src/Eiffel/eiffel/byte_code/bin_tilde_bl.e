indexing
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
			generate_operator
		end

create
	make

feature -- Access

	left_register: REGISTRABLE
			-- Where metamorphosed left value is kept

	right_register: REGISTRABLE
			-- Where metamorphosed right value is kept

feature -- C code generation

	generate_negation is
			-- Generate negation of an equality test (if required).
		do
				-- Nothing by default
		end

	generate_operator (a_buffer: GENERATION_BUFFER) is
			-- <Precursor>
		do
			a_buffer.put_four_character (' ', '=', '=', ' ')
		end

	generate_boolean_constant is
			-- Generate false constant
		do
			buffer.put_string ("EIF_FALSE")
		end

	get_left_register is
			-- Get register for left expression
		local
			tmp_register: REGISTER
		do
			if left_register = Void then
				create tmp_register.make (Reference_c_type)
				set_left_register (tmp_register)
			end
		end

	get_right_register is
			-- Get register for right expression
		local
			tmp_register: REGISTER
		do
			if right_register = Void then
				create tmp_register.make (Reference_c_type)
				set_right_register (tmp_register)
			end
		end

	analyze is
			-- Analyze expression
		local
			left_type: TYPE_A
			right_type: TYPE_A
		do
			left_type := context.real_type (left.type)
			right_type := context.real_type (right.type)
			left.analyze
			right.analyze
			if
				(left_type.is_basic and not (right_type.is_none or right_type.is_basic)) or
			 	(right_type.is_basic and not (left_type.is_none or left_type.is_basic))
			then
				if left_type.is_basic then
					get_left_register
				else
					get_right_register
				end
			end
		end

	unanalyze is
			-- Undo the analysis
		local
			void_register: REGISTER
		do
			Precursor {BIN_TILDE_B}
			set_left_register (void_register)
			set_right_register (void_register)
		end

	free_register is
			-- Free registers used
		do
			Precursor {BIN_TILDE_B}
			if left_register /= Void then
				left_register.free_register
			end
			if right_register /= Void then
				right_register.free_register
			end
		end

	generate is
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

	print_register is
			-- Print expression value
		local
			left_type: TYPE_A
			right_type: TYPE_A
			buf: GENERATION_BUFFER
		do
			left_type := context.real_type (left.type)
			right_type := context.real_type (right.type)

			if left_type.is_basic and right_type.is_basic then
					-- From the byte node generation, we know that they must
					-- be of the same type, otherwise something else than a
					-- BIN_TILDE_B node is generated.
				check
					same_basic_type: left_type.same_as (right_type)
				end
				buf := buffer
				buf.put_character ('(')
				left.print_register
				generate_operator (buffer)
				right.print_register
				buf.put_character (')')
			elseif
				(left_type.is_none and right_type.is_expanded) or
				(left_type.is_expanded and right_type.is_none)
			then
					-- Simple type can never be Void
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
				buf.put_string (gc_comma)
				if right_register = Void then
					right.print_register
				else
					right_register.print_register
				end
				buf.put_character (')')
			end
		end

feature -- Settings

	set_left_register (r: REGISTRABLE) is
			-- Assign `r' to `left_register'
		do
			left_register := r
		ensure
			left_register_set: left_register = r
		end

	set_right_register (r: REGISTRABLE) is
			-- Assign `r' to `right_register'
		do
			right_register := r
		ensure
			right_register_set: right_register = r
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

end
