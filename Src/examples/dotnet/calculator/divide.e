--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            360 Storke Road, Goleta, CA 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing
	description: "Division operation"
	external_name: "ISE.Examples.Calculator.Divide"
	
class 
	DIVIDE

inherit 
	STATE 

create
	make

feature 
	
	operation is 
		indexing
			description: "Divide top element of stack with register."
			external_name: "Operation"
		do 
			register := operand_stack.item / register
		end
	
end -- class DIVIDE 
