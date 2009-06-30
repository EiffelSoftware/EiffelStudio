note
	description: "[
		Various XML-RPC types, used to set and distinquish parameter types in RPC calls and results.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_TYPE

inherit
	ENUM_TYPE [NATURAL_8]

create
	default_create,
	make

convert
	make ({NATURAL_8}),
	item: {NATURAL_8}

feature -- Access: Scalar

	unknown: NATURAL_8 = 0x0
			-- Unknonwn, implicit type

	string: NATURAL_8 = 0x1
			-- String type.

	boolean: NATURAL_8 = 0x2
			-- Boolean type True(1) and False(0).

	integer: NATURAL_8 = 0x3
			-- 4 byte integer type.

	double: NATURAL_8 = 0x4
			-- Double precision type.

	date: NATURAL_8 = 0x5
			-- ISO 8601 date type.

	base64: NATURAL_8 = 0x6
			-- Base64 encoded string type.

feature -- Access: Complex

	array: NATURAL_8 = 0x11
			-- Contiguious value array type (non-typed)

	struct: NATURAL_8 = 0x12
			-- Complex struct type.

feature {NONE} -- Access: Masks

	complex_type_mask: NATURAL_8 = 0x10
			-- Mask for complex types

feature -- Status report

	is_integral: BOOLEAN
			-- Indicates if the type is a integral type.
		do
			Result := (internal_value & complex_type_mask) = 0
		ensure
			not_is_complex: Result implies not is_complex
		end

	is_complex: BOOLEAN
			-- Indicates if the type is a complext type.
		do
			Result := (internal_value & complex_type_mask) = complex_type_mask
		ensure
			not_is_integral: Result implies not is_integral
		end

feature {NONE} -- Factory

	members: ARRAY [NATURAL_8]
			-- <Precursor>
		once
			Result := <<string, boolean, integer, double, date, base64, array, struct>>
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
