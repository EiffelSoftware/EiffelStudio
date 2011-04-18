note
	description	: "System's root class"
	author		: "Volkan Arslan, Yann Mueller, Piotr Nienaltowski."
	date		: "$Date: 18.05.2007$"
	revision	: "1.0.0"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
		-- Test counters.
	do
			print ("Counter application%N")
				-- Leave one of the following lines uncommented to perform testing.

			test_1 -- start just one counter
--			test_2 -- start two counters
--			test_3 -- start many counters
--			test_4 -- start counter_1 twice
--			test_5 -- start counter_1 with precondition
--			test_6 -- start counter_1 separately and counter_2 non-separately
	end

feature -- Basic operations

	test_1
			-- Launch counter_1 only.
		do
			create counter_1.make (1, 50_000_000)
			launch_one (counter_1)
		end

	test_2
			-- Launch two counters at different speeds.
		do
			create counter_1.make (1, 1000_000_000)
			create counter_2.make (2, 500_000_000)
			print ("Start of counter 1 and counter 2%N")
			launch_two (counter_1, counter_2)
			print ("Counter 1 and counter 2 started ...%N")
		end

	test_3
			-- Launch many counters.
		local
			i: INTEGER
			counter: separate COUNTER
		do
			across (1 |..| 200) as ic
			loop
				create counter.make (ic.item, 200_000_000)
				launch_one (counter)
			end
		end

	test_4
			-- Launch `counter_1' twice.
		do
			create counter_1.make (1, 50_000_000)
			launch_one (counter_1)
			launch_one (counter_1)
		end

	test_5
			-- Launch counter_1 with preconditions.
		do
			create counter_1.make (1, 50_000_000)
			launch_one (counter_1)
			launch_one (counter_1)
			launch_one_with_precondition (counter_1)
			create counter_2.make (2, 50_000_000)
			launch_one (counter_2)
			launch_one_with_precondition_2 (counter_1)
		end

	test_6
			-- Launch two counters with mixed separateness.
		local
			a_counter_1: separate COUNTER
			a_counter_2: COUNTER
		do
			create a_counter_1.make (1, 50_000_000)
			create a_counter_2.make (2, 200_000_000)
			launch_two_mixed (a_counter_1, a_counter_2)
		end

	launch_two_mixed (a_counter_1: separate COUNTER; a_counter_2: COUNTER)
			-- Launch `a_counter_1' separately and `a_counter_2' non-separately.
		do
			a_counter_1.run (200)
			a_counter_2.run (200)
		end

	launch_one (a_counter: separate COUNTER)
			-- Launch `a_counter'.
		do
			a_counter.run (100)
		end

	launch_two (a_counter_1: separate COUNTER; a_counter_2: separate COUNTER)
			-- Launch `a_counter_1' and `a_counter_2'.
		do
			a_counter_1.run (50)
			a_counter_2.run (50)
		end

	launch_one_with_precondition (a_counter: separate COUNTER)
			-- Launch `a_counter' with precondition.
		require
			a_counter.value >= 200
		do
			print ("launch_one_with_precondition (counter_1) started%N")
			a_counter.run (100)
		end

	launch_one_with_precondition_2 (a_counter: separate COUNTER)
			-- Launch `a_counter' with precondition.
		require
			a_counter.value >= 300 and a_counter.value <= 500
		do
			print ("launch_one_with_precondition_2 (counter_1) started%N")
			a_counter.run (100)
		end


feature -- Access

	counter_1:  detachable separate COUNTER note option: stable attribute end
			-- Test counter 1

	counter_2:  detachable separate COUNTER note option: stable attribute end
			-- Test counter 2			

end -- class APPLICATION	
