indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
deferred class ASSERT_TYPE

feature -- Access

	In_precondition: INTEGER is 1
			-- Assertion is a precondition

	In_postcondition: INTEGER is 2
			-- Assertion is a postcondition

	In_check: INTEGER is 3
			-- Assertion is a check

	In_loop_invariant: INTEGER is 4
			-- Assertion in a loop

	In_loop_variant: INTEGER is 5
			-- Variant in a loop

	In_invariant: INTEGER is 6
			-- Class invariant

	buffer: GENERATION_BUFFER is
			-- File used for C code generation
		deferred
		end

feature -- Code generation

	generate_assertion_code (i: INTEGER) is
			-- Write the exception code associated with assertion code `i'
		do
			inspect i
			when In_precondition then
				buffer.put_string ("EX_PRE")
			when In_postcondition then
				buffer.put_string ("EX_POST")
			when In_check then
				buffer.put_string ("EX_CHECK")
			when In_loop_invariant then
				buffer.put_string ("EX_LINV")
			when In_loop_variant then
				buffer.put_string ("EX_VAR")
			when In_invariant then
				buffer.put_string ("(where ? EX_CINV:EX_INVC)")
			end
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
