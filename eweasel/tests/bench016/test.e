note
	description:
		"[
			A stress test for SCOOP. The test is designed to put a lot of pressure on the memory allocation
			subsystem (and consequently GC) while keeping the threads busy. To a lesser extent this test
			also exercises the evaluation of wait conditions.
			
			The test sets up several worker groups, which are a set of worker processors centered around
			a queue with tasks to be executed. The tasks are different kinds of matrix operations. Each
			worker is specialized to a certain task, and has to wait for a suitable task via wait conditions.
			
			Once an operation is finished, the worker checks whether there are more operations necessary on a
			task, in which case a new matrix is generated and the task object is put back into the queue.
		]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit
	HELPER

create
	make

feature -- Constants

	worker_group_count: INTEGER = 4

	default_task_count: INTEGER = 1000

	operation_count: INTEGER = 8

	maximum_matrix_size: INTEGER = 25

	minimum_matrix_size: INTEGER = 3

	maximum_queue_count: INTEGER = 1000

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			queue: separate TASK_QUEUE
			worker: separate WORKER
			task_queues: ARRAYED_LIST [separate TASK_QUEUE]
			specialization: INTEGER
			task_count: INTEGER
			i: INTEGER
		do
			create random.make_time
			create task_queues.make (worker_group_count)

				-- Create the task queues and the workers for each queue.
			across
				1 |..| worker_group_count as ignore
			loop
				create queue.make (100)
				task_queues.extend (queue)

				from specialization := 0 until specialization >= max_task_number loop
					create worker.make (queue, specialization)
					separate worker as l_worker do l_worker.live end
					specialization := specialization + 1
				end
			end

				-- Create the tasks
			from
				i := 0
				task_count := get_task_count
			until
				i > task_count
			loop
				queue := task_queues [i \\ worker_group_count + 1]
				add_task (queue, new_task)
				i := i + 1
			end

				-- Signal the queues that no more tasks will be inserted.
			across
				task_queues as cursor
			loop
				separate
					cursor.item as l_queue
				do
					l_queue.stop
				end
			end
		rescue
			print ("Error: In rescue.%N")
		end

feature {NONE} -- Implementation

	random: SIMPLE_RANDOM

	new_task: separate TASK
			-- Create a new task with random matrix size.
		local
			size: INTEGER
		do
			size := (random.new_integer \\ (maximum_matrix_size-minimum_matrix_size)) + minimum_matrix_size
			create Result.make (operation_count, size)
		end

	add_task (queue: separate TASK_QUEUE; task: separate TASK)
			-- Add a new task to `queue'.
		require
			not_full: queue.count < maximum_queue_count
		do
			queue.extend (task)
			queue.increment_task_count
		end

	get_task_count: INTEGER
			-- Get task count from command line arguments.
			-- Use default value if none provided.
		local
			args: ARGUMENTS_32
		do
			create args
			if args.argument_count < 1 or else not args.argument (1).is_integer_32 then
				Result := default_task_count
			else
				Result := args.argument (1).to_integer_32
			end
		end

end
