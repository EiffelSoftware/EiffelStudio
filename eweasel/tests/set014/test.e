class 
	TEST

create

	make

feature {NONE} -- Initialization

	make
			-- Execute test.
		do
			linear_subset_valid_index_orig
		end

	linear_subset_valid_index_orig
			-- LINEAR_SUBSET.valid_index has an absurd postcondition `0 <= n and n <= count + 1'.
			-- Note: it does not fail, cause aparently only postconditions from one branch of inheritance are checked.	
		local
			set: LINKED_SET [INTEGER]
			b: BOOLEAN
		do
			create set.make
			b := set.valid_index (100)
		end		
	
end