class TEST

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		local
			a: A
		do
			a := create {separate B}
		end

end
