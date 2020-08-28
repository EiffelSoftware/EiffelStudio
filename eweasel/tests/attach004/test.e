class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		do
			if attached {attached ANY} l_any as l_any then
				print ("Failed%N")
			end
		end

end