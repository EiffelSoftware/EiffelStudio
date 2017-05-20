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
			t.join
			print
				(if t.terminated = 0 then
					"Thread done%N"
				else
					"Failed%N"
				end)
		end

end
