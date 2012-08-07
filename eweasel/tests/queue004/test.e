class TEST

create
	make

feature

	make
		do
			arrayed_queue_is_equal_1
			arrayed_queue_is_equal_2
		end

	arrayed_queue_is_equal_1
			-- Index out of bounds for the second queue after it wraps around the end of the array.
		local
			queue_1, queue_2: ARRAYED_QUEUE [INTEGER]
			b: BOOLEAN
		do
			create queue_1.make (2)
			queue_1.put (1)
			queue_1.put (2)
			queue_1.remove
			queue_1.put (3)
			create queue_2.make (2)
			queue_2.put (1)
			queue_2.put (2)
			queue_2.remove
			queue_2.put (3)
			b := queue_1.is_equal (queue_2)
		end

	arrayed_queue_is_equal_2
			-- The same as arrayed_queue_is_equal_1, but with object comparison;
			-- the bug occurs in is_equal twice (in both branches of "if object_comparison").
		local
			queue1, queue2: ARRAYED_QUEUE [INTEGER]
			b: BOOLEAN
		do
			create queue1.make (2)
			queue1.compare_objects
			queue1.put (1)
			queue1.put (2)
			queue1.remove
			queue1.put (3)
			create queue2.make (2)
			queue2.compare_objects
			queue2.put (1)
			queue2.put (2)
			queue2.remove
			queue2.put (3)
			b := queue1.is_equal (queue2)
		end
end

