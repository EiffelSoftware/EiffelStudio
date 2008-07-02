class
	STR

create
	make_empty

feature
	make_empty
			-- Create empty string.
		do
			do_nothing
		end

	infix "+" (other: STR): like Current is
		do
		ensure
			Result /= Void
		end

	append_string (s: STR) is
			-- Append a copy of `s', if not void, at end.
		do
		ensure
			appended: s /= Void implies (elks_checking implies is_equal (old twin + old s.twin))
		end

	elks_checking: BOOLEAN is False


end
