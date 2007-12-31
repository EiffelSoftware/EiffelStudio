class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local		
			alist1: !ARRAYED_LIST [?ANY]
			list1: !LIST [?ANY]
			list1_b: ?LIST [?ANY]
			
			alist2: !ARRAYED_LIST [!ANY]
			list2: !LIST [!ANY]
			list2_b: ?LIST [!ANY]
		do
			create alist1.make (0)
			list1 := alist1
			list1_b := alist1
			
			create alist2.make (0)
			list2 := alist2
			list2_b := alist2
			list1_b := alist2
		end

end