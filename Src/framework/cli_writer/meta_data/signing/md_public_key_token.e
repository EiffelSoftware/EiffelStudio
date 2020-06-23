note
	description: "A public key token"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_PUBLIC_KEY_TOKEN

create
	make_from_array,
	make_from_string

feature {NONE} -- Initialize

	make_from_array (data: ARRAY [NATURAL_8])
			-- Initialize `item' with content of `data'.
		require
			data_not_void: data /= Void
		do
			create item.make_from_array (data)
		end

	make_from_string (data: READABLE_STRING_32)
			-- Initialize `item' with content of `data' expressed in hexadecimal.
		require
			data_not_void: data /= Void
			valid_count: data.count \\ 2 = 0
		local
			l_data: ARRAY [NATURAL_8]
			i, nb: INTEGER
		do
			nb := data.count
			create l_data.make_filled (0, 1, data.count // 2)
			from
				i := 1
			until
				i > nb
			loop
				l_data.put (nibble (data [i]) |<< 4 + nibble (data [i + 1]), i // 2 + 1)
				i := i + 2
			end
			make_from_array (l_data)
		end

	nibble (c: CHARACTER_32): NATURAL_8
			-- Convert a hexadecimal unicode digit to the corresponding numeric value.
		require
			c.is_hexa_digit
		local
			mask: NATURAL_8
		do
				-- Convert full-width digits to ASCII.
			Result := ((c.natural_32_code & 0x7F) + ((c.natural_32_code & 0x100) |>> 3)).to_natural_8
				-- Mask out numbers.
			Result := Result & 0x4F
				-- Convert hexadecimal digits.
			mask := ((Result |<< 1).to_integer_8 |>> 7).to_natural_8
			Result := (Result & mask.bit_not) | ((Result - 55) & mask)
		ensure
			range: 0 <= Result and Result < 16
			value: ("0123456789ABCDEF") [Result + 1] = c.as_upper or ("０１２３４５６７８９ＡＢＣＤＥＦ") [Result + 1] = c.as_upper
		end

feature -- Access

	item: MANAGED_POINTER
			-- Store public key token.

invariant
	item_not_void: item /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
