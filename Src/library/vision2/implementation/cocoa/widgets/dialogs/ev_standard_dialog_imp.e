indexing
	description: "Eiffel Vision standard dialog. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STANDARD_DIALOG_IMP

inherit
	EV_STANDARD_DIALOG_I
		redefine
			interface
		select
			interface,
			make
		end

	EV_STANDARD_DIALOG_ACTION_SEQUENCES_IMP

	EV_DIALOG_CONSTANTS
		export
			{NONE} all
		end

	EV_WINDOW_IMP
		rename
			interface as w_interface,
			make as w_make
		redefine
			initialize,
			destroy,
			call_close_request_actions
		end

feature {NONE} -- Implementation

	initialize
			-- Initialize dialog
		do
			create selected_button.make_empty
		end

feature -- Status report

	selected_button: STRING_32
			-- Label of the last clicked button.

feature -- Status setting

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show `Current' modal with respect to `a_window'.
		do
--			selected_button := Void

			if selected_button /= Void then
				if selected_button.is_equal (internal_accept) then
					interface.ok_actions.call (Void)
				elseif selected_button.is_equal (ev_cancel) then
					interface.cancel_actions.call (Void)
				end
			end
		end

	blocking_window: EV_WINDOW
		do

		end

feature {NONE} -- Implementation

	enable_closeable
			-- Set the window to be closeable by the user
		do
		end

	call_close_request_actions
			-- Call `on_cancel' if user wants to quit dialog.
		do
			on_cancel
		end

	user_clicked_ok: BOOLEAN
		-- Has the user explicitly cancelled the dialog.

	interface: EV_STANDARD_DIALOG

	default_wm_decorations: INTEGER
			-- Default Window Manager decorations of `Current'.
		do
		end

	destroy
		do
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_ok
			-- Close window and call action sequence.
		do
			user_clicked_ok := True
			selected_button := internal_accept
		end

	on_cancel
			-- Close window and call action sequence.
		do
			selected_button := ev_cancel
		end

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"

end -- class EV_STANDARD_DIALOG_IMP

