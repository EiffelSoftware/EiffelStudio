note
	description: "Processor-local access to a separate CP_QUEUE object."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_QUEUE_PROXY [G, IMPORTER -> CP_IMPORT_STRATEGY [G] create default_create end]

inherit

	CP_PROXY [CP_QUEUE [G, IMPORTER], CP_QUEUE_UTILS [G]]
		rename
			subject as queue
		end

create
	make

feature -- Access

	last_consumed_item: detachable like importer.import
			-- The last consumed item.
			-- The separate status of the result type may vary depending on the chosen import strategy.

	count: INTEGER
			-- Number of items in the queue.
		do
			Result := utils.queue_count (queue)
		end

	capacity: INTEGER
			-- Capacity of `queue'. May be negative if unbounded.
		do
			Result := utils.queue_capacity (queue)
		end

	item: separate G
			-- Retrieve the oldest item from `queue'.
			-- Note: blocks if `queue' is empty.
		do
			Result := utils.queue_item (queue)
		end

feature -- Status report

	is_bounded: BOOLEAN
			-- Is `queue' bounded?
		do
			Result := utils.is_queue_bounded (queue)
		end

	is_full: BOOLEAN
			-- Is `queue' full?
		do
			Result := utils.is_queue_full (queue)
		end

	is_empty: BOOLEAN
			-- Is `queue' empty?
		do
			Result := utils.is_queue_empty (queue)
		end

feature -- Basic operations

	put (a_item: separate G)
			-- Insert `a_item' into `queue'.
			-- Note: blocks if `queue' is full.
		do
			utils.queue_put (queue, a_item)
		end

	remove
			-- Remove the oldest item from `queue'.
			-- Note: blocks if `queue' is empty.
		do
			utils.queue_remove (queue)
		end

	consume
			-- Retrieve and remove the oldest item from `queue'.
			-- The result is stored in `last_consumed_item'.
			-- Note: blocks if `queue' is empty.
		do
			last_consumed_item := importer.import (utils.queue_consume (queue))
		end

feature {NONE} -- Implementation

	importer: attached IMPORTER
			-- The selected import strategy.
		attribute
			create Result
		end

end
