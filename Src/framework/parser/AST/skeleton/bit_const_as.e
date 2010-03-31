note
	description: "Node for bit constant. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class BIT_CONST_AS

inherit
	ATOMIC_AS
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (b: ID_AS)
			-- Create a new BIT_CONSTANT AST node with
			-- with bit sequence contained in `b'.
		require
			b_not_void: b /= Void
			b_minimum_length: not b.name.is_empty
		do
			value := b
		ensure
			value_set: value = b
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_bit_const_as (Current)
		end

feature -- Access

	value: ID_AS
			-- Bit value (sequence of 0 and 1)

	size: NATURAL_32
			-- Number of bits of Current
		do
				-- Conversion INTEGER_32 -> NATURAL_32 is safe because `count' is
				-- always non-negative.
			Result := value.name.count.as_natural_32
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			Result := value.first_token (a_list)
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			Result := value.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (value, other.value)
		end

feature -- Output

	string_value: STRING
		do
			create Result.make (value.name.count)
			Result.append (value.name)
		end

invariant
	value_not_void: value /= Void
	value_minimum_length: not value.name.is_empty

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

end -- class BIT_CONST_AS
