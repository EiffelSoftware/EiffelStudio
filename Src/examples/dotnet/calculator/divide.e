--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            270 Storke Road, California 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class 
	DIVIDE

inherit 
	STATE 

create
	make

feature 
	
	operation is 
			-- Divide top element of stack with register.
		do 
			register := operand_stack.item / register
		end
	
end -- class DIVIDE 
