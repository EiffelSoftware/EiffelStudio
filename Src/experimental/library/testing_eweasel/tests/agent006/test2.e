class TEST2
 
inherit
	TEST1
		redefine
			h
		end
 
feature
 
	h: TEST2
		do
			create Result
		end
 
end
