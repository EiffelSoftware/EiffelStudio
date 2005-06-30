
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
 
end
