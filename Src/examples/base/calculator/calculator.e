--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
-- Root class

class CALCULATOR 
inherit
	SET_UP 

creation
	make

feature 

	make is 
		do 
			io.putstring ("%N*********************************%N");
			io.putstring ("Calculator in reverse Polish form%N");
			io.putstring ("*********************************%N");
			initialize;
			session
		end;

feature {NONE}  -- Implementation 

	current_state: STATE;

	qst: QUESTION;
	pls: PLUS;
	quit_state: QUIT;
	mns: MINUS;
	mlt: MULTIPLY;
	dvd: DIVIDE;
	help_state: HELP;
	remove: EMPTY;
	
	session is
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
			help_state.do_one_state;
			current_state := qst;
		ensure
			current_state.is_equal (qst)
		end; 

	over: BOOLEAN is
			-- Is session over?
		do
			Result := current_state /= Void and then current_state.is_equal (quit_state)
		end;

	action is
			-- Do something.
		do
			current_state.do_one_state
		end;

	next is
			-- Get next state.
		local
			current_interface: INTERFACE;
		do
			current_state.read;
			if associated_operator.has (current_state.next_choice) then
				current_interface ?= associated_operator.item (current_state.next_choice);
				current_state := current_interface.associated_command
			else
				current_state := help_state
			end
		end;

	initialize is 
			-- Build operator states. 
		do 
			!!qst; 
			enter_operator ("a", "Enter operand onto stack.", qst);
			!!pls;
			enter_operator ("+", "Add top two numbers on the stack", pls);
			!!mns;
			enter_operator ("-", "Subtract top two numbers on the stack.", mns);
			!!mlt;
			enter_operator ("*", "Multiply top two numbers on the stack.", mlt);
			!!dvd;
			enter_operator ("/", "Divide top two numbers on the stack.", dvd);
			!!remove;
			enter_operator ("0", "Empty the stack.", remove);
			!!quit_state;
			enter_operator ("q", "Quit.", quit_state);
			!!help_state;
			enter_operator ("?", "Help.", help_state);
		end;
	
end -- class CALCULATOR 
