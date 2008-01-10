indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class BIN_SLASH_B

inherit

	NUM_BINARY_B
		redefine
			generate_operator, is_simple,
			generate_simple, print_register
		end;

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_slash_b (Current)
		end

feature -- Access

	is_simple: BOOLEAN is
			-- Operation is usually simple (C can compact it in affectations)
		do
			Result := is_built_in;
		end;

feature -- C code generation

	generate_operator (a_buffer: GENERATION_BUFFER) is
			-- Generate the operator
		do
			a_buffer.put_three_character (' ', '/', ' ')
		end;

	generate_simple is
			-- Generate a simple assignment operation
		do
			buffer.put_string (" /= ");
		end;

	print_register is
			-- Print expression value
		local
			l_buf: like buffer
			l_type: TYPE_I
		do
			l_buf := buffer
			type.c_type.generate_cast (l_buf)

			l_buf.put_character ('(')
			l_type := context.real_type (left.type)
			l_type.c_type.generate_conversion_to_real_64 (l_buf)
			left.print_register
			l_buf.put_character (')')

			generate_operator (l_buf)

			l_buf.put_character (' ')
			l_type := context.real_type (right.type)
			l_type.c_type.generate_conversion_to_real_64 (l_buf)
			right.print_register
			l_buf.put_character (')')
			l_buf.put_character (')')
		end;

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
