--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            360 Storke Road, Goleta, CA 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing
	description: "Question"
	external_name: "ISE.Examples.Calculator.Question"
	
class 
	QUESTION 

inherit 
	STATE 
		redefine 
			process
		end

create
	make

feature -- Basic Operations
	
	operation is
		indexing
			description: "Useless"
			external_name: "Operation"
		do
		end

	process is 
		indexing
			description: "Get a number from user input."
			external_name: "Process"
		do 
			io.put_string ("Enter a number, followed by <return>: ")
			io.read_real
			operand_stack.put (io.last_real)
		end
	
end -- class QUESTION 
