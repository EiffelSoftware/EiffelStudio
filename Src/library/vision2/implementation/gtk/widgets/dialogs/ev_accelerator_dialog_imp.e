indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ACCELERATOR_DIALOG_IMP

inherit
	EV_ACCELERATOR_DIALOG_I

	EV_SELECTION_DIALOG_IMP
		undefine
			destroy,
			destroyed,
			set_title,
			set_parent,
			show
		end

creation
	make,
	make_with_text,
	make_with_actions,
	make_with_all

feature -- Access

	ok_widget: POINTER is
			-- Pointer to the gtk_button `OK' of the dialog.
		do
		end

	cancel_widget: POINTER is
			-- Pointer to the gtk_button `Cancel' of the dialog.
		do
		end

feature -- Event - command association

	add_ok_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed when
			-- the "OK" button is pressed.
		do
		end

feature -- Event -- removing command association

	remove_ok_commands is
			-- Empty the list of commands to be executed when
			-- "OK" button is pressed.
		do
		end

end -- class EV_ACCELERATOR_DIALOG_IMP
