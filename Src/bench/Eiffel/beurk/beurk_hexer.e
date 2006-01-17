indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."

class BEURK_HEXER
		
obsolete
	"Beurk Beurk Beurk"
	
inherit

	PLATFORM


feature {NONE}

	hex_to_integer_32 (s: STRING): INTEGER is
		require
			s_not_void: s /= Void
		local
			i, nb: INTEGER;
			temp: STRING;
			char: CHARACTER
		do
			temp := s.as_lower
			nb := temp.count

			if nb >= 2 and then temp.item (2) = 'x' then
				i := 3
			else
				i := 1
			end

			from
			until
				i > nb
			loop
				Result := Result * 16
				char := temp.item (i)
				if char >= '0' and then char <= '9' then
					Result := Result + (char |-| '0')
				else
					Result := Result + (char |-| 'a' + 10)
				end
				i:= i + 1
			end
		end

	hex_to_integer_64 (s: STRING): INTEGER_64 is
		require
			s_not_void: s /= Void
		local
			i, nb: INTEGER;
			temp: STRING;
			char: CHARACTER
		do
			temp := s.as_lower
			nb := temp.count

			if nb >= 2 and then temp.item (2) = 'x' then
				i := 3
			else
				i := 1
			end

			from
			until
				i > nb
			loop
				Result := Result * 16
				char := temp.item (i)
				if char >= '0' and then char <= '9' then
					Result := Result + (char |-| '0')
				else
					Result := Result + (char |-| 'a' + 10)
				end
				i:= i + 1
			end
		end
		
	hex_to_pointer (s: STRING): POINTER is
		require
			s_not_void: s /= Void
		local
			val_32: INTEGER
			val_64: INTEGER_64
		do
			if Pointer_bytes = Integer_64_bytes then
				val_64 := hex_to_integer_64 (s)
				($Result).memory_copy ($val_64, Pointer_bytes)
			else
				val_32 := hex_to_integer_32 (s)
				($Result).memory_copy ($val_32, Pointer_bytes)
			end
		end
 
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
