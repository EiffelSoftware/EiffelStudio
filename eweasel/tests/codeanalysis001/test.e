class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize object.
		do
				-- TODO: Observe an analysis message for this TODO item.
			call_back
		end
		
	call_back
			-- Call `make' back, so that we don't get a "Feature never called" warning.
		do
			if not already_called_back then
				already_called_back := True
				make
			end
		end
		
	already_called_back: BOOLEAN
			-- Was `call_back' already invoked?
	
end
