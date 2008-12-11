class
	TEST1 [G, H]

inherit
	TEST2 [!G]

	TEST3 [?H]

feature

	f is
		local
			list1: LINKED_LIST [G]
			list2: LINKED_LIST [!G]
			list3: LINKED_LIST [?G]
		do
			g
			h
			create list1.make
			create list2.make
			create list3.make
			io.put_string (list1.generating_type) io.put_new_line
			io.put_string (list2.generating_type) io.put_new_line
			io.put_string (list3.generating_type) io.put_new_line
		end

end
