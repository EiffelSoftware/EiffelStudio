--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            270 Storke Road, California 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class 
	QUESTION 

inherit 
	STATE 
		redefine 
			process
		end

create
	make

feature 
	
	operation is
			-- Useless.
		do
		end

	process is 
			-- Get a number from user input.
		do 
			io.putstring ("Enter a number, followed by <return>: ")
			io.read_real
			operand_stack.put (io.lastreal)
		end
	
end -- class QUESTION 
