class TEST

create
	make

feature -- Initialization

	make
		local
			l_thread: MY_THREAD
			l_sem: SEMAPHORE
		do
				-- We use a semaphore to ensure that when we call `wait',
				-- the thread `terminated' attribute has been set to True.
			create l_sem.make (0)
			create l_thread.make (l_sem)
			l_thread.launch
			l_sem.wait
			l_thread.join
		end

end
