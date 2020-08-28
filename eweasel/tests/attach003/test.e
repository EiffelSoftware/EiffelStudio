class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		do
			print ("Test 1: ")
			if attached {attached like Current} Current as l_current then
				print ("OK%N")
			else
				print ("Failed%N")
			end
			print ("Test 2: ")
			if attached {attached like Current} Current as l_current2 then
				test (l_current2)
			else
				print ("Failed%N")
			end
		end
		
	test (a_current: attached TEST)
		do
			print ("OK%N")
		end

end