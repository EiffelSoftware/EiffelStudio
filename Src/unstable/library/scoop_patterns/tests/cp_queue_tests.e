note
	description: "Test CP_QUEUE implementation."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_QUEUE_TESTS

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

feature -- Tests

	test_capacity_count
			-- Check if the relations between capacity, count and the boolean queries are correct.
		local
			i: INTEGER
		do
			assert ("wrong_capacity", queue.capacity = max_capacity)
			assert ("is_bounded", queue.is_bounded)
			assert ("wrong_count", queue.count = 0)
			assert ("is_empty", queue.is_empty)
			assert ("not_full", not queue.is_full)

			from
				i := 1
			until
				i > max_capacity
			loop
				queue.put (i.out)

				assert ("capacity_changed", queue.capacity = max_capacity)
				assert ("is_bounded", queue.is_bounded)
				assert ("wrong_count", queue.count = i)
				assert ("not_empty", not queue.is_empty)

				if i < max_capacity then
					assert ("not_full", not queue.is_full)
				else
					assert ("full", queue.is_full)
				end

				i := i + 1
			variant
				max_capacity + 1 - i
			end
		end

	test_put_remove
			-- Check put and remove cycles.
		local
			a: STRING
			b: STRING
		do
			a := "a"
			b := "b"

			assert ("empty", queue.is_empty)
			queue.put (a)

			assert ("not_inserted", queue.item = a) -- Only works with CPS_NO_IMPORT importer
			queue.put (b)

			assert ("wrong_count", queue.count = 2)
			assert ("FIFO_violation", queue.item = a)

			queue.remove
			assert ("wrong_count", queue.count = 1)
			assert ("not_removed", queue.item = b)

			queue.put (a)
			assert ("wrong_count", queue.count = 2)
			assert ("FIFO_violation", queue.item = b)

			queue.remove
			queue.remove

			assert ("not_empty", queue.is_empty)
		end

	test_initialization
			-- Test queue initialization with some special values.
		local
			l_queue: like queue
		do
				 -- Test an unbounded queue.
			create l_queue.make_unbounded

			assert ("not_empty", l_queue.is_empty)
			assert ("full", not l_queue.is_full)
			assert ("positive_capacity", l_queue.capacity < 0)
			assert ("bounded", not l_queue.is_bounded)

				-- Test an empty queue.
			create l_queue.make_bounded (1)
			assert ("not_empty", l_queue.is_empty)
			assert ("full", not l_queue.is_full)
			assert ("wrong_capacity", l_queue.capacity = 1)
			assert ("not_bounded", l_queue.is_bounded)
		end


	test_put_remove_access
			-- Test put and remove cycles with a queue access object.
		local
			a: STRING
			b: STRING
			queue_access: CP_QUEUE_PROXY [STRING, CP_NO_IMPORTER[STRING]]
			sep_queue: separate like queue
		do
			create sep_queue.make_bounded (max_capacity)
			create queue_access.make (sep_queue)
			assert ("correct_initialization", queue_access.queue = sep_queue)
			assert ("not_empty", queue_access.is_empty)
			assert ("full", not queue_access.is_full)
			assert ("correct_capacity", queue_access.capacity = max_capacity)

			a := "a"
			b := "b"

			queue_access.put (a)

			assert ("not_inserted", queue_access.item = a)
			queue_access.put (b)

			assert ("wrong_count", queue_access.count = 2)
			assert ("FIFO_violation", queue_access.item = a)

			queue_access.remove
			assert ("wrong_count", queue_access.count = 1)
			assert ("not_removed", queue_access.item = b)

			queue_access.put (a)
			assert ("wrong_count", queue_access.count = 2)
			assert ("FIFO_violation", queue_access.item = b)

			queue_access.consume

			assert ("wrong_consumed_item", queue_access.last_consumed_item = b)
			assert ("wrong_item", queue_access.item = a)
			assert ("wrong_count", queue_access.count = 1)

			queue_access.consume

			assert ("wrong_consumed_item", queue_access.last_consumed_item = a)
			assert ("not_empty", queue_access.is_empty)
		end

	test_int_queue
			-- Test put and remove cycles with a queue access object.
		local
			one, two: INTEGER
			queue_access: CP_QUEUE_PROXY [INTEGER, CP_NO_IMPORTER [INTEGER]]
			sep_queue: separate CP_QUEUE [INTEGER, CP_NO_IMPORTER [INTEGER]]
		do
			create sep_queue.make_bounded (max_capacity)
			create queue_access.make (sep_queue)
			assert ("correct_initialization", queue_access.queue = sep_queue)
			assert ("not_empty", queue_access.is_empty)
			assert ("full", not queue_access.is_full)
			assert ("correct_capacity", queue_access.capacity = max_capacity)

			one := 1
			two := 2

			queue_access.put (one)

			assert ("not_inserted", queue_access.item = one)
			queue_access.put (two)

			assert ("wrong_count", queue_access.count = 2)
			assert ("FIFO_violation", queue_access.item = one)

			queue_access.remove
			assert ("wrong_count", queue_access.count = 1)
			assert ("not_removed", queue_access.item = two)

			queue_access.put (one)
			assert ("wrong_count", queue_access.count = 2)
			assert ("FIFO_violation", queue_access.item = two)

			queue_access.consume

			assert ("wrong_consumed_item", queue_access.last_consumed_item = two)
			assert ("wrong_item", queue_access.item = one)
			assert ("wrong_count", queue_access.count = 1)

			queue_access.consume

			assert ("wrong_consumed_item", queue_access.last_consumed_item = one)
			assert ("not_empty", queue_access.is_empty)
		end

feature {NONE} -- Initialization

	on_prepare
			-- <Precursor>
		do
			create queue.make_bounded (max_capacity)
		end


	queue: CP_QUEUE [STRING, CP_NO_IMPORTER [STRING]]

	max_capacity: INTEGER = 10

end
