indexing
	description: "EiffelVision standard dialog. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STANDARD_DIALOG_I

inherit
	EV_ANY_I
		redefine
			interface
		end

	EV_POSITIONABLE_I
		redefine
			interface
		end
		
	EV_STANDARD_DIALOG_ACTION_SEQUENCES_I
	
	EV_DIALOG_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	title: STRING is
			-- Title of dialog shown in title bar.
		deferred
		end

	blocking_window: EV_WINDOW is
			-- Window this dialog is a transient for.
		deferred
		end

feature -- Status report

	selected_button: STRING is
			-- Label of the last clicked button.
		deferred
		end

feature -- Status setting

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show the dialog modal with respect to `a_window'.
		deferred
		end

	set_title (a_title: STRING) is
			-- Set the title of the dialog.
		deferred
		end

feature {NONE} -- Implementation

	internal_accept: STRING is
			-- The text of the "ok" type button of `Current'.
			-- e.g. not the cancel button.
			-- Normally "OK", but redefined in some descendents
			-- such as EV_PRINT_DIALOG where the text is "Print"
			-- This allows us to do this redefinition in a platform
			-- independent way, and to always set `selected_button'
			-- to `internal_select' without having to redfine the
			-- feature in which this setting takes place.
		do
			Result := ev_ok
		end

	interface: EV_STANDARD_DIALOG

end -- class EV_STANDARD_DIALOG_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

