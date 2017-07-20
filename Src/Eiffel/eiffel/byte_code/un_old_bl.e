note
	descriptio: "The enlarged 'old' operator."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class UN_OLD_BL

inherit

	UN_OLD_B
		redefine
			register, set_register,
			generate, unanalyze, analyze,
			print_register, free_register
		end

feature

	register: REGISTRABLE
			-- Register which stores the old value.
			-- This register is never freed, of course.

	exception_register: REGISTER
			-- Register which stores the exception object if any.

	set_register (r: REGISTRABLE)
			-- Assign `r' to `register'
		do
			register := r
		end

	special_analyze
			-- Analyze expression and get a register
		do
			context.init_propagation
			expr.propagate (No_register)
			get_register
			expr.analyze
			expr.free_register
				-- Avoid generating code that handles exceptions when no exceptions are possiible (and no memory is allocated to store intermediate result).
			if is_exception_block_needed then
					-- Create exception register.
				create exception_register.make (exception_type.c_type)
			end
		end

	initialize
			-- Initialize the value of the old variable.
		local
			target_type: TYPE_A
			buf: GENERATION_BUFFER
			e: like exception_register
		do
			buf := buffer

			e := exception_register
			if attached e then
					-- Start try block of old expression evaluation
				buf.put_new_line
				buf.put_string ("RTE_OT")
			end

			expr.generate
			target_type := Context.real_type (type)
			buf.put_new_line
			register.print_register
			buf.put_string (" = ")
			if target_type.is_true_expanded then
				buf.put_string ("RTCL(")
				expr.print_register
				buf.put_character (')')
			else
				expr.print_register
			end
			buf.put_character (';')

			if attached e then
					-- Clean the exception recording local.
				buf.put_new_line
				e.print_register
				buf.put_string (" = ")
				buf.put_string ("NULL;")

					-- End try block of old expression evaluation
				buf.put_new_line
				buf.put_string ("RTE_O")

					-- Save possible exception object.
				buf.put_new_line
				e.print_register
				buf.put_string (" = ")
				buf.put_string ("RTLA;")

					-- End of local rescue
				buf.put_new_line
				buf.put_string ("RTE_OE")
			end
		end

	unanalyze
			-- Undo the analysis.
		local
			void_reg: REGISTER
		do
			expr.unanalyze
			set_register (void_reg)
		end

	analyze
			-- Do nothing
		do
		end

	generate
			-- We always check that the corresponding recorded exception object exists,
			-- and raise an OLD_VIOLATION if so.
		local
			buf: GENERATION_BUFFER
		do
			if attached exception_register as e then
				buf := buffer
				buf.put_new_line
				buf.put_string ("RTCO(")
				e.print_register
				buf.put_two_character (')', ';')
			end
		end

	print_register
			-- Print the value of the old variable
		do
			register.print_register
		end

	free_register
			-- Do nothing
		do
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
