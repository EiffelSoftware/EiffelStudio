--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- A tasking manager.
-- This class should be used for executing long tasks whithout interfering
-- with events system (otherwise the events will be put in a stack and wait
-- until the task is finished, windows will not be redrawn for instance).
-- This can be used for background tasks too.

indexing

	date: "$Date$";
	revision: "$Revision$"

class TASK 

inherit

	G_ANY
		export
			{NONE} all
		end

creation

	make

feature 

	add_action (a_command: COMMAND; an_argument: ANY) is
			-- Add `a_command' with `argument' to the list of action to execute
			-- while the system is waiting for user events.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.add_action (a_command, an_argument)
		end;

	make is
			-- Create a task.
		do
			implementation := toolkit.task (Current)
		end;

feature {NONE}

	implementation: TASK_I;
			-- Implementation of task

feature 

	remove_action (a_command: COMMAND; an_argument: ANY) is
			-- Remove `a_command' with `argument' to the list of action to
			-- execute while the system is waiting for user events.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.remove_action (a_command, an_argument)
		end;

end
