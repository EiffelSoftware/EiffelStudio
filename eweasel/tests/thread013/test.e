class TEST
inherit
	EXECUTION_ENVIRONMENT

create
	make

feature

	make
		do
			test_mutex
			test_semaphore
			test_condvar
			test_read_write_lock
		end

feature {NONE} -- Mutex

	test_mutex
		local
			mutex: MUTEX
			worker_thread: WORKER_THREAD
		do
			create mutex.make

				-- Let's verify we do have recursive mutex
			mutex.lock
			mutex.lock
			mutex.unlock
			mutex.unlock

				-- `mutex' can now be locked by any thread, let's verify that
			create worker_thread.make (agent critical_section_1 (mutex))
			worker_thread.launch
			worker_thread.join

				-- `mutex' cannot be locked by any thread, let's verify that
			mutex.lock
			create worker_thread.make (agent critical_section_2 (mutex))
			worker_thread.launch
			worker_thread.join
			mutex.unlock

				-- Let's verify recursive mutex works properly
			mutex.lock
			mutex.lock
			mutex.unlock
			if mutex.try_lock then
				io.put_string ("Mutex Rec Success%N")
				mutex.unlock
			end
			mutex.unlock

				-- `mutex' can now be locked by any thread, let's verify that
			create worker_thread.make (agent critical_section_1 (mutex))
			worker_thread.launch
			worker_thread.join
		end

	critical_section_1 (a_mutex: MUTEX)
			-- Blocking lock on `a_mutex'.
		do
			a_mutex.lock
			io.put_string ("Mutex CS1 Success%N")
			a_mutex.unlock
		end

	critical_section_2 (a_mutex: MUTEX)
			-- Tentative of lock on `a_mutex'.
		do
			if a_mutex.try_lock then
				a_mutex.unlock
			else
				io.put_string ("Mutex CS2 Success%N")
			end
		end

feature {NONE} -- Semaphore

	test_semaphore
		local
			sem: SEMAPHORE
			worker_thread_1, worker_thread_2: WORKER_THREAD
		do
			create sem.make (0)

				-- Ensure that we haven't decremented the counter
			if not sem.try_wait then
				io.put_string ("Semaphore trywait 1 False%N")
			end

				-- Ensure that the wait will eventually return when the other thread will post.
			create worker_thread_1.make (agent semaphore_wait (sem))
			worker_thread_1.launch
			create worker_thread_2.make (agent sem.post)
			worker_thread_2.launch
			worker_thread_2.join
			worker_thread_1.join

			create sem.make (2)
			sem.wait
			sem.wait

				-- Ensure that we haven't decremented the counter
			if not sem.try_wait then
				io.put_string ("Semaphore trywait 2 False%N")
			end

			sem.post
			sem.post

			if sem.try_wait then
				io.put_string ("Semaphore trywait 3 True%N")
				sem.post
			end

				-- Ensure we can augment the initial count.
			sem.post
			sem.post

			sem.wait
			sem.wait
			sem.wait
			sem.wait

			if not sem.try_wait then
				io.put_string ("Semaphore trywait 4 False%N")
			end
		end

	semaphore_wait (a_sem: SEMAPHORE)
		do
			a_sem.wait
			io.put_string ("Semaphore wait 1 Success%N")
		end

feature {NONE} -- Condition variable

	test_condvar
		local
			cond_var: CONDITION_VARIABLE
			mutex: MUTEX
			worker_thread_1, worker_thread_2: WORKER_THREAD
			i: INTEGER
		do
			create cond_var.make
			create mutex.make

			cond_var.signal
			cond_var.broadcast

			mutex.lock
			if not cond_var.wait_with_timeout (mutex, 10) then
				io.put_string ("Condition variable wait 1 Success%N")
			end
			mutex.unlock

				-- Testing signal
			create worker_thread_1.make (agent condition_wait (mutex, cond_var))
			worker_thread_1.launch

			from
				i := 1
			until
				i = 11
			loop
				mutex.lock
				counter := i
				mutex.unlock
				cond_var.signal
				sleep (100_000_000)
				i := i + 1
			end

			worker_thread_1.join

				-- Testing broadcast
			create worker_thread_1.make (agent condition_wait (mutex, cond_var))
			worker_thread_1.launch
			create worker_thread_2.make (agent condition_wait (mutex, cond_var))
			worker_thread_2.launch

			from
				i := 1
			until
				i = 11
			loop
				mutex.lock
				counter := i
				mutex.unlock
				cond_var.broadcast
				sleep (100_000_000)
				i := i + 1
			end

			worker_thread_1.join
			worker_thread_2.join
		end

	counter: INTEGER

	condition_wait (a_mutex: MUTEX; a_cond_var: CONDITION_VARIABLE)
		do
			a_mutex.lock
			from
			until
				counter = 10
			loop
				a_cond_var.wait (a_mutex)
			end
			io.put_string ("Condition variable wait 2 Success%N")
			a_mutex.unlock
		end

feature {NONE} -- Read/Write Lock

	test_read_write_lock
		local
			lock: READ_WRITE_LOCK
			launch_semaphore: SEMAPHORE
			worker_thread_1, worker_thread_2: WORKER_THREAD
		do
			create lock.make
				-- Verify read locks are recursive
			lock.acquire_read_lock
			lock.acquire_read_lock
			lock.release_reader_lock
			lock.release_reader_lock

				-- Write locks are not recursive, we test simple sequence
			lock.acquire_write_lock
			lock.release_writer_lock

			lock.acquire_read_lock
			io.put_string ("Read Lock 1 Success%N")
				-- Use a semaphore to ensure that `worker_thread_1' locks before `worker_thread_2'.
			create launch_semaphore.make (0)
			create worker_thread_1.make (agent reader_lock (launch_semaphore, lock))
			worker_thread_1.launch
			launch_semaphore.wait
			create worker_thread_2.make (agent writer_lock (lock))
			worker_thread_2.launch
			lock.release_reader_lock

			worker_thread_1.join
			worker_thread_2.join
		end

	writer_lock (a_lock: READ_WRITE_LOCK)
		do
			a_lock.acquire_write_lock
			io.put_string ("Write Lock Success%N")
			a_lock.release_writer_lock
		end

	reader_lock (a_sem: SEMAPHORE; a_lock: READ_WRITE_LOCK)
		do
			a_lock.acquire_read_lock
			a_sem.post
				-- Put a sleep to ensure that `writer_lock' will indeed wait for the lock
				-- to be released at the end of the routine and not before
			sleep(100_000_000)
			io.put_string ("Read Lock 2 Success%N")
			a_lock.release_reader_lock
		end

end
