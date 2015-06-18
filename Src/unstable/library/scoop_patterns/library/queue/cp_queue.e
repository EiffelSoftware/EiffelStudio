note
	description: "Queues for data exchange in SCOOP."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_QUEUE [G, IMPORTER -> CP_IMPORT_STRATEGY [G] create default_create end]

create
	make_bounded, make_unbounded

feature {NONE} -- Initialization

	make_bounded (a_capacity: INTEGER)
			-- Create a bounded queue with capacity `a_capacity'.
		require
			non_negative: a_capacity > 0
		do
			capacity := a_capacity
			create store.make (a_capacity)
			create importer
		ensure
			correct_capacity: capacity = a_capacity
			correct_count: count = 0
			bounded: is_bounded
			empty: is_empty
		end

	make_unbounded
			-- Create an unbounded queue.
		do
			capacity := -1
			create store.make (1)
			create importer
		ensure
			correct_capacity: capacity < 0
			correct_count: count = 0
			not_bounded: not is_bounded
			empty: is_empty
		end

feature -- Access

	capacity: INTEGER
			-- The capacity of `Current'. May be negative if unbounded.

	count: INTEGER
			-- The number of items in `Current'.
		do
			Result := store.count
		ensure
			correct: Result = store.count
		end

	item: like importer.import
			-- Get the oldest item in `Current'.
		require
			not_empty: not is_empty
		do
			Result := store.item
		ensure
			correct: store.has (item) and Result = store.item
		end

feature -- Status report

	is_bounded: BOOLEAN
			-- Does `Current' have a maximum capacity?
		do
			Result := capacity > 0
		end

	is_full: BOOLEAN
			-- Is `Current' full?
		do
			Result := is_bounded and count = capacity
		end

	is_empty: BOOLEAN
			-- Is `Current' empty?
		do
			Result := count = 0
		end

feature -- Basic operations

	put (a_item: separate G)
			-- Insert `a_item' into the queue.
		require
			not_full: not is_full
		do
			store.put (importer.import (a_item))
		ensure
			count_correct: count = old count + 1
		end

	remove
			-- Remove the oldest item from `Current'.
		require
			not_empty: not is_empty
		do
			store.remove
		ensure
			removed: count = old count - 1
		end

feature {NONE} -- Implementation

	store: ARRAYED_QUEUE [like item]
			-- The internal storage for `Current'.

	importer: attached IMPORTER
			-- The import strategy for `Current'.

invariant
	valid_empty: is_empty = (count = 0)
	valid_bounded: is_bounded = (capacity > 0)
	valid_full: is_full implies (count = capacity)
	valid_capacity: capacity /= 0
	empty_full_relation: not (is_empty and is_full)

end
