class TEST

inherit
	THREAD

create
	make, make_thread

feature

	make is
		local
		do
			make_thread (0)
			launch
			join_all
			execution_environment.sleep (50_000_000_000)
			print ("Hello from the GC%N")
		end

	make_thread (v: like level) is
		do
			level := v
		end

	level: INTEGER

	execute is
		local
			t: TEST
			j: INTEGER
		do
			if level = 0 then
				from
					j := 1
				until
					j = 50
				loop
					create t.make_thread (1)
					t.launch
					j := j + 1
				end
			elseif level = 1 then
				create t.make_thread (2)
				t.launch
			else
				execution_environment.sleep (1_000_000_000)
			end
		end

	execution_environment: EXECUTION_ENVIRONMENT is
		once
			create Result
		end

end

