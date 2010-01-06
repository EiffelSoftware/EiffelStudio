class
	TEST3_BIS

inherit
	TEST3 [INTEGER]

feature

	query (a: INTEGER): REAL_64 is
		do
			Result := a / 3
		end

end
