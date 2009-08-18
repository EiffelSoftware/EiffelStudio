note
	description: "Eiffel Vision dialog. Cocoa implementation."
	author:	"Daniel Furrer"

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
			destroy
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize 'Current'
		do
			allow_resize
			Precursor {EV_TITLED_WINDOW_IMP}
			is_show_requested := False
		end

feature -- Status Report

	is_closeable: BOOLEAN
			-- Is the window closeable by the user?

	is_modal: BOOLEAN
			-- Is `Current' shown modally to another window?
			-- If `True' then `Current' must be closed before
			-- application can receive user events again?

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show and wait until window is closed.
			-- `Current' is show modal with respect to `a_window'.
		local
			ret: INTEGER
		do
			is_modal := True
			show
			ret := app_implementation.run_modal_for_window (current)
			is_modal := False
		end

feature -- Status Setting

	enable_closeable
			-- Set the window to be closeable by the user
		do
			is_closeable := True
		end

	disable_closeable
			-- Set the window not to be closeable by the user
		do
			is_closeable := False
		end

feature {NONE} -- Implementation

	dialog_key_press_action (a_key: EV_KEY)
		do
		end

	set_closeable (new_status: BOOLEAN)
			-- Set `is_closeable' to `new_status'
		do
		end

	is_dialog_closeable: BOOLEAN;
			-- Temporary flag whose only use is to enable functions
			-- `is_closeable', `enable_closeable' and `disable_closeable'
			-- to be executed without raising zillions of assertion violations.
			--| FIXME implement cited function, then remove me.

	destroy
		do
			Precursor {EV_TITLED_WINDOW_IMP}
			app_implementation.abort_modal
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DIALOG note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_DIALOG_IMP
