class
	TEST

inherit
	EXECUTION_ENVIRONMENT
	
	MEMORY

create
	make

feature

	make
		local
			t1, t2: WORKER_THREAD
			i: INTEGER
			s: STRING
		do
			create t1.make (agent execute)
			create t2.make (agent execute)
			t1.launch
			t2.launch

			from
				i := 1
			until
				i = 100_000
			loop
				create s.make (100)
				full_collect
				i := i + 1
			end
			io.put_string ("Success")
			io.put_new_line
		end

	execute
		local
			s: STRING
			i: INTEGER
		do
			from i := 1 until i = 1000 loop
				create s.make (100)
				i := i + 1
			end
			sleep (10_000_000_000)
		end

end
