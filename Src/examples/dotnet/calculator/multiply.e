--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            360 Storke Road, Goleta, CA 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing
	description: "Multiply operation"
	external_name: "ISE.Examples.Calculator.Multiply"
	
class 
	MULTIPLY 

inherit 
	STATE 

create
	make

feature 
	
	operation is 
		indexing
			description: "Multiply register with top element of stack."
			external_name: "Operation"
		do 
			register := register * operand_stack.item
		ensure then
			register = old register * operand_stack.item
		end

end -- class MULTIPLY 
