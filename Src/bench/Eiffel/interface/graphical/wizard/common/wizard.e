indexing

	description:
		"Abstarct notion of a wizard used to help the user with difficult %
		%steps during development.";
	date: "$Date$";
	revision: "$Revision$"

class WIZARD

creation
	make

feature -- Initialization

	make (a_parent: COMPOSITE; a_dialog: WIZARD_DIALOG; an_action: WIZARD_ACTION) is
			-- Initialize Current. Set `associated_dialog' to `a_dialog',
			-- `current_action' to `an_action'.
		require
			non_void_parent: a_parent /= Void;
			non_void_dialog: a_dialog /= Void;
			non_void_action: an_action /= Void
		do
			parent := a_parent;
			associated_dialog := a_dialog;
			current_action := an_action;
			an_action.init (Current, a_dialog);
--			a_dialog.previous_button.add_activate_action (an_action, an_action.previous);
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
						associated_dialog.popdown
					end
				else
					associated_dialog.popdown;
				end;
			end;
			if not associated_dialog.destroyed then
				associated_dialog.destroy
			end
		end;

feature {NONE} -- Properties

	parent: COMPOSITE
			-- The parent of Current.

end -- class WIZARD
