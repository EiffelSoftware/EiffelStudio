class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		do
			if has_flags (1024, 1024) then
				print ("OK%N")
			else
				print ("Not OK%N")
			end
		end

	has_flags (i, v: INTEGER): BOOLEAN is
		external
			"C inline"
		alias
			"$i & $v"
		end

end
