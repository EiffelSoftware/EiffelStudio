class
	TEST2_BIS

inherit
	TEST2 [REAL_64]

feature

	query (a: INTEGER): REAL_64 is
		do
			Result := a / 3
		end

end
