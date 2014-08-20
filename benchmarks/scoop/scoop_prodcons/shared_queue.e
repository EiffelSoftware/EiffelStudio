class
	SHARED_QUEUE [G]

create
	make

feature

	make
		do
			create q.make (1000)
		end

	enqueue (x: G)
		do
			q.extend (x)
		end

	dequeue: G
		require
			not is_empty
		do
			Result := q.item
			q.remove
		end

	is_empty: BOOLEAN
		do
			Result := q.is_empty
		end

feature

	q: ARRAYED_QUEUE [G]

end
