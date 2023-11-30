note
	description: "Eiffel Vision dialog. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIALOG_IMP

inherit
	EV_DIALOG_I
		undefine
			propagate_foreground_color,
			propagate_background_color,
			lock_update,
			unlock_update
		redefine
			interface
		end

	EV_TITLED_WINDOW_IMP
		redefine
			old_make,
			interface,
			call_close_request_actions,
			make,
			client_area,
			new_gtk_window,
			default_window_position
		end

	EV_GTK_DEPENDENT_ROUTINES

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create empty dialog box.
		do
			assign_interface (an_interface)
		end

	new_gtk_window: POINTER
			-- Return a new gtk window object for `Current'
		do
			Result := create_gtk_dialog
		end

	make
			-- Initialize 'Current'
		do
			Precursor {EV_TITLED_WINDOW_IMP}
			enable_closeable
		end

feature -- Status Report

	is_closeable: BOOLEAN
			-- Is the window closeable by the user?
		do
			Result := is_dialog_closeable
		end

	is_relative: BOOLEAN
			-- Is `Current' shown relative to another window?
		do
			Result := {GTK}.gtk_window_get_transient_for (c_object) /= default_pointer
				and then is_show_requested
		end

feature -- Status Setting

	enable_closeable
			-- Set the window to be closeable by the user
		do
			set_closeable (True)
		end

	disable_closeable
			-- Set the window not to be closeable by the user
		do
			set_closeable (False)
		end

feature {NONE} -- Implementation

	default_window_position: INTEGER
			-- <Precursor>
		do
			Result := {GTK}.gtk_win_pos_center_enum
		end

	client_area: POINTER
			-- Pointer to the widget that is treated as the main holder of the client area within the window.
		do
			Result := client_area_from_c_object (c_object)
		end

	set_closeable (new_status: BOOLEAN)
			-- Set `is_closeable' to `new_status'
		local
			close_fct: INTEGER
		do
			if new_status then
				close_fct := {GTK}.Gdk_func_close_enum
			end
			close_fct := close_fct.bit_or ({GTK}.Gdk_func_move_enum)
		    close_fct := close_fct.bit_or ({GTK}.Gdk_func_resize_enum)
			{GDK}.gdk_window_set_functions (
				{GTK}.gtk_widget_get_window (c_object),
				close_fct
			)
			is_dialog_closeable := new_status
		end

	call_close_request_actions
			-- Call the cancel actions if dialog is closeable.
		do
			if not has_modal_window and then is_dialog_closeable and then not App_implementation.is_in_transport and then not is_destroyed then
				dialog_key_press_action (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_escape))
				Precursor {EV_TITLED_WINDOW_IMP}
			end
		end

	is_dialog_closeable: BOOLEAN;
			-- Temporary flag whose only use is to enable functions
			-- `is_closeable', `enable_closeable' and `disable_closeable'
			-- to be executed without raising zillions of assertion violations.
			--| FIXME implement cited function, then remove me.

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DIALOG note option: stable attribute end
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_DIALOG_IMP
