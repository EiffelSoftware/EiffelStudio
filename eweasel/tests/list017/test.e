class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			two_way_list_merge_right_1
			two_way_list_merge_right_2
		end
		
	two_way_list_merge_right_1
			-- If `is_last' and not `is_empty' and `other.is_empty',
			-- sets `last_element' to `other.last_element' (Void), though it actually shouldn't change.
		local
			list1, list2: TWO_WAY_LIST [INTEGER]
		do
			create list1.make
			list1.extend (1)
			list1.finish
			create list2.make
			list1.merge_right (list2)
		end

	two_way_list_merge_right_2
			-- Here nothing fails, but there is a subtle problem inside `merge_right':
			-- it calls `is_last' in an inconsistent state (when `last_element' has already changed to `other.last_element'),
			-- which causes `is_last' to return a wrong result: False when True is expected.
		local
			list1, list2: TWO_WAY_LIST [INTEGER]
		do
			create list1.make
			list1.extend (1)
			list1.finish
			create list2.make
			list2.extend (2)
			list1.merge_right (list2)
		end
		
end