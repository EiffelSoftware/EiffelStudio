--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            360 Storke Road, Goleta, Ca 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing
	description: "Plus operation"
	external_name: "ISE.Examples.Calculator.Plus"
	
class 
	PLUS 

inherit 
	STATE 

create
	make

feature 
	
	operation is 
		indexing
			description: "Add register with top element of stack."
			external_name: "Operation"
		do 
			register := register + operand_stack.item
		ensure then
			register = old register + operand_stack.item
		end 
	
end -- class PLUS 
