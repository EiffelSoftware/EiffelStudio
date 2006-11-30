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

			f
		end

	a: INTEGER is UNIQUE

end
