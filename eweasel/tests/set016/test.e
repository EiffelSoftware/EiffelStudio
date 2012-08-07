class 
	TEST

create

	make

feature {NONE} -- Initialization

	make
			-- Execute test.
		do
			subset_duplicate_orig_1
			subset_duplicate_orig_2
		end

	subset_duplicate_orig_1
			-- Postcondition does not take cursor position into account
			-- (alternatively: should not use the implementation from CHAIN).
			-- Note: it does not fail, cause aparently only postconditions from one branch of inheritance are checked.
		local
			set: ARRAYED_SET [INTEGER]
		do
			create set.make (10)
			set.extend (1)
			set.extend (2)
			set.go_i_th (2)
			set := set.duplicate (2)
		end

	subset_duplicate_orig_2
			-- Postcondition does not take cursor position into account
			-- (different clause fails than in `subset_duplicate_1').
			-- Note: it does not fail, cause aparently only postconditions from one branch of inheritance are checked.			
		local
			set: ARRAYED_SET [INTEGER]
		do
			create set.make (10)
			set.extend (1)
			set.extend (2)
			set.go_i_th (2)
			set := set.duplicate (3)
		end
		
end