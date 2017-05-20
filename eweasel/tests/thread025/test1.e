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
				-- Wait 10 seconds.
			if t.join_with_timeout (10_000) then
				print ("Thread done%N")
			else
				print ("Failed%N")
			end
		end

end
