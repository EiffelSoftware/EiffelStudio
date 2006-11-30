class 
	TEST
	
create
	make
	
feature
	
	make is
		local
			l_decoder: DECODER
		do
				-- Feature `fallback' is read-write and should have a setter.
			l_decoder.fallback := l_decoder.fallback
		end

end