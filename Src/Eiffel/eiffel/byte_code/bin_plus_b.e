note
	description: "+ operator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$date: $"
	revision: "$revision: $"

class BIN_PLUS_B

inherit

	NUM_BINARY_B
		redefine
			generate_operator, is_commutative,
			is_simple, generate_simple, generate_plus_plus,
			is_additive
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_bin_plus_b (Current)
		end

feature -- Status report

	is_commutative: BOOLEAN = True
			-- Operation is commutative.

	is_simple: BOOLEAN
			-- Operation is usually simple (C can compact it in affectations)
		do
			Result := is_built_in
		end

	is_additive: BOOLEAN = true
			-- Operation is additive.

feature -- C code generaiton

	generate_operator (a_buffer: GENERATION_BUFFER)
			-- Generate the operator
		do
			a_buffer.put_three_character (' ', '+', ' ')
		end

	generate_simple
			-- Generate a simple assignment operation
		do
			buffer.put_four_character (' ', '+', '=', ' ')
		end

	generate_plus_plus
			-- Generate a ++ operation
		do
			buffer.put_two_character ('+', '+')
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
