note
	description : "project2 application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	TEST

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		do
			call_back
		end
		
	call_back
			-- Calls `make' back, so that we don't get a "Feature never called" warning.
		do
			if not already_called_back then
				already_called_back := True
				make
			end
		end
		
	already_called_back: BOOLEAN
			-- Was `call_back' already invoked?
	
end
