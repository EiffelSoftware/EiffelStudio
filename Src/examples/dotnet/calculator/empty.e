--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            360 Storke Road, Goleta CA 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing
	description: "Empty operand stack"
	external_name: "ISE.Examples.Calculator.Empty"
	
class 
	EMPTY

inherit 
	STATE 

create
	make

feature 

	operation is 
		indexing
			description: "Empty the stack and set accumulator and register to 0."
			external_name: "Operation"
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
			register_equals_zero: register = 0.0;
			one_item_in_operand_stack: operand_stack.count = 1
			operand_stack_item_equals_zero: operand_stack.item = 0.0
		end
	
end -- class EMPTY 
