--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            360 Storke Road, Goleta, CA 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing
	description: "Root class"
	external_name: "ISE.Examples.Calculator.Calculator"
	attribute: create {SYSTEM_OBSOLETEATTRIBUTE}.make_obsoleteattribute end

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
		local
			a: HASH_TABLE [INTERFACE, STRING]
			t: CONSOLE
		do 
			create t
			io := t
			io.put_string ("%N*********************************%N")
			io.put_string ("Calculator in reverse Polish form%N")
			io.put_string ("*********************************%N")
			create a.make (10)
			associated_operator := a
			initialize
			session
		end

feature {NONE}  -- Attributes 

	f: BOOLEAN is 
		indexing
			description: "Operand"
			external_name: "F"
		do 
		end
		
	g: BOOLEAN is 
		indexing
			description: "Operand"
			external_name: "G"
		do 
		end

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
 		
-- 	remove: EMPTY
--		indexing
--			description: "Reset operation"
--			external_name: "Remove"
--		end
-- 	
-- 	pls: PLUS
-- 		indexing
--			description: "Addition operation"
--			external_name: "PLS"
--		end
-- 
-- 	mns: MINUS
-- 		indexing
--			description: "Subtraction operation"
--			external_name: "MNS"
--		end
-- 
-- 	mlt: MULTIPLY
-- 		indexing
--			description: "Multiplication operation"
--		end
-- 
-- 	dvd: DIVIDE
-- 		indexing
--			description: "Division operation"
--			external_name: "DVD"
--		end
 
feature {NONE} -- Implementation

	session is
		indexing
			description: "The main loop"
			external_name: "Session"
			attribute: create {SYSTEM_OBSOLETEATTRIBUTE}.make_obsoleteattribute_2 ("TOTO", False) end
		do
			from
				start
--				print ("ti")
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
			current_state.equals (qst)
		end

	over: BOOLEAN is
		indexing
			description: "Is session over?"
			external_name: "Over"
		require
			non_void_current_state: current_state /= Void
		do
			Result := current_state /= Void and then current_state.equals (quit_state)
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
		local
			q: QUESTION
			quit: QUIT
			help: HELP
			j: LINKED_STACK [REAL]
		do 
			create j.make
			operator_stack := j
			create q.make (operator_stack)
			qst := q
			enter_operator ("a", "Enter operand onto stack.", qst)
			enter_operator ("+", "Add top two numbers on the stack", create {PLUS}.make (operator_stack))
			enter_operator ("-", "Subtract top two numbers on the stack.", create {MINUS}.make (operator_stack))
			enter_operator ("*", "Multiply top two numbers on the stack.", create {MULTIPLY}.make (operator_stack))
			enter_operator ("/", "Divide top two numbers on the stack.", create {DIVIDE}.make (operator_stack))
			enter_operator ("0", "Empty the stack.", create {EMPTY}.make (operator_stack))
			create quit.make (operator_stack)
			quit_state := quit
			enter_operator ("q", "Quit.", quit_state)
			create help.make (operator_stack)
			help_state := help
			help_state.set_operator (associated_operator)
			enter_operator ("?", "Help.", help_state)
		end

	operator_stack: LINKED_STACK [REAL]
		indexing
			description: "Operator stack"
			external_name: "Operator"
		end

end -- class CALCULATOR 