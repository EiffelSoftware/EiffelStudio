--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class PLUS 

inherit 
	STATE 

feature 
	
	operation is 
			-- Add register with top element of stack.
		do 
			register := register + operand_stack.item
		ensure then
			register = old register + operand_stack.item
		end; 
	
end -- class PLUS 
