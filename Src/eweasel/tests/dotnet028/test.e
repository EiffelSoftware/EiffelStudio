class 
	TEST
	
create
	make
	
feature
	
	make is
		local
			l_no: NATIVE_OVERLAPPED
		do
				-- Feature `offset_high' is read-write and should have a setter.
			l_no.offset_high := l_no.offset_high
		end

end