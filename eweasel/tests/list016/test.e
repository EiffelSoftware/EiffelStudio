class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			linked_list_is_inserted
			linked_list_merge_left
			linked_list_merge_right
			linked_list_put_front
		end
		
	linked_list_is_inserted
			-- `is_inserted' relies on the fact that it can only be called from `extend' or `put',
			-- but there in reality any client can call it,
			-- so the check inside `is_inserted' is incorrect.
		local
			list: LINKED_LIST [INTEGER]
			b: BOOLEAN
		do
			create list.make
			list.extend (1)
			b := list.is_inserted (2)
		end

	linked_list_merge_left
			-- If `is_empty', `merge_left' sets `active' to `first_element',
			-- but should set to `last_element', as `is_empty' implies `after'.
		local
			list1, list2: LINKED_LIST [INTEGER]
		do
			create list1.make
			list1.extend (1)
			list1.extend (2)
			create list2.make
			list2.start
			check list2.after end
			list2.merge_left (list1)
		end

	linked_list_merge_right
			-- `list1' should be inserted at the beginning of `list2',
			-- but instead is inserted after the first element.
			-- (`merge_right' does not handle the special case of `before').
		local
			list1, list2: LINKED_LIST [INTEGER]
		do
			create list1.make
			list1.extend (1)
			list1.extend (2)
			create list2.make
			list2.extend (3)
			list2.extend (4)
			list2.go_i_th (0)
			check list2.before end
			list2.merge_right (list1)
			check list2 [1] = 1 end
		end

	linked_list_put_front
			-- Here nothing fails, but there is a subtle problem inside `put_front':
			-- it calls `is_empty' in an inconsistent state (when `count' = 0, but `first_element' /= Void).
			-- This would return wrong result if the implementation of `is_empty' suddenly changed to `Result := first_element = Void'.
			-- See also: `two_way_list_merge_right_2'.
		local
			list: LINKED_LIST [INTEGER]
		do
			create list.make
			list.put_front (1)
		end
		
end