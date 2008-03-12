class
	TEST1

feature

	go_i_th (a_cursor: like new_cursor) is
		do
			a_cursor.set
		end

	new_cursor: TEST3 is
		do
			create Result
		end

end
