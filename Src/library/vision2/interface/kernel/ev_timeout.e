indexing
	description:
		" EiffelVision timeout should be used for real-time tasks (like in games).%
		% The times given are a millisecond and are of course real-time and not%
		% process-time (in multi-tasking environments)"
	status: "See notice at end of class"
	date: "$$"
	revision: "$$"

class
	EV_TIMEOUT

inherit
	EV_ANY
		redefine
			implementation
		end

create
	make

feature {NONE} -- Initialization

	make (delay: INTEGER; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Create a timeout that call that launch `cmd' with `arg' every `delay'
			-- millisecondes.
		require
			valid_command: cmd /= Void
			positive_period: delay > 0
		do
			create {EV_TIMEOUT_IMP} implementation.make (delay, cmd, arg)
		ensure
			command_set: command = cmd
			argument_set: argument = arg
			period_set: period = delay
		end

feature -- Access

	period: INTEGER is
			-- Period of the timeout in milli-seconde.
		require
			exists: not destroyed
		do
			Result := implementation.period
		ensure
			positive_result: Result > 0
		end

	command: EV_COMMAND is
			-- Command associated with the timeout.
		require
			exists: not destroyed
		do
			Result := implementation.command
		ensure
			result_not_void: Result /= Void
		end

	argument: EV_ARGUMENT is
			-- Argument associated with the timeout.
		require
			exists: not destroyed
		do
			Result := implementation.argument
		end

	count: INTEGER is
			-- Number of times the command has been executed including
			-- the current execution.
		require
			exists: not destroyed
		do
			Result := implementation.count
		ensure
			positive_result: Result >= 0
		end

feature -- Implementation

	implementation: EV_TIMEOUT_I
			-- Platform dependant access.

end -- class EV_TIMEOUT

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
