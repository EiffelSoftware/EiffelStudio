indexing
	description:
		" EiffelVision timeout, mswindows implementation."
	status: "See notice at end of class"
	date: "$$"
	revision: "$$"

class
	EV_TIMEOUT_IMP

inherit
	EV_TIMEOUT_I

creation
	make

feature {NONE} -- Initialization

	make (delay: INTEGER; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Create a timeout that call that launch `cmd' with `arg' every `delay'
			-- millisecondes.
		do
			command := cmd
			argument := arg
			period := delay
			internal_timeout.add_timeout (Current)
		end

feature -- Access

	period: INTEGER
			-- Period of the timeout in milli-seconde.

	command: EV_COMMAND
			-- Command associated with the timeout.

	argument: EV_ARGUMENT
			-- Argument associated with the timeout.

	count: INTEGER
			-- Number of times the command has been executed including
			-- the current execution.

	id: INTEGER
			-- Id needed to destroy the current timeout.

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?
		do
			Result := not internal_timeout.timeouts.has (id)
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			internal_timeout.remove_timeout (id)
			command := Void
			argument := Void
		end

feature -- Element change

	set_id (value: INTEGER) is
			-- Make `value' the new id of the timeout.
		do
			id := value
		end

feature -- Basic operation

	execute is
			-- Execute the command associated with the timer.
			-- Ajouter un event data with delay et count.
		do
			count := count + 1
			command.execute (argument, Void)
		end

feature {NONE} -- Implementation

	internal_timeout: EV_INTERNAL_TIMEOUT_IMP is
			-- Window that launch the timeout commands.
		once
			create result.make_top ("EiffelVision timeout window")
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
