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

--|----------------------------------------------------------------
--| .NET: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

