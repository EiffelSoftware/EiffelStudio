class
	STR

inherit
	R_STR

create
	make_empty

feature

	infix "+" (other: R_STR): like Current is
		do
		end

	append_string (s: STR) is
			-- Append a copy of `s', if not void, at end.
		do
		ensure
			appended: s /= Void implies (elks_checking implies is_equal (old twin + old s.twin))
		end


end
