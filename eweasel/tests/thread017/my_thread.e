class MY_THREAD

inherit
	THREAD

create
	make

feature {NONE} -- Initialization

	make (m: SEMAPHORE)
		do
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
