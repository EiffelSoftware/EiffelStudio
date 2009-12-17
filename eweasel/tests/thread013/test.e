class TEST

create
	make

feature

	make
		do
			test_mutex
			test_semaphore
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
				io.put_string ("Semaphore Wait 1 Success%N")
			end

				-- Ensure that the wait will eventually return when the other thread will post.
			create worker_thread_1.make (agent semaphore_wait (sem))
			worker_thread_1.launch
			create worker_thread_2.make (agent sem.post)
			worker_thread_2.launch
			worker_thread_2.join
			worker_thread_1.join
		end

	semaphore_wait (a_sem: SEMAPHORE)
		do
			a_sem.wait
			io.put_string ("Semaphore Wait 2 Success%N")
		end

end
