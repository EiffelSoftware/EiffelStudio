--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            360 Storke Road, Goleta, CA 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing
	description: "Minus operation"
	external_name: "ISE.Examples.Calculator.Minus"
	
class 
	MINUS 

inherit 
	STATE 

create
	make

feature 
	
	operation is 
		indexing
			description: "Subtract top element of stack with register."
			external_name: "Operation"
		do 
			register := operand_stack.item - register
		ensure then
			register = operand_stack.item - old register 
		end
	
end -- class MINUS 
