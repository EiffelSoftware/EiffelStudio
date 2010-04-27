class
	TEST
 
create
	make
 
feature {NONE} -- Initialization
 
	make
			-- Run application.
		local
			x: attached TEST1
		do
			create x
			x.string.to_upper
		end
 
end
 


