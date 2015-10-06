class TEST

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		local
			s: STRING_8
		do
			s := create {separate STRING_32}.make_empty
		end

end
