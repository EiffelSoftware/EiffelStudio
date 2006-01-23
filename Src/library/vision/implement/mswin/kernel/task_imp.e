indexing

	description: "This class represents a MS_WINDOWS task"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

create

	make

feature -- Initialization

	make  is
			-- Create a task.
		do
			create actions.make
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
			create action.make (a_command, an_argument)
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
			create action.make (a_command, an_argument)
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

	actions: LINKED_LIST [ACTION_WINDOWS];

--samik	application: WEL_APPLICATION
		-- Application this task is associated to.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- TASK_IMP

