indexing

	description: "This class represents a MS_WINDOWS task";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	TASK_IMP
 
inherit

	G_ANY_IMP

	TASK_I

	EVENT_HDL

	TASK_MANAGER_WINDOWS

	WEL_APPLICATION_MAIN_WINDOW

creation

	make

feature -- Initialization

	make  is
			-- Create a task.
		do
			!!actions.make
			actions.compare_objects
			application.enable_idle_action
		end 

feature -- Status report

	empty: BOOLEAN is
			-- Is the list of actions empty?
		do
			Result := actions.is_empty
		end

feature -- Element change

	add_action (a_command: COMMAND; an_argument: ANY) is
			-- Add `a_command' with `argument' to the list of action to execute 
			-- while the system is waiting for user events.
		local
			action: ACTION_WINDOWS
		do
			if actions.is_empty then
				application.enable_idle_action
			end
			check
				a_command_not_void: a_command /= Void
			end
			!! action.make (a_command, an_argument)
			actions.extend (action)
		end

	remove_action (a_command: COMMAND; an_argument: ANY) is
			-- Remove `a_command' with `argument' to the list of action to
			-- execute while the system is waiting for user events.
		local
			action: ACTION_WINDOWS
		do
			check
				a_command_not_void: a_command /= Void
			end
			!! action.make (a_command, an_argument)
			actions.prune_all (action)
			if actions.is_empty then
				application.disable_idle_action
			end
		end

feature -- Basic operations

	execute is
			-- Execute the command.
		local
			c: CURSOR
		do
			if not actions.is_empty then
				from
					c := actions.cursor
					actions.start
				variant
					actions.count + 1 - actions.index
				until
					actions.after
				loop
					actions.item.execute
					check
						actions_not_after: not actions.after
					end
					actions.forth
				end
				actions.go_to (c)
			end
		end

	destroy is
		do
			remove_task (Current)
		end

feature {NONE} -- Implementation

	actions: LINKED_LIST [ACTION_WINDOWS]

--samik	application: WEL_APPLICATION
		-- Application this task is associated to.

end -- TASK_IMP
 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

