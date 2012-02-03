class MY_THREAD

inherit
	THREAD
		rename
			make as thread_make
		end

create
	make

feature {NONE} -- Initialization

	make (m: SEMAPHORE)
		do
			thread_make
			sem := m
		end

feature

	execute
		do
			terminated := True
			sem.post
			sleep (10_000_000_000)
		end

	sem: SEMAPHORE
		
end
