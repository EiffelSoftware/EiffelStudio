indexing
	description:
		"A dialog to sllow the user to choose some accelerators."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ACCELERATOR_SELECTION_DIALOG

inherit
	EV_STANDARD_DIALOG
		redefine
			implementation
		end

creation
	make,
	make_with_text,
	make_with_actions,
	make_with_all

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a message dialog with `par' as parent.
		do
			create implementation.make (par)
		end

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a message dialog with `par' as parent.
		do
			create implementation.make_with_text (par, txt)
		end

	make_with_actions (par: EV_CONTAINER; actions: LINKED_LIST [STRING]) is
			-- Create a message_dialog with `par' as parent and
			-- `actions' as action to fill with an accelerator.
		require
			valid_parent: is_valid (par)
			valid_actions: actions /= Void
			actions_not_empty: not actions.empty
		do
			create implementation.make_with_actions (par, actions)
		end

	make_with_all (par: EV_CONTAINER; txt: STRING; actions: LINKED_LIST [STRING]) is
			-- Create a message_dialog with `par' as parent, 
			-- `txt' as title and `actions' as list item.
		require
			valid_parent: is_valid (par)
			valid_text: txt /= Void
			valid_actions: actions /= Void
			actions_not_empty: not actions.empty
		do
			create implementation.make_with_all (par, txt, actions)
		end

feature -- Access

	accelerators: LINKED_LIST [EV_ACCELERATOR] is
			-- Accelerators choosen by the user
		require
			exitst: not destroyed
		do
			Result := implementation.accelerators
		end


feature -- Basic operation

	set_default_accelerators (acc: LINKED_LIST [EV_ACCELERATOR]) is
			-- Make `acc' the default accelerators linked to the
			-- user actions. They must be given in the same order
			-- than the actions at the creation of the dialog.
			-- Initialize the `acc.count' first actions of the
			-- dialogs.
		require
			exists: not destroyed
			valid_accelerators: acc /= Void
		do
			implementation.set_default_accelerators (acc)
		end

feature -- Implementation

	implementation: EV_ACCELERATOR_SELECTION_DIALOG_I
			-- Access to the implementation.

end -- class EV_ACCELERATOR_SELECTION_DIALOG

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
