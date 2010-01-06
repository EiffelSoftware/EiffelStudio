class 
	TEST
	
create
	make
	
feature
	
	make is
		do
				-- Feature `error' is read-only and should have no setter.
			{SYSTEM_CONSOLE}.error := {SYSTEM_CONSOLE}.error
		end

end