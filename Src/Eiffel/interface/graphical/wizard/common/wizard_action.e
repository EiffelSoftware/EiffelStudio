indexing

	description:
		"Abstract notion of an action used by a wizard."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class WIZARD_ACTION

inherit
	COMMAND;
	EXCEPTIONS

feature -- Initialization

	init (a_wizard: WIZARD; a_dialog: WIZARD_DIALOG) is
			-- Initialize Current. Set `wizard' to `a_wizard'.
		require
			non_void_wizard: a_wizard /= Void;
			non_void_dialog: a_dialog /= Void
		do
			wizard := a_wizard;
			dialog := a_dialog;
			has_next := True;
			finished := False
		ensure
			wizard_set: equal (wizard, a_wizard);
			dialog_set: equal (dialog, a_dialog)
		end;

feature -- Properties; Actions

	next_action: WIZARD_ACTION is
			-- Next step to do in the completion of the wizard.
			-- Default: Current.
		require
			has_next_action: has_next_action
		do
			if next = Void then
				Result := Current
			else
				Result := next_act
			end;
		end;

	previous_action: WIZARD_ACTION is
			-- Previous step to do in the completion of the wizard.
			-- Default: Current.
		require
			has_previous_action: has_previous_action
		do
			if previous = Void then
				Result := Current
			else
				Result := previous_act
			end;
		end;

	has_previous_action: BOOLEAN is
			-- Is there something beyond Current?
			-- Default: No.
		do
			Result := has_previous;
		end;

	has_next_action: BOOLEAN is
			-- Is there something beyond Current?
			-- Default: No.
		do
			Result := has_next;
		end;

	is_finished: BOOLEAN is
			-- Is Current finished or aborted?
		require
			not_has_next_action: not has_next_action
		do
			Result := finished
		end;

	processed: BOOLEAN
			-- Is the information processed?
			-- True means yes; False means Error and thus retry.

feature -- Graphical User Interface

	build_interface is
			-- Build the GUI.
		deferred
		end;

feature -- Information Handling

	process_information is
		deferred
		end;

feature --- Execute Arguments

	previous: ANY is
		once
			create Result
		end;

	abort: ANY is
		once
			create Result
		end;

	next: ANY is
		once
			create Result
		end;

feature -- Execution

	execute (argument: ANY) is
			-- Execute Current.
		do
			if argument = previous then
				set_previous_action;
			elseif argument = abort then
				abort_action;
			elseif argument = next then
				set_next_action;
			else
				work (argument);
			end;
		end;

	work (argument: ANY) is
		deferred
		end;

	set_previous_action is
			-- Go back to the previous action.
			-- (Ie: make `next_action' the previous)
		deferred
		end;

	set_next_action is
			-- Go on with the next step.
		deferred
		end;

	abort_action is
		do
			has_next := False;
			finished := False;
			wizard.next_action
		end;

feature -- Button Manipulation

	set_next_sensitive is
			-- Set `next_button' sensitive.
		do
			dialog.set_next_sensitive
		end;

	set_next_insensitive is
			-- Set `next_button' insensitive.
		do
			dialog.set_next_insensitive
		end;

	set_abort_sensitive is
			-- Set `abort_button' sensitive.
		do
			dialog.set_abort_sensitive
		end;

	set_abort_insensitive is
			-- Set `abort_button' insensitive.
		do
			dialog.set_abort_insensitive
		end;

	set_previous_sensitive is
			-- Set `previous_button' sensitive.
		do
			dialog.set_previous_sensitive
		end;

	set_previous_insensitive is
			-- Set `previous_button' insensitive.
		do
			dialog.set_previous_insensitive
		end;

feature {NONE} -- Properties

	finished: BOOLEAN;
			-- Is Current finished or aborted?

	has_next: BOOLEAN;
			-- Are there more action beyond Current?
			-- Default: No.

	has_previous: BOOLEAN;
			-- Are there more action before Current?
			-- Default: No.

	previous_act: WIZARD_ACTION;
			-- Next action to be executed by the wizard.

	next_act: WIZARD_ACTION;
			-- Next action to be executed by the wizard.

	wizard: WIZARD;
			-- The wizrad Current is an action of.

	dialog: WIZARD_DIALOG;
			-- The dialog through which Current is displayed.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class WIZARD_ACTION
