class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			subset_strategy_generic_disjoint_1
			subset_strategy_generic_disjoint_2
			subset_strategy_generic_disjoint_3
		end

	subset_strategy_generic_disjoint_1
			-- When set1.count < set2.count, the precondition of set1.forth is violated.
		local
			set1, set2: TRAVERSABLE_SUBSET [ANY]
			b: BOOLEAN
		do
			create {ARRAYED_SET [ANY]} set1.make (2)
			set1.extend (create {ANY})
			create {ARRAYED_SET [ANY]} set2.make (2)
			set2.extend (create {ANY})
			set2.extend (create {ANY})
			b := set1.disjoint (set2)
		end

	subset_strategy_generic_disjoint_2
			-- When set2.count < set1.count, the precondition of set2.forth is violated.
		local
			set1, set2: TRAVERSABLE_SUBSET [ANY]
			b: BOOLEAN
		do
			create {ARRAYED_SET [ANY]} set1.make (2)
			set1.extend (create {ANY})
			set1.extend (create {ANY})
			create {ARRAYED_SET [ANY]} set2.make (2)
			set2.extend (create {ANY})
			b := set1.disjoint (set2)
		end

	subset_strategy_generic_disjoint_3
			-- disjoint is a function, but it has a side effect of moving the cursor in both sets.
		local
			set1, set2: LINEAR_SUBSET [ANY]
			b: BOOLEAN
			i1, i2: INTEGER
		do
			create {ARRAYED_SET [ANY]} set1.make (2)
			set1.extend (create {ANY})
			create {ARRAYED_SET [ANY]} set2.make (2)
			set2.extend (create {ANY})
			i1 := set1.index
			i2 := set2.index
			b := set1.disjoint (set2)
			check set1.index = i1 and set2.index = i2 end
		end
		
end