deferred class
	R_STR

feature

	make_empty
			-- Create empty string.
		do
		end

	elks_checking: BOOLEAN is False

	infix "+" (other: R_STR): like Current is
		deferred
		ensure
			Result /= Void
		end

end
