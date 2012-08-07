class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			linear_subset_subset_strategy_selection_1
			linear_subset_subset_strategy_selection_2
			linear_subset_move_item_1
			linear_subset_move_item_2
		end
		
	linear_subset_subset_strategy_selection_1
			-- Hashable strategy is chosen based on the dynamic type of the first element of set1,
			-- regardless of the types of other elements of set1
		local
			set1, set2: LINEAR_SUBSET [ANY]
			b: BOOLEAN
		do
			create {ARRAYED_SET [ANY]} set1.make (2)
			set1.extend (1)
			set1.extend (create {ANY})
			create {ARRAYED_SET [ANY]} set2.make (2)
			set2.extend (2)
			b := set1.disjoint (set2)
		end

	linear_subset_subset_strategy_selection_2
			-- Hashable strategy is chosen based on the dynamic type of the first element of set1,
			-- regardless of the types of elements of set2
		local
			set1, set2: LINEAR_SUBSET [ANY]
			b: BOOLEAN
		do
			create {ARRAYED_SET [ANY]} set1.make (2)
			set1.extend (1)
			create {ARRAYED_SET [ANY]} set2.make (2)
			set2.extend (create {ANY})
			b := set1.disjoint (set2)
		end

	linear_subset_move_item_1
			-- If the cursor is after in the beginning,
			-- then after removing one element, it's not a valid position for go_i_th anymore.	
		local
			set: LINEAR_SUBSET [ANY]
		do
			create {ARRAYED_SET [ANY]} set.make (2)
			set.extend (1)
			set.extend (2)
			set.go_i_th (3)
			set.move_item (2)
		end

	linear_subset_move_item_2
			-- `move_item' lacks precondition `not before'.
		local
			set: LINEAR_SUBSET [ANY]
		do
			create {ARRAYED_SET [ANY]} set.make (2)
			set.extend (1)
			set.extend (2)
			set.go_i_th (0)
			set.move_item (2)
		end

end