class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		do
			arrayed_set_duplicate
			arrayed_set_is_equal
			arrayed_set_put_left_1
			arrayed_set_put_left_2
		end

	arrayed_set_duplicate
			-- ARRAYED_SET.duplicate inherits stronger precondition from CHAIN than from SUBSET;
			-- As a result the precondition is violated unexpectedly for clients of SUBSET.
			-- Note that the inherited preconditions should be or-ed, but they are not.
			-- If they were, the call would fail later.
		local
			set1: ARRAYED_SET [INTEGER]
			set2, set3: SUBSET [INTEGER]
		do
			create set1.make (2)
			set1.extend (1)
			set1.extend (2)
			set1.go_i_th (0)
			set2 := set1
			set3 := set2.duplicate (2)
		end

	arrayed_set_is_equal
			-- Order is taken into account when comparing sets.
		local
			set1, set2: ARRAYED_SET [INTEGER]
		do
			create set1.make (2)
			set1.extend (1)
			set1.extend (2)
			create set2.make (2)
			set2.extend (2)
			set2.extend (1)
			check set1.is_equal (set2) end
		end

	arrayed_set_put_left_1
			-- Inconsistent behavior of put_left depending on the cursor position
			-- (because it uses `extend' when the cursor is after, and `extend' is redefined for sets).
		local
			set: ARRAYED_SET [INTEGER]
		do
			create set.make (3)
			set.extend (1)
			set.extend (2)
			set.go_i_th (2)
			-- Here 1 is added (again) at position 2:
			set.put_left (1)
			check set.count = 3 end
			set.go_i_th (4)
			-- But here (when the cursor is after) it's not added
			-- (contradicting the postcondition and header comment of put_left)
			set.put_left (1)
		end

	arrayed_set_put_left_2
			-- `put_left' lets you add duplicate elements to the set.
			-- This bug is related to `arrayed_set_put_left_1',
			-- but `arrayed_set_put_left_1' shows that the implementation of `put_left' should be fixed (to satisfy its postcondition)
			-- and the current test case shows that the export status of `put_left' should be fixed.
		local
			set: ARRAYED_SET [INTEGER]
		do
			create set.make (3)
			set.extend (1)
			set.extend (2)
			set.go_i_th (2)
			set.put_left (1)
			check set.count = 2 end
		end
		
end

