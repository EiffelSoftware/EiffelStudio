--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		" This class gives the attributes and the features needed to handle%
		% the accelerator_list on the widgets, items, dialogs..."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ACCELERATOR_HANDLER_IMP

obsolete
	"Remove me?"

feature {NONE} -- Initialization

	initialize_accel_list is
			-- Initialize the list of accelerator_list added to
			-- the window.
		do
		end

feature {EV_APPLICATION_IMP} -- Access

	accelerator_table: EV_ACCELERATOR_TABLE_IMP is
			-- Table that memories and passes the accelerators to the
			-- system. In this table, all the accelerators are unique.
		once
			create Result
		end

feature {NONE} -- Status report

	has_accel_command (id: INTEGER): BOOLEAN is
			-- Does the object has at least one command on the
			-- acceleraor given by `id'.
		do
		end

feature {NONE} -- Element change

	add_accel_command (acc: EV_ACCELERATOR; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `acc' to the list of accelerator_list.
		require
			valid_command: cmd /= Void
		do
		end

	remove_accel_commands (acc: EV_ACCELERATOR) is
			-- Remove an accelerator from the table.
		do
		end

feature {NONE} -- WEL Implementation

	on_accelerator_command (id: INTEGER) is
			-- The `acelerator_id' has been activated.
		do
		end

feature {NONE} -- Deferred feature

	parent_imp: EV_CONTAINER_IMP is
			-- Parent of the current widget.
		deferred
		end

	application: CELL [EV_APPLICATION_IMP] is
			-- The current application. Needed for the
			-- accelerators.
		deferred
		end

	focus_on_widget: CELL [EV_WIDGET_IMP] is
			-- Widget that currently have the focus.
		deferred
		end

end -- class EV_ACCELERATOR_HANDLER_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.10.3  2000/01/27 19:30:13  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.10.2  2000/01/25 17:37:51  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.3.10.1  1999/11/24 17:30:20  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
