class 
	TEST
	
create
	make
	
feature
	
	make is
		local
			l_decoder: DECODER
		do
				-- Feature `fallback_buffer' is read-only and should have no setter.
			l_decoder.fallback_buffer := l_decoder.fallback_buffer
		end

end