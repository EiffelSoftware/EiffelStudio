class TEST

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		do
		end

feature -- Test

	f alias "()" (x: ANY)
		do
		end

	g alias "()" (x, y: ANY)
		do
		end

end
