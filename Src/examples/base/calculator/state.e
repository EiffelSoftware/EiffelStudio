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

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://www.eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

