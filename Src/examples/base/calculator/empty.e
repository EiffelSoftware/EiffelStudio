--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            270 Storke Road, California 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class 
	EMPTY

inherit 
	STATE
		redefine
			process
		end

feature 

	operation is 
			-- Empty the stack and set accumulator and register to 0.
		do 
			from
				register := 0.0
			until
				operand_stack.count = 1
			loop
				operand_stack.remove
			end
			operand_stack.replace (0.0)
		ensure then
			register = 0.0;
			operand_stack.count = 1
			operand_stack.item = 0.0
		end
	
	process is
			-- Process user's answer.
		do
			operation
		end

end -- class EMPTY 
