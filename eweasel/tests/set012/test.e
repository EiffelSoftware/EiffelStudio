class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			traversable_subset_is_subset
		end

	traversable_subset_is_subset
			-- `is_subset' is a function, but it has a side effect of moving the cursor.
		local
			set1, set2: LINEAR_SUBSET [INTEGER] -- Using LINEAR instead of TRAVERSABLE to get access to index
			b: BOOLEAN
			i: INTEGER
		do
			create {ARRAYED_SET [INTEGER]} set1.make (1)
			set1.extend (1)
			create {ARRAYED_SET [INTEGER]} set2.make (1)
			set2.extend (1)
			i := set1.index
			b := set1.is_subset (set2)
			check set1.index = i end
		end
		
end