--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.  --
--|        Interactive Software Engineering Building            --
--|            360 Storke Road, Goleta, CA 93117                --
--|                   (805) 685-1006                            	--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing
	description: "Calcultator state"
	external_name: "ISE.Examples.Calculator.State"

deferred class 
	STATE

inherit
	IO

feature {NONE} -- Initialization

	make (op: LINKED_STACK [REAL]) is
		indexing
			description: "Set `operand_stack' with `op' and initialize `io'."
			external_name: "Make"
		require
			non_void_operation: op /= Void
		local
			console: CONSOLE
		do
			operand_stack := op
			create console
			io := console
		ensure
			non_void_operand_stack: operand_stack /= Void
			non_void_console: io /= Void
		end
	
feature -- Access

	io: CONSOLE
		indexing
			description: "Console"
			external_name: "Io"
		end

	operation is
		indexing
			description: "Effective register operation"
			external_name: "Operation"
		deferred
		end
		
	next_choice: STRING is
		indexing
			description: "Last user's choice"
			external_name: "NextChoice"
		do
			Result := io.last_string
		end

feature -- Basic Operations

	do_one_state is 
		indexing
			description: "Perform operation associated with the current state and display result."
			external_name: "DoOneState"
		do 
			process
			display
		end

	read is 
		indexing
			description: "Read next operation."
			external_name: "Read"
		do 
			io.new_line
			io.put_string ("Next operation? ")
			io.read_line
		end
 
feature {NONE} -- Implementation
	
	register: REAL
		indexing
			description: "Temporary register used in classes"
			external_name: "Register"
		end

	operand_stack: LINKED_STACK [REAL]
		indexing
			description: "Stack of operands"
			external_name: "OperandStack"
		end

	display is 
		indexing
			description: "Display the content of the accumulator."
			external_name: "Display"
		do 
			io.new_line
			io.put_string ("Accumulator = ")
			io.put_real (operand_stack.item)
			io.new_line
		end

	process is 
		indexing
			description: "Process user's answer."
			external_name: "Process"
		require
			non_void_operand_stack: operand_stack /= Void
		do 
			if operand_stack.count > 1 then
				register := operand_stack.item
				operand_stack.remove
				operation
				operand_stack.remove
				operand_stack.put (register)
			else
				io.put_string ("Only one element on the stack%N")
			end
		end

invariant
	non_void_operand_stack: operand_stack /= Void
	non_void_console: io /= Void

end -- class STATE 
