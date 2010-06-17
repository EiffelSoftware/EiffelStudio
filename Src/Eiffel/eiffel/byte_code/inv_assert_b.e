note
	description	: "Byte code for instruction inside an invariant clause."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class INV_ASSERT_B

inherit
	ASSERT_B
		redefine
			generate, process
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_inv_assert_b (Current)
		end

feature

	fill_from (a: ASSERT_B)
			-- Initialization
		require
			good_argument: not (a = Void)
		do
			expr := a.expr.enlarged
				-- Make sure the expression has never been analyzed before
			expr.unanalyze
			tag := a.tag
		end

	 generate
			-- Generate assertion
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
				-- Generate the recording of the assertion
			buf.put_new_line
			buf.put_string ("RTIT(")
			if tag /= Void then
				buf.put_character ('"')
				buf.put_string (tag)
				buf.put_character ('"')
			else
				buf.put_string ("NULL")
			end
			buf.put_string ({C_CONST}.comma_space)
			context.Current_register.print_register
			buf.put_two_character (')', ';')
				-- Now evaluate the expression
			expr.generate
			buf.put_new_line
			buf.put_string ({C_CONST}.if_conditional)
			buf.put_two_character (' ', '(')
			expr.print_register
			buf.put_three_character (')', ' ', '{')
			generate_success (buf)
			buf.put_new_line
			buf.put_two_character ('}', ' ')
			buf.put_string ({C_CONST}.else_conditional)
			buf.put_two_character (' ', '{')
			generate_failure (buf)
			buf.put_new_line
			buf.put_character ('}')
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
