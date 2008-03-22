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


	new_list: ARRAYED_LIST [like new_tuple] is
		do
			create stack.make (10)
			stack.extend (Void)
			stack.start
			Result := stack.item
		end

	new_tuple: TUPLE [INTEGER, INTEGER] is
		do
		end

	stack: ARRAYED_LIST [like new_list]

end
