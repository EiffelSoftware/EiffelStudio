note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class BIN_LT_B

inherit

	COMP_BINARY_B
		redefine
			generate_operator, generate_real_comparison_routine_name
		end;

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_bin_lt_b (Current)
		end

feature

	generate_operator (a_buffer: GENERATION_BUFFER)
			-- Generate the operator
		do
			a_buffer.put_three_character (' ', '<', ' ')
		end;

	generate_real_comparison_routine_name (buf: GENERATION_BUFFER)
			-- <Precursor>
		do
			buf.put_string ("eif_is_less_real_")
			if context.real_type (left.type).is_real_32 then
				buf.put_two_character ('3', '2')
			else
				buf.put_two_character ('6', '4')
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
