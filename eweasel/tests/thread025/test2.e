class TEST

create

	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			t: A
		do
			print ("Thread start%N")
			create t.make
			t.launch
				-- Wait 5 seconds to let other thread run.
			;(create {EXECUTION_ENVIRONMENT}).sleep (5_000_000_000)
			t.join
			print ("Thread done%N")
		end

end
