--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|        Interactive Software Engineering Building            --
--|            270 Storke Road, California 93117                --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
-- Root class

class 
	CALCULATOR 

inherit
	SET_UP 

create
	make

feature -- creation

	make is
		local
			a: HASH_TABLE [INTERFACE, STRING]
			t: CONSOLE
		do 
			create t
			io := t
			io.putstring ("%N*********************************%N")
			io.putstring ("Calculator in reverse Polish form%N")
			io.putstring ("*********************************%N")
			create a.make (10)
			associated_operator := a
			initialize
			session
		end

feature {NONE}  -- Attributes 

	current_state: STATE
		-- The current state.

	quit_state: QUIT
		
	help_state: HELP
 
 	qst: QUESTION
 
-- 	remove: EMPTY
-- 		-- Reset operation.
-- 	
-- 	pls: PLUS
-- 		-- Addition operation.
-- 
-- 	mns: MINUS
-- 		-- Subtraction operation.
-- 
-- 	mlt: MULTIPLY
-- 		-- Multiplication operation.
-- 
-- 	dvd: DIVIDE
-- 		-- Division operation.
-- 
feature {NONE} -- Implementation

	session is
			-- The main loop.
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
			-- Start session
		do
			help_state.do_one_state
			current_state := qst
		ensure
			current_state.equals (qst)
		end

	over: BOOLEAN is
			-- Is session over?
		do
			Result := current_state /= Void and then current_state.equals (quit_state)
		end

	action is
			-- Do something.
		do
			current_state.do_one_state
		end

	next is
			-- Get next state.
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
			-- Build operator states. 
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

end -- class CALCULATOR 
