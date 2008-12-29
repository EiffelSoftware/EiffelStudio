class TEST

creation 
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		do
			inspect 3
			when 2..1 then
				something := whatever
			end
		end

end
