indexing
	description: "Objects that ..."
		" EiffelVision timeout, implementation."
	status: "See notice at end of class"
	date: "$$"
	revision: "$$"

class
	EV_TIMEOUT_IMP

inherit
	EV_TIMEOUT_I

creation
	make

feature -- Initialization

	make (delay: INTEGER; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Create a timeout that call that launch `cmd' with `arg' every `delay'
			-- millisecondes.
		do
		end

feature -- Access

	period: INTEGER is
			-- Period of the timeout in milli-seconde.
		do
		end

	command: EV_COMMAND is
			-- Command associated with the timeout.
		do
		end

	argument: EV_ARGUMENT is
			-- Argument associated with the timeout.
		do
		end

	count: INTEGER is
			-- Number of times the command was already called.
		do
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?
		do
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
		end

end -- class EV_TIMEOUT_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
