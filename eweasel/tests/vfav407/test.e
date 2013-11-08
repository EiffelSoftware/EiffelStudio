class TEST

inherit
	A
		rename
			f as f alias "()"
		end

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		do
		end

end
