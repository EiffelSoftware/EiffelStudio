
class BEURK_HEXER

obsolete
	"Beurk Beurk Beurk"

feature {NONE}

	hex_to_integer (s: STRING): INTEGER is
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
 
end
