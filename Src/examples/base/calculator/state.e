note
	legal: "See notice at end of class."
	status: "See notice at end of class."
deferred class 
	STATE
	
feature {NONE}
	
	register: REAL
			-- Temporary register used in classes

	operand_stack: LINKED_STACK [REAL]
			-- Stack of operands.
		once
			create Result.make
		end

feature 
	
	next_choice: STRING
			-- Last user's choice.
		do
			Result := io.laststring
		end
	
	do_one_state 
			-- Perform operation associated with the current state 
			-- and display result.
		do 
			process
			display
		end

feature {NONE}
	
	display 
			-- Display the content of the accumulator.
		do 
			io.new_line
			io.putstring ("Accumulator = ")
			io.putreal (operand_stack.item)
			io.new_line
		end; 

feature 	

	read 
			-- Read next operation. 
		do 
			io.new_line
			io.putstring ("Next operation? ")
			io.readword
			io.next_line
		end
 
feature {NONE}	

	process 
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
	
	operation
			-- Effective register operation.
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class STATE 

