indexing
	description: "Root class"
	external_name: "ISE.Examples.Calculator.Calculator"

class 
	CALCULATOR 

inherit
	SET_UP

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Creation routine"
			external_name: "Make"
		do 
			create io
			io.put_string ("%N*********************************%N")
			io.put_string ("Calculator in reverse Polish form%N")
			io.put_string ("*********************************%N")
			create associated_operator.make (10)
			initialize
			session
		end

feature {NONE}  -- Attributes 

	current_state: STATE
		indexing
			description: "The current state"
			external_name: "CurrentState"
		end

	quit_state: QUIT
		indexing
			description: "Quit state"
			external_name: "QuitState"
		end
		
	help_state: HELP
 		indexing
 			description: "Help state"
 			external_name: "HelpState"
 		end
 		
 	qst: QUESTION
 		indexing
 			description: " Question state"
 			external_name: "QST"
 		end
 		
feature {NONE} -- Implementation

	session is
		indexing
			description: "The main loop"
			external_name: "Session"
		do
			from
				start
			until
				over
			loop
				action
				next
			end
		end
	
	start is
		indexing
			description: "Start session."
			external_name: "Start"
		do
			help_state.do_one_state
			current_state := qst
		ensure
			current_state.is_equal (qst)
		end

	over: BOOLEAN is
		indexing
			description: "Is session over?"
			external_name: "Over"
		require
			non_void_current_state: current_state /= Void
		do
			Result := current_state /= Void and then current_state.is_equal (quit_state)
		end

	action is
		indexing
			description: "Do something."
			external_name: "Action"
		require
			non_void_current_state: current_state /= Void
		do
			current_state.do_one_state
		end

	next is
		indexing
			description: "Get next state."
			external_name: "Next"
		require
			non_void_current_state: current_state /= Void
		local
			current_interface: INTERFACE
		do
			current_state.read
			if associated_operator.has (current_state.next_choice) then
				current_interface ?= associated_operator.item (current_state.next_choice)
				current_state := current_interface.associated_command
			else
				current_state := help_state
			end
		end

	initialize is 
		indexing
			description: "Build operator states."
			external_name: "Initialize"
		do 
			create operator_stack.make
			create qst.make (operator_stack)
			enter_operator ("a", "Enter operand onto stack.", qst)
			enter_operator ("+", "Add top two numbers on the stack", create {PLUS}.make (operator_stack))
			enter_operator ("-", "Subtract top two numbers on the stack.", create {MINUS}.make (operator_stack))
			enter_operator ("*", "Multiply top two numbers on the stack.", create {MULTIPLY}.make (operator_stack))
			enter_operator ("/", "Divide top two numbers on the stack.", create {DIVIDE}.make (operator_stack))
			enter_operator ("0", "Empty the stack.", create {EMPTY}.make (operator_stack))
			create quit_state.make (operator_stack)
			enter_operator ("q", "Quit.", quit_state)
			create help_state.make (operator_stack)
			help_state.set_operator (associated_operator)
			enter_operator ("?", "Help.", help_state)
		end

	operator_stack: LINKED_STACK [REAL]
		indexing
			description: "Operator stack"
			external_name: "Operator"
		end

end -- class CALCULATOR 

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

