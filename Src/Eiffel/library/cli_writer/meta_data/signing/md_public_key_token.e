indexing
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

	make_from_array (data: ARRAY [NATURAL_8]) is
			-- Initialize `item' with content of `data'.
		require
			data_not_void: data /= Void
		do
			create item.make_from_array (data)
		end
		
	make_from_string (data: STRING) is
			-- Initialize `item' with content of `data' expressed in hexadecimal.
		require
			data_not_void: data /= Void
			valid_count: data.count \\ 2 = 0
		local
			l_data: ARRAY [NATURAL_8]
			l_byte: STRING
			i, nb: INTEGER
		do
			nb := data.count
			create l_data.make (1, data.count // 2)
			from
				i := 1
			until
				i > nb
			loop
				l_byte := data.substring (i, i + 1)
				l_data.put (read_hexa_value (l_byte).to_natural_8, i // 2 + 1)
				i := i + 2
			end
			make_from_array (l_data)
		end
		
	read_hexa_value (s: STRING): INTEGER is
			-- Convert `s' hexadecimal value into an integer representation.
		require
			s_not_void: s /= Void
			s_large_enough: s.count >= 1 and s.count <= 8
		local
			i, j: INTEGER
			last_integer: INTEGER
			area: SPECIAL [CHARACTER]
			val: CHARACTER
		do
			area := s.area
			j := s.count - 1

			from
			until
				(j - i) < 0 or i = 8
			loop
				val := area.item (j - i).lower
				inspect
					val
				when 'a' then
					last_integer := last_integer | ((10).to_integer_32 |<< (i * 4))
				when 'b' then
					last_integer := last_integer | ((11).to_integer_32 |<< (i * 4))
				when 'c' then
					last_integer := last_integer | ((12).to_integer_32 |<< (i * 4))
				when 'd' then
					last_integer := last_integer | ((13).to_integer_32 |<< (i * 4))
				when 'e' then
					last_integer := last_integer | ((14).to_integer_32 |<< (i * 4))
				when 'f' then
					last_integer := last_integer | ((15).to_integer_32 |<< (i * 4))
				else
					last_integer := last_integer | ((val.code - 48) |<< (i * 4))
				end
				i := i + 1
			end
			
			Result := last_integer
		end

feature -- Access

	item: MANAGED_POINTER
			-- Store public key token.

invariant
	item_not_void: item /= Void
	
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

end -- class MD_PUBLIC_KEY_TOKEN
