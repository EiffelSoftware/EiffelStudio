indexing
	description	: "System's root class"
	author		: "Volkan Arslan, Yann Mueller, Piotr Nienaltowski."
	date		: "$Date: 18.05.2007$"
	revision	: "1.0.0"

class
	APPLICATION

create
	make

feature -- Initialization

	make is
		-- Creation procedure.
	do
--			io.put_string ("Counter application%N")
--			test_1 -- start just one counter
			test_2 -- start two counters
--			test_3 -- start several counters
--			test_4 -- start counter_1 twice
			test_5 -- start counter_1 with precondition
--			test_6
	end

	test_1 is
			-- Launch counter_1
		do
			create counter_1.make (1, 500)
			launch_one (counter_1)
		end

	test_2 is
			-- Launch counter_1 and counter_2
		do
			create counter_1.make (1, 1000)
			create counter_2.make (2, 500)
			io.put_string ("Start of counter 1 and counter 2%N")
			launch_two (counter_1, counter_2)
			io.put_string ("Counter 1 and counter 2 started ...%N")
		end

	test_3 is
			-- Launch several (300) counter
		local
			i: INTEGER
			counter: separate COUNTER
		do
			from
				i := 1
			until
				i > 300
			loop
				create counter.make (i, 300)
				launch_one (counter)
				i := i + 1
			end
		end

	test_4 is
			-- Launch counter_1 twice
		do
			create counter_1.make (1, 50)
			launch_one_run_100 (counter_1)
			launch_one (counter_1)
		end

	test_5 is
			-- Launch counter_1 with precondition
		do
			create counter_1.make (1, 50)
			launch_one_run_100 (counter_1)
			launch_one_run_100 (counter_1)
			launch_one_with_precondition (counter_1)
			create counter_2.make (2, 50)
			launch_one_run_100 (counter_2)
			launch_one_with_precondition_2 (counter_1)
		end

	test_6 is
			-- Launch a_counter_1 separately and a_counter_2 non-separate
		local
			a_counter_1: separate COUNTER
			a_counter_2: COUNTER

		do
			create a_counter_1.make (1, 100)
			create a_counter_2.make (2, 300)
			launch_two_mixed (a_counter_1, a_counter_2)
		end

	launch_two_mixed (a_counter_1: separate COUNTER; a_counter_2: separate COUNTER) is
			--
		do
			a_counter_1.run
			a_counter_2.run
		end

	launch_one (a_counter: separate COUNTER) is
			-- Launch a_counter
		do
			a_counter.set_speed (50)
			a_counter.run
		end

	launch_one_run_100 (a_counter: separate COUNTER) is
		do
			io.put_string ("launch_one_run_100 (counter_1) started%N")
			a_counter.run_100
		end

	launch_two (a_counter_1: separate COUNTER; a_counter_2: separate COUNTER)
			-- start a_counter_1 and a_counter_2
		do
			a_counter_1.run
			a_counter_2.run
		end

	launch_one_with_precondition (a_counter: separate COUNTER) is
			-- Launch a_counter
		require
			a_counter.value >= 200
		do
			io.put_string ("launch_one_with_precondition (counter_1) started%N")
			a_counter.run_100
		end

	launch_one_with_precondition_2 (a_counter: separate COUNTER) is
			-- Launch a_counter
		require
			a_counter.value >= 300 and a_counter.value <= 500
		do
			io.put_string ("launch_one_with_precondition_2 (counter_1) started%N")
			a_counter.run_100
		end


feature -- Access

	counter_1:  separate COUNTER
			-- Counter reference

	counter_2:  separate COUNTER
			-- Counter reference			

end -- class APPLICATION	
