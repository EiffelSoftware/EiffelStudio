indexing
	description: "Copy from BEURK_HEXER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class SD_HEXER

inherit

	PLATFORM

feature

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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
