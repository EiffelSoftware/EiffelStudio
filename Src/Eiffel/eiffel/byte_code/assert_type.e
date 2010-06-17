note
	legal: "See notice at end of class."
	status: "See notice at end of class."
deferred class ASSERT_TYPE

feature -- Access

	In_precondition: INTEGER = 1
			-- Assertion is a precondition

	In_postcondition: INTEGER = 2
			-- Assertion is a postcondition

	In_check: INTEGER = 3
			-- Assertion is a check

	In_guard: INTEGER = 4
			-- Assertion is a guard

	In_loop_invariant: INTEGER = 5
			-- Assertion in a loop

	In_loop_variant: INTEGER = 6
			-- Variant in a loop

	In_invariant: INTEGER = 7
			-- Class invariant

	buffer: GENERATION_BUFFER
			-- File used for C code generation
		deferred
		end

feature -- Code generation

	generate_assertion_code (i: INTEGER)
			-- Write the exception code associated with assertion code `i'
		do
			inspect i
			when In_precondition then
				buffer.put_string ({C_CONST}.ex_pre)
			when In_postcondition then
				buffer.put_string ({C_CONST}.ex_post)
			when In_check, In_guard then
				buffer.put_string ({C_CONST}.ex_check)
			when In_loop_invariant then
				buffer.put_string ({C_CONST}.ex_linv)
			when In_loop_variant then
				buffer.put_string ({C_CONST}.ex_var)
			when In_invariant then
				buffer.put_character ('(')
				buffer.put_string ({C_CONST}.where_name)
				buffer.put_three_character (' ', '?', ' ')
				buffer.put_string ({C_CONST}.ex_cinv)
				buffer.put_three_character (' ', ':', ' ')
				buffer.put_string ({C_CONST}.ex_invc)
				buffer.put_character (')')
			end
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
