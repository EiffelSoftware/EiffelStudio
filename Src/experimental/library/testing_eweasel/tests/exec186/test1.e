class TEST1

create
	make

feature {NONE} -- Creation

	make is
			-- Execute test.
		do
		end
	
feature -- Onces

	first_once: TEST1 is
		once
			print ("First created%N")
			create Result.make
		end
		
	second_once: TEST1 is
		once
			print ("Second created%N")
			Result := third_once.first_once
		end
		
	third_once: TEST1 is
		once
			print ("Third created%N")
			create Result.make
		end

end
