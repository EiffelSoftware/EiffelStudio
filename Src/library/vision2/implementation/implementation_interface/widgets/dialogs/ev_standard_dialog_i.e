indexing
	description: "EiffelVision standard dialog. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	title: STRING_32 is
			-- Title of dialog shown in title bar.
		deferred
		end

	blocking_window: EV_WINDOW is
			-- Window this dialog is a transient for.
		deferred
		end

feature -- Status report

	selected_button: STRING_32 is
			-- Label of the last clicked button.
		deferred
		end

feature -- Status setting

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show the dialog modal with respect to `a_window'.
		deferred
		end

	set_title (a_title: STRING_GENERAL) is
			-- Set the title of the dialog.
		deferred
		end

feature {NONE} -- Implementation

	internal_accept: STRING_32 is
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

	interface: EV_STANDARD_DIALOG;

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




end -- class EV_STANDARD_DIALOG_I

