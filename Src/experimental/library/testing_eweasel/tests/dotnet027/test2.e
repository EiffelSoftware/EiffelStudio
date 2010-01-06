class 
	TEST
	
create
	make
	
feature
	
	make is
		do
				-- Feature `title' is read-write and should have a setter.
			{SYSTEM_CONSOLE}.title := {SYSTEM_CONSOLE}.title
		end

end