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
		local
			i: INTEGER
		do
			terminated := True
			sem.post
			from
				i := 1
			until
				i = 10_000_000
			loop
				f (i)
				i := i + 1
			end
		end

	f (i: INTEGER)
		do
			my_attribute := i * (i - 1) ^ 5
		end
		
	my_attribute: DOUBLE

	sem: SEMAPHORE
		
end
