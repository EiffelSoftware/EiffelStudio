--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            270 Storke Road, California 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class 
	MINUS 

inherit 
	STATE 

feature 
	
	operation is 
			-- Subtract top element of stack with register.
		do 
			register := operand_stack.item - register
		ensure then
			register = operand_stack.item - old register 
		end;
	
end -- class MINUS 
