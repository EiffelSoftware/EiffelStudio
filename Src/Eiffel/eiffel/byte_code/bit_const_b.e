note
	description: "BIT constant byte node."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BIT_CONST_B

inherit
	EXPR_B
		redefine
			enlarged, is_simple_expr, allocates_memory,
			is_constant_expression
		end

create
	make

feature {NONE} -- Initialization

	make (v: STRING)
			-- Assign `v' to `value'.
		do
			value := v
		ensure
			value_set: value = v
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_bit_const_b (Current)
		end

feature -- Access

	value: STRING;
			-- Bit value (sequence of 0 and 1)

	bit_size: NATURAL_32
			-- Size of bit constant
		do
			Result := value.count.as_natural_32
		end

feature -- Status report

	is_simple_expr: BOOLEAN = True
			-- A string is a simple expression

	allocates_memory: BOOLEAN = True

	is_constant_expression: BOOLEAN = True
			-- A bit constant is constant

	type: BITS_A
			-- Bit type
		do
			create Result.make (bit_size)
		end

	enlarged: BIT_CONST_BL
			-- Enlarged node
		do
			create Result.make (value)
		end;

	used (r: REGISTRABLE): BOOLEAN
            -- Is register `r' used in local or forthcomming dot calls ?
        do
        end;

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
