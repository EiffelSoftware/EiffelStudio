class TEST

inherit
	THREAD
		rename
			make as thread_make
		end

create
	make, make_typed

feature

	make is
		local
		do
			thread_make
			i := 0
			launch
			join_all
			execution_environment.sleep (5_000_000_000)
			print ("Hello from the GC%N")
			exit_application (0)
		end

	exit_application (code: INTEGER) is
		external
			"C use %"eif_eiffel.h%""
		alias
			"exit"
		end

	make_typed (v: like i) is
		do
			thread_make
			i := v
		end

	i: INTEGER

	execute is
		local
			t: TEST
		do
			inspect i
			when 0 then
				create t.make_typed (i + 1)
				t.launch
--				t.join

			else
				if i < 50 then
					create t.make_typed (i + 1)
					t.launch
--					t.join
					if i = 49 then
						execution_environment.sleep (1_000_000_000)
					end
				end
			end
		end

	execution_environment: EXECUTION_ENVIRONMENT is
		once
			create Result
		end

end

