--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            270 Storke Road, California 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class 
	MULTIPLY 

inherit 
	STATE 

create
	make

feature 
	
	operation is 
			-- Multiply register with top element of stack.
		do 
			register := register * operand_stack.item
		ensure then
			register = old register * operand_stack.item
		end

end -- class MULTIPLY 
