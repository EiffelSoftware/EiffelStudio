note
	description: "Example application that shows how to do concurrent file reads and writes with the help of futures and tasks."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	IO_WORKER_POOL

create
	make

feature -- Constants

	paths: ARRAY [STRING]
			-- The files used in this example.
		attribute
			Result := << "a.txt", "b.txt", "c.txt" >>
		end

	hello_world: STRING = "Hello World%N"

	content: STRING =
		"[
			Lorem ipsum dolor sit amet, consetetur sadipscing elitr, 
			sed diam nonumy eirmod tempor invidunt ut labore et dolore 
			magna aliquyam erat, sed diam voluptua. At vero eos et accusam 
			et justo duo dolores et ea rebum. Stet clita kasd gubergren, 
			no sea takimata sanctus est Lorem ipsum dolor sit amet.
		]"

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
				-- Make sure we don't have any leftover files from the last run.
			delete_all

				-- Create the worker pools.
			create worker_pool.make (100, 4)
			create executor.make (worker_pool)

				-- Run all features
			run_all

				-- Stop the executor. This is necessary such that the application can terminate.
			executor.stop

				-- Clean all files.
			delete_all
		end

	delete_all
			-- Delete all files.
		local
			file: PLAIN_TEXT_FILE
		do
			across
				paths as cursor
			loop
				create file.make_open_write (cursor.item)
				file.close
				file.delete
			end
		end

feature -- Basic operations

	run_all
			-- Run all example features
		do
			single_read_write
			concurrent_write
			concurrent_read
		end

	single_read_write
			-- Perform a single write operation on file A.
		local
			write_task: FILE_APPENDER_TASK
			write_task_promise: CP_PROMISE_PROXY

			read_task: FILE_READER_TASK
			read_task_promise: CP_RESULT_PROMISE_PROXY [STRING, CP_STRING_IMPORTER]

			l_result: detachable STRING
		do
				-- First, create a task.
			create write_task.make (paths [1], hello_world)

				-- The next statment submits the task and returns a promise object which can be used to control the asynchronous task.
			write_task_promise := executor.put_and_get_promise (write_task)

				-- Let's wait for the task to finish.
			write_task_promise.await_termination

				-- It is possible to check for IO exceptions in the asynchronous task.
			check no_exception: not write_task_promise.is_exceptional end

				-- Now we can read the contents of file A.
			create read_task.make (paths [1])

				-- Again, this statement submits the task and returns a promise.
			read_task_promise := executor.put_and_get_result_promise (read_task)

				-- The promise can be used to get the result of the asynchronous computation.
				-- Note that the statement blocks if the result is not yet available.
			l_result := read_task_promise.item

				-- Check if the read-write cycle worked as expected.
			check correct_result: l_result ~ hello_world end
		end

	concurrent_write
			-- Write to three files concurrently.
		local
			promises: ARRAYED_LIST [CP_PROMISE_PROXY]
			task: FILE_APPENDER_TASK
		do
			create promises.make (paths.count)

			across
				paths as path_cursor
			loop
					-- Create the task.
				create task.make (path_cursor.item, content)

					-- Submit the task and store the promise.
				promises.extend (executor.put_and_get_promise (task))
			end

				-- All three files are being written concurrently now.

			across
				promises as promise_cursor
			loop
					-- We can wait for termination of the tasks now.
				promise_cursor.item.await_termination
			end

				-- Every file has `content' at the end now.
		end

	concurrent_read
			-- Read three files concurrently.
		local
			promises: ARRAYED_LIST [CP_RESULT_PROMISE_PROXY [STRING, CP_STRING_IMPORTER]]
			task: FILE_READER_TASK
			l_result: detachable STRING
		do
			create promises.make (paths.count)

			across
				paths as path_cursor
			loop
					-- Create the tasks.
				create task.make (path_cursor.item)

					-- Submit the task and store the promise.
				promises.extend (executor.put_and_get_result_promise (task))
			end

				-- All three files are being read concurrently now.

			across
				promises as promise_cursor
			loop
					-- Collect the results.
				l_result := promise_cursor.item.item

					-- Check if the result is still `content', as it was written earlier.
				check same_result: attached l_result and then l_result.ends_with (content) end
			end
		end


feature {NONE} -- Implementation

	worker_pool: separate CP_TASK_WORKER_POOL
			-- The worker pool that executes the IO tasks.

	executor: CP_FUTURE_EXECUTOR_PROXY [STRING, CP_STRING_IMPORTER]
			-- The executor proxy for to submit tasks.

end
