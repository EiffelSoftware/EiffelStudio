class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Execute test.
		do
		end
	
feature -- Onces

	first_once: $CLASS_NAME is
		once
			print ("First created%N")
		end
		

end
