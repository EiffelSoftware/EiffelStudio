class
	TEST2

inherit
	TEST1
		redefine
			new_cursor, go_i_th
		end

feature

	go_i_th (a_cursor: like new_cursor) is
		do
			a_cursor.set
		end

	new_cursor: TEST4 is
		do
			create Result
		end

end
