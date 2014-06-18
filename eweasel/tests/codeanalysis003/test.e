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
			-- TODO: this is a TODO
			if True then
				if True then
					if True then
						if True then
							call_back
						end
					end
				end
			end
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
