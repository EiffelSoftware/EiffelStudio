class HEIR inherit

	PARENT
		redefine
			display
		end

feature

	display is
			-- Output message saying where we are.
		do
			io.putstring ("In class HEIR")
			io.new_line
			io.putstring ("-------------------")
			io.new_line
			display_routine
			io.putstring (a_string)
			io.new_line
			io.new_line
		end

	display_routine is 
			-- Output simple message.
		do 
			io.putstring ("Calling a routine of class HEIR")
			io.new_line 
		end

	a_string: STRING is 
			-- Simple text string
		do 
			create Result.make (0)
			Result.append ("Showing an attribute of class HEIR")
		end

end
