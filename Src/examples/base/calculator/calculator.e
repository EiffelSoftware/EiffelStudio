class 
	CALCULATOR 

inherit
	SET_UP 

create
	make

feature -- creation

	make is 
		do 
			io.putstring ("%N*********************************%N")
			io.putstring ("Calculator in reverse Polish form%N")
			io.putstring ("*********************************%N")
			initialize
			session
		end

feature {NONE}  -- Attributes 

	current_state: STATE
		-- The current state.

	quit_state: QUIT
		
	help_state: HELP

	qst: QUESTION

	remove: EMPTY
		-- Reset operation.
	
	pls: PLUS
		-- Addition operation.

	mns: MINUS
		-- Subtraction operation.

	mlt: MULTIPLY
		-- Multiplication operation.

	dvd: DIVIDE
		-- Division operation.

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
			current_state.is_equal (qst)
		end

	over: BOOLEAN is
			-- Is session over?
		do
			Result := current_state /= Void and then current_state.is_equal (quit_state)
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
		do 
			create qst
			enter_operator ("a", "Enter operand onto stack.", qst)
			create pls
			enter_operator ("+", "Add top two numbers on the stack", pls)
			create mns
			enter_operator ("-", "Subtract top two numbers on the stack.", mns)
			create mlt
			enter_operator ("*", "Multiply top two numbers on the stack.", mlt)
			create dvd
			enter_operator ("/", "Divide top two numbers on the stack.", dvd)
			create remove
			enter_operator ("0", "Empty the stack.", remove)
			create quit_state
			enter_operator ("q", "Quit.", quit_state)
			create help_state
			enter_operator ("?", "Help.", help_state)
		end
	
end -- class CALCULATOR 

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

