--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class DIVIDE

inherit 
	STATE 

feature 
	
	operation is 
			-- Divide top element of stack with register.
		do 
			register := operand_stack.item / register;
		end; 
	
end -- class DIVIDE 
