note
	description: "Eiffel Vision dialog. Cocoa implementation."

class
	EV_DIALOG_IMP

inherit
	EV_DIALOG_I
		undefine
			propagate_foreground_color,
			propagate_background_color,
			dialog_key_press_action,
			lock_update,
			unlock_update
		redefine
			interface
		end

	EV_TITLED_WINDOW_IMP
		redefine
			make,
			interface,
			call_close_request_actions,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create empty dialog box.
		do
			base_make (an_interface)
			create {NS_WINDOW}cocoa_item.make (create {NS_RECT}.make_rect (100, 100, 100, 100),
				{NS_WINDOW}.closable_window_mask, True)
			window.make_key_and_order_front
			allow_resize
			create_delegate
			window.set_delegate (current)
--			Precursor {EV_TITLED_WINDOW_IMP} (an_interface)
		end

	initialize
			-- Initialize 'Current'
		do
			Precursor {EV_TITLED_WINDOW_IMP}
		end

feature -- Status Report

	is_closeable: BOOLEAN
			-- Is the window closeable by the user?
		do
		end

	is_modal: BOOLEAN
			-- Is `Current' shown modally to another window?
			-- If `True' then `Current' must be closed before
			-- application can receive user events again?
		do
		end

	is_relative: BOOLEAN
			-- Is `Current' shown relative to another window?
		do
		end

	blocking_window: EV_WINDOW
			-- `Result' is window `Current' is shown to if
			-- `is_modal' or `is_relative'.

		do
		end

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show and wait until window is closed.
			-- `Current' is show modal with respect to `a_window'.
		local
			ret: INTEGER
		do
			show
			ret := app_implementation.application.run_modal_for_window (window)
		end

feature -- Status Setting

	enable_closeable
			-- Set the window to be closeable by the user
		do
		end

	disable_closeable
			-- Set the window not to be closeable by the user
		do
		end

feature {NONE} -- Implementation

	dialog_key_press_action (a_key: EV_KEY)
		do
		end

	set_closeable (new_status: BOOLEAN)
			-- Set `is_closeable' to `new_status'
		do
		end

	call_close_request_actions
			-- Call the cancel actions if dialog is closeable.
		do
			Precursor
		end

	interface: EV_DIALOG
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

	is_dialog_closeable: BOOLEAN;
			-- Temporary flag whose only use is to enable functions
			-- `is_closeable', `enable_closeable' and `disable_closeable'
			-- to be executed without raising zillions of assertion violations.
			--| FIXME implement cited function, then remove me.

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_DIALOG_IMP

