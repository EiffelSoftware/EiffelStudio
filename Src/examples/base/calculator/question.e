--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class QUESTION 

inherit 
	STATE 
		redefine 
			process
		end

feature 
	
	operation is
			-- Useless.
		do
		end;

	process is 
			-- Get a number from user input.
		do 
			io.putstring ("Enter a number, followed by <return>: ");
			io.readreal;
			operand_stack.put (io.lastreal)
		end; 
	
end -- class QUESTION 
