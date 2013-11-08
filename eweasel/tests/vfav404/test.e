class TEST

inherit
	A

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

end
