class IDENTIFIER

inherit

	STRING

create

	make

feature

	is_valid: BOOLEAN is
			-- Is Current a valid Eiffel identifier?
		local
			i, c: INTEGER;
			char: CHARACTER
		do
			c := count;
			if c /= 0 and then item(1).is_alpha then
				from
					Result := True;
					i := 2;
				until
					i > c or else not Result
				loop
					char := item (i);
					Result := char.is_digit or else 
								char.is_alpha or else
								char = '_';
					i := i + 1
				end
			end
		end

end
