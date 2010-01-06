class TEST

create

	make

feature {NONE} -- Creation

	make is
			-- Execute test.
		do
			if minus_one = -1 then
				print ("Test 1: OK%N")
			else
				print ("Test 1: FAILED%N")
			end
			inspect -1
			when -0x1 then
				print ("Test 2: OK%N")
			else
				print ("Test 2: FAILED%N")
			end
		end

feature {NONE} -- Constants

	minus_one: INTEGER is -0x1
			-- Integer value -1

end