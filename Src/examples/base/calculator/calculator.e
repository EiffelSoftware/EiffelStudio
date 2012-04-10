note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	CALCULATOR

inherit
	SET_UP

create
	make

feature -- creation

	make
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

	session
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

	start
			-- Start session
		do
			help_state.do_one_state
			current_state := qst
		ensure
			current_state.is_equal (qst)
		end

	over: BOOLEAN
			-- Is session over?
		do
			Result := current_state /= Void and then
				current_state.same_type (quit_state) and then
				current_state.is_equal (quit_state)
		end

	action
			-- Do something.
		do
			current_state.do_one_state
		end

	next
			-- Get next state.
		do
			current_state.read
			if attached associated_operator.item (current_state.next_choice) as l_current_interface then
				current_state := l_current_interface.associated_command
			else
				current_state := help_state
			end
		end

	initialize
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

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class CALCULATOR
