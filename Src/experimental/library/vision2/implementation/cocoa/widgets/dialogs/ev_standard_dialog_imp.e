note
	description: "Eiffel Vision standard dialog. Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STANDARD_DIALOG_IMP

inherit
	EV_STANDARD_DIALOG_I
		redefine
			interface
		select
			copy
--			interface,
--			make
		end

	EV_STANDARD_DIALOG_ACTION_SEQUENCES_IMP

	EV_ANY_IMP
		undefine
			dispose,
			destroy
		redefine
			interface
		end

	EV_DIALOG_CONSTANTS
		export
			{NONE} all
		end

	EV_NS_WINDOW

feature {NONE} -- Implementation

	make
			-- Initialize dialog
		do
			cocoa_make (create {NS_RECT}.make_rect (100, 100, 100, 100),
				{NS_WINDOW}.closable_window_mask | {NS_WINDOW}.miniaturizable_window_mask | {NS_WINDOW}.resizable_window_mask, True)
			make_key_and_order_front (current)
			order_out
			allow_resize
			set_is_initialized (True)
		end

feature -- Status report

	selected_button: detachable STRING_32
			-- Label of the last clicked button.

feature -- Status setting

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show `Current' modal with respect to `a_window'.
		local
			button: INTEGER
		do
			button := app_implementation.run_modal_for_window (current)

			if button =  {NS_PANEL}.ok_button then
				selected_button := internal_accept
				ok_actions.call (Void)
			elseif button = {NS_PANEL}.cancel_button then
				selected_button := ev_cancel
				cancel_actions.call (Void)
			end
		end

	blocking_window: detachable EV_WINDOW
		do

		end

feature {NONE} -- Implementation

	on_key_event (a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN)
		do

		end

	minimum_width: INTEGER
		do

		end

	minimum_height: INTEGER
		do

		end

	enable_closeable
			-- Set the window to be closeable by the user
		do
		end

	destroy
		do
		end

feature {EV_ANY, EV_ANY_I}

	interface: detachable EV_STANDARD_DIALOG note option: stable attribute end;

end -- class EV_STANDARD_DIALOG_IMP
