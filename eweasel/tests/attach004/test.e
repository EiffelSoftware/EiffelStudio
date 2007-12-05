class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		do
			if {l_any: !ANY} l_any then
				print ("Failed%N")
			end
		end

end