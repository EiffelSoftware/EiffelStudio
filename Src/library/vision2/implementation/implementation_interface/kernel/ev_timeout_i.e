indexing
	description:
		" EiffelVision timeout, implementation interface."
	status: "See notice at end of class"
	date: "$$"
	revision: "$$"

deferred class
	EV_TIMEOUT_I

inherit
	EV_ANY_I

feature {NONE} -- Initialization

	make (delay: INTEGER; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Create a timeout that call that launch `cmd' with `arg' every `delay'
			-- millisecondes.
		require
			valid_command: cmd /= Void
			positive_period: delay > 0
		deferred
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
		deferred
		ensure
			positive_result: Result > 0
		end

	command: EV_COMMAND is
			-- Command associated with the timeout.
		require
			exists: not destroyed
		deferred
		ensure
			result_not_void: Result /= Void
		end

	argument: EV_ARGUMENT is
			-- Argument associated with the timeout.
		require
			exists: not destroyed
		deferred
		end

	count: INTEGER is
			-- Number of times the command was already called.
		require
			exists: not destroyed
		deferred
		ensure
			positive_result: Result >= 0
		end

end -- class EV_TIMEOUT_I

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
