class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			subset_strategy_hashable_disjoint_1
			subset_strategy_hashable_disjoint_2
			subset_strategy_hashable_symdif_1
			subset_strategy_hashable_symdif_2
		end

	subset_strategy_hashable_disjoint_1
			-- When set1 = set2, after adding the first element of set1 to hash,
			-- the cursor in set2 has also moved forth,
			-- so it is never discovers that they have common elements
		local
			set: TRAVERSABLE_SUBSET [INTEGER]
		do
			create {ARRAYED_SET [INTEGER]} set.make (2)
			set.extend (1)
			check not set.disjoint (set) end
		end

	subset_strategy_hashable_disjoint_2
			-- disjoint is a function, but it has a side effect of moving the cursor in both sets.
		local
			set1, set2: LINEAR_SUBSET [INTEGER]
			b: BOOLEAN
			i1, i2: INTEGER
		do
			create {ARRAYED_SET [INTEGER]} set1.make (2)
			set1.extend (1)
			create {ARRAYED_SET [INTEGER]} set2.make (2)
			set2.extend (2)
			i1 := set1.index
			i2 := set2.index
			b := set1.disjoint (set2)
			check set1.index = i1 and set2.index = i2 end
		end

	subset_strategy_hashable_symdif_1
			-- If an element from set2 has a hash collision with something from set1, but it is not equal,
			-- this new element is not added to symdif.
		local
			set1, set2: LINEAR_SUBSET [DOUBLE]
		do
			create {ARRAYED_SET [DOUBLE]} set1.make (2)
			set1.extend (0.1)
			create {ARRAYED_SET [DOUBLE]} set2.make (2)
			set2.extend (0.2)
			-- 0.1 and 0.2 have the same hash_code
			set1.symdif (set2)
			check set1.count = 2 end
		end

	subset_strategy_hashable_symdif_2
			-- If two elements from set1 have a hash collision,
			-- the second one is not added back to the symdif,
			-- because hashes are used as keys instead of values themselves
			-- (that's not how you use a hash table!)
		local
			set1, set2: LINEAR_SUBSET [DOUBLE]
		do
			create {ARRAYED_SET [DOUBLE]} set1.make (2)
			set1.extend (0.1)
			set1.extend (0.2)
			create {ARRAYED_SET [DOUBLE]} set2.make (2)
			set2.extend (1.1)
			set1.symdif (set2)
			-- 0.1 and 0.2 have the same hash_code
			check set1.count = 3 end
		end
		
end