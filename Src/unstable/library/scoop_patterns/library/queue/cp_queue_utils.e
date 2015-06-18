note
	description: "Utility functions to access a separate CP_QUEUE."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_QUEUE_UTILS [G]

feature -- Access

	queue_item (queue: separate CP_QUEUE [G, CP_IMPORT_STRATEGY [G]]): separate G
			-- Retrieve the oldest item from `queue'.
		do
			Result := queue.item
		end

	queue_count (queue: separate CP_QUEUE [G, CP_IMPORT_STRATEGY [G]]): INTEGER
			-- Number of items in `queue'.
		do
			Result := queue.count
		end

	queue_capacity (queue: separate CP_QUEUE [G, CP_IMPORT_STRATEGY [G]]): INTEGER
			-- Capacity of `queue'. May be negative if unbounded.
		do
			Result := queue.capacity
		end

feature -- Status report

	is_queue_bounded (queue: separate CP_QUEUE [G, CP_IMPORT_STRATEGY [G]]): BOOLEAN
			-- Does `queue' have a maximum capacity?
		do
			Result := queue.is_bounded
		end

	is_queue_full (queue: separate CP_QUEUE [G, CP_IMPORT_STRATEGY [G]]): BOOLEAN
			-- Is `queue' full?
		do
			Result := queue.is_full
		end

	is_queue_empty (queue: separate CP_QUEUE [G, CP_IMPORT_STRATEGY [G]]): BOOLEAN
			-- Is `queue' empty?
		do
			Result := queue.is_empty
		end

feature -- Basic operations

	queue_put (queue: separate CP_QUEUE [G, CP_IMPORT_STRATEGY [G]]; item: separate G)
			-- Put `item' into `queue'.
		require
			not_full: not queue.is_full
		do
			queue.put (item)
		end

	queue_remove (queue: separate CP_QUEUE [G, CP_IMPORT_STRATEGY [G]])
			-- Remove the oldest item from `queue'.
		require
			not_empty: not queue.is_empty
		do
			queue.remove
		end

feature -- Compound operations

	queue_consume (queue: separate CP_QUEUE [G, CP_IMPORT_STRATEGY [G]]): separate G
			-- Retrieve and remove the oldest item from `queue'.
		require
			not_empty: not queue.is_empty
		do
			Result := queue.item
			queue.remove
		end

end
