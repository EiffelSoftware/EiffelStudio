indexing

	description: 
		"Constants for execution modes."
	date: "$Date$"
	revision: "$Revision $"

class

	EXEC_MODES

feature -- Execution mode properties

	No_stop_points: INTEGER is 1;
			-- Execution with no stop points taken into account

	User_stop_points: INTEGER is 2;
			-- Execution with user-defined stop points taken into account
			-- default execution mode (big yellow arrow)

	step_into: INTEGER is 3;
			-- Execution with all breakable points set
			-- the flag 'step_into' is set, so that application
			-- know it must stop to the next breakable statement

	step_by_step: INTEGER is 4;
			-- Execution with all breakable points of current
			-- routine set and a breakpoint set just after the
			-- calling routine (like step-out)

	Out_of_routine: INTEGER is 5;
			-- Execution with all breakable points set except
			-- those of the current routine.

end -- class EXEC_MODES
