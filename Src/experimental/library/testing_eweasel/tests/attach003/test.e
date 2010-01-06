class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		do
			print ("Test 1: ")
			if {l_current: !like Current} Current then
				print ("OK%N")
			else
				print ("Failed%N")
			end
			print ("Test 2: ")
			if {l_current2: !like Current} Current then
				test (l_current2)
			else
				print ("Failed%N")
			end
		end
		
	test (a_current: !TEST)
		do
			print ("OK%N")
		end

end