
class BEURK_HEXER obsolete "Beurk Beurk Beurk"

inherit
	BASIC_ROUTINES

feature {NONE}

	hex_to_integer (s: STRING): INTEGER is
		local
			i, nb: INTEGER;
			temp: STRING;
			char_val: INTEGER
		do
			temp := clone (s); temp.to_lower;
			nb := temp.count
			if nb >= 2 and then temp.item (2) = 'x' then
				i := 3
			else
				i := 1
			end;
			from
			until
				i > nb
			loop
				Result := Result * 16 ;
				char_val := charcode (temp.item (i));
				if
					char_val >= charcode_zero
				and then
					char_val <= charcode_nine
				then
					Result := Result + char_val - charcode_zero
				else
					Result := Result + char_val - charcode_a_minus_ten
				end
				i:= i + 1
			end
		end;

	charcode_zero: INTEGER is
		once
			Result := charcode ('0');
		end

	charcode_nine: INTEGER is
		once
			Result := charcode ('9')
		end

	charcode_a_minus_ten: INTEGER is
		once
			Result := charcode ('a') - 10
		end

end
