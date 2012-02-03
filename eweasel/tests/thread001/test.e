class
	TEST

inherit
	THREAD
		rename
			make as thread_make
		end

create
	make

feature -- Initialization

	make
		do
			thread_make
			create timer_mutex.make
			create timer_condition.make
			launch
			join_all
		end

	execute is
		local
			i: INTEGER
			b: BOOLEAN
		do
			from
				timer_mutex.lock
				i := 1
			until
				i = 1000
			loop
				b := timer_condition.wait_with_timeout (timer_mutex, 10)
				i := i + 1
			end
			timer_mutex.unlock
		end

	timer_mutex: MUTEX

	timer_condition: CONDITION_VARIABLE

end
