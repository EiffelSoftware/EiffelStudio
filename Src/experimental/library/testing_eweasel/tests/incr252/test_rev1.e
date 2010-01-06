class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		do
			print ("a:")
			if a /= 0 then
				print ("OK%N")
			else
				print ("FAILED%N")
			end
			print ("b:")
			if b /= 0 then
				print ("OK%N")
			else
				print ("FAILED%N")
			end
		end

	a, b: INTEGER is UNIQUE

end
