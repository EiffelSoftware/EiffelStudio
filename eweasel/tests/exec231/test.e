class
	TEST
create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			l_list: ARRAYED_LIST [ANY]
			l_int: INTEGER
		do
			create l_list.make (1)
			l_list.extend (l_int)
		end

end
