--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            270 Storke Road, California 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

deferred class 
	STATE
	
feature {NONE}
	
	register: REAL
			-- Temporary register used in classes

	operand_stack: LINKED_STACK [REAL] is
			-- Stack of operands.
		once
			create Result.make
		end

feature 
	
	next_choice: STRING is
			-- Last user's choice.
		do
			Result := io.laststring
		end
	
	do_one_state is 
			-- Perform operation associated with the current state 
			-- and display result.
		do 
			process
			display
		end

feature {NONE}
	
	display is 
			-- Display the content of the accumulator.
		do 
			io.new_line
			io.putstring ("Accumulator = ")
			io.putreal (operand_stack.item)
			io.new_line
		end; 

feature 	

	read is 
			-- Read next operation. 
		do 
			io.new_line
			io.putstring ("Next operation? ")
			io.readword
			io.next_line
		end
 
feature {NONE}	

	process is 
			-- Process user's answer.
		do 
			if operand_stack.count > 1 then
				register := operand_stack.item
				operand_stack.remove
				operation
				operand_stack.remove
				operand_stack.put (register)
			else
				io.putstring ("Only one element on the stack%N")
			end
		end

feature 
	
	operation is
			-- Effective register operation.
		deferred
		end

end -- class STATE 
