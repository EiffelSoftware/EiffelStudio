class
	TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			b: BOOLEAN
		do
			b := 
				if Current = twin then
					Current
				else
					out
				end
			b := 
				if Current = twin then
					Current
				elseif Current ~ twin then
					out
				else
					Current
				end
		end

end
