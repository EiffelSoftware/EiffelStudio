indexing

	description:
		"General notion of EiffelBuild command (semantic unity)";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class BUILD_CMD

inherit

	SHARED_CONTROL

feature

	work is
			-- Execute action of Current
			-- command and perform transition
			-- in application state graph.
		do
			transition_label := Void;
			execute;
			if (transition_label /= Void) then
				control.transit (transition_label)
			end
			execute_observers
		end;

	context_data: CONTEXT_DATA;
			-- Information related to Current command,
			-- provided by the underlying user interface
			-- mechanism

	context_data_useful: BOOLEAN is
   			-- Should the context data be available
   			-- when Current command is invoked as a
  			-- callback
		do
		end;

	execute is
			-- Actual action executed by
			-- Current command.
		deferred
		end;

	transition_label: STRING;
			-- Transition Exit label of Current command

	set_transition_label (s: STRING) is
			-- Set transition exit label to `s'
		do
			transition_label := s;
			
		end;

	add_observer (new_command: BUILD_CMD) is
			-- Add `new_command' to the list of commands to be
			-- executed if `Current' is executed.
		require
			valid_command: new_command /= Void
		do
			if observer_list = Void then
				!! observer_list.make 
			end
			observer_list.extend (new_command)
		end

	remove_observer (old_command: BUILD_CMD; i: INTEGER) is
			-- Remove `old_command' from the list of commands to be 
			-- executed when `Current' is executed.
		require
			valid_command: old_command /= Void
		do
			observer_list.go_i_th (i)
			observer_list.prune (old_command)
		end

	observer_count: INTEGER is
			-- Number of observers
		do
			Result := observer_list.count
		end

feature {NONE}

	execute_observers is
			-- Execute all commands in `observer_list'.
		do
			if observer_list /= Void then
				from
					observer_list.start
				until
					observer_list.after
				loop
					observer_list.item.work
					observer_list.forth
				end
			end
		end

	observer_list: LINKED_LIST [BUILD_CMD] 
			-- List of commands to be executed when `Current' is.

feature {META_COMMAND}

	set_context_data (a_context_data: CONTEXT_DATA) is
			-- Set `context_data' to `a_context_data'.
		do
			context_data := a_context_data
		ensure
			context_data = a_context_data
		end

end -- class BUILD_CMD

--|----------------------------------------------------------------
--| EiffelBuild library.
--| Copyright (C) 1995 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
