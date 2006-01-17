indexing

	description:
		"Abstarct notion of a wizard used to help the user with difficult %
		%steps during development."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class WIZARD

create
	make

feature -- Initialization

	make (a_parent: COMPOSITE; a_dialog: WIZARD_DIALOG; an_action: WIZARD_ACTION) is
			-- Initialize Current. Set `associated_dialog' to `a_dialog',
			-- `current_action' to `an_action'.
			-- FIXME: New wizard dialog should be probably made for every WIZARD_ACTION, 
			-- or at least reset!!!
		require
			non_void_parent: a_parent /= Void;
			non_void_dialog: a_dialog /= Void;
			non_void_action: an_action /= Void
		do
			parent := a_parent;
			associated_dialog := a_dialog;
			current_action := an_action;
			an_action.init (Current, a_dialog);
			a_dialog.previous_button.add_activate_action (an_action, an_action.previous);
			a_dialog.abort_button.add_activate_action (an_action, an_action.abort);
			a_dialog.next_button.add_activate_action (an_action, an_action.next)
		ensure
			parent_set: parent = a_parent;
			dialog_set: associated_dialog = a_dialog;
			action_set: current_action = an_action
		end;

feature -- Actions

	current_action: WIZARD_ACTION
			-- The first action to be started when the wizards becomes active.

feature -- Graphical User Interafce

	associated_dialog: WIZARD_DIALOG
			-- The dialog box where everything is displayed in.

feature -- Action Iteration

	execute_action is
			-- Call all actions in order to do the wizard's task.
		do
			current_action.build_interface;
			associated_dialog.popup;
		end;

	previous_action is
			-- Checks in `current_action' whether there is a previous step.
			-- If so, it will be invoked, otherwise if `current_action'
			-- is not aborted the information is to be processed.
		do
			if current_action.has_previous_action then
				current_action := current_action.previous_action;
			else
				if current_action.is_finished then
					current_action.process_information
					if current_action.processed then
						associated_dialog.previous_button.remove_activate_action (current_action, current_action.previous);
						associated_dialog.abort_button.remove_activate_action (current_action, current_action.abort);
						associated_dialog.next_button.remove_activate_action (current_action, current_action.next)
						associated_dialog.popdown
					end
				else
					associated_dialog.previous_button.remove_activate_action (current_action, current_action.previous);
					associated_dialog.abort_button.remove_activate_action (current_action, current_action.abort);
					associated_dialog.next_button.remove_activate_action (current_action, current_action.next)
					associated_dialog.popdown;
				end;
			end;
		end;

	next_action is
			-- Checks in `current_action' whether there is a next step.
			-- If so, it will be invoked, otherwise if `current_action'
			-- is not aborted the information is to be processed.
		do
			if current_action.has_next_action then
				current_action := current_action.next_action;
			else
				if current_action.is_finished then
					current_action.process_information
					if current_action.processed then
						associated_dialog.previous_button.remove_activate_action (current_action, current_action.previous);
						associated_dialog.abort_button.remove_activate_action (current_action, current_action.abort);
						associated_dialog.next_button.remove_activate_action (current_action, current_action.next)
						associated_dialog.popdown
					end
				else
					associated_dialog.previous_button.remove_activate_action (current_action, current_action.previous);
					associated_dialog.abort_button.remove_activate_action (current_action, current_action.abort);
					associated_dialog.next_button.remove_activate_action (current_action, current_action.next)
					associated_dialog.popdown;
				end;
			end;
		end;

feature {NONE} -- Properties

	parent: COMPOSITE;
			-- The parent of Current.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class WIZARD
