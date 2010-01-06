class TEST

create
	make

feature

	make
		local
			queue: HEAP_PRIORITY_QUEUE [INTEGER]
		do
			create queue.make (5)
			queue.extend (1)
			queue.extend (2)
			queue.extend (3)
			queue.extend (4)
			queue.extend (5)

			remove_item (queue)
			remove_item (queue)
			remove_item (queue)
			remove_item (queue)
			remove_item (queue)
			check is_empty: queue.is_empty end
		end

	remove_item (a_queue: HEAP_PRIORITY_QUEUE [INTEGER])
		require
			a_queue_attached: a_queue /= Void
			not_a_queue_is_empty: not a_queue.is_empty
		do
			print (a_queue.item)
			print ('%N')
			a_queue.remove
		end

end
