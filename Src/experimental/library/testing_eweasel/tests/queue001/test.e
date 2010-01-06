class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application
		local
			queue: LINKED_PRIORITY_QUEUE [INTEGER]
			heap: HEAP_PRIORITY_QUEUE [INTEGER]
			n: INTEGER
		do
			create queue.make
			queue.extend (1)
			n := queue.item
			check n = 1 end
			queue.extend (2)
			n := queue.item
			check n = 2 end

			create heap.make (10)
			heap.extend (1)
			n := heap.item
			check n = 1 end
			heap.extend (2)
			n := heap.item
			check n = 2 end
		end

end
