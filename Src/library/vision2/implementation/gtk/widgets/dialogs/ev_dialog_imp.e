indexing
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
			make,
			interface,
			call_close_request_actions,
			initialize,
			client_area
		end

	EV_GTK_DEPENDENT_ROUTINES

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create empty dialog box.
		do
			base_make (an_interface)
			set_c_object (create_gtk_dialog)
		end

	initialize is
			-- Initialize 'Current'
		do
			Precursor {EV_TITLED_WINDOW_IMP}
			enable_closeable
		end

feature -- Status Report

	is_closeable: BOOLEAN is
			-- Is the window closeable by the user?
		do
			Result := is_dialog_closeable
		end

	is_relative: BOOLEAN is
			-- Is `Current' shown relative to another window?
		do
			Result := {EV_GTK_EXTERNALS}.gtk_window_struct_transient_parent (c_object) /= default_pointer
				and then is_show_requested
		end

feature -- Status Setting

	enable_closeable is
			-- Set the window to be closeable by the user
		do
			set_closeable (True)
		end

	disable_closeable is
			-- Set the window not to be closeable by the user
		do
			set_closeable (False)
		end

feature {NONE} -- Implementation

	client_area: POINTER is
			-- Pointer to the widget that is treated as the main holder of the client area within the window.
		do
			Result := client_area_from_c_object (c_object)
		end

	set_closeable (new_status: BOOLEAN) is
			-- Set `is_closeable' to `new_status'
		local
			close_fct: INTEGER
		do
			if new_status then
				close_fct := {EV_GTK_EXTERNALS}.Gdk_func_close_enum
			end
			close_fct := close_fct.bit_or ({EV_GTK_EXTERNALS}.Gdk_func_move_enum)
		    close_fct := close_fct.bit_or ({EV_GTK_EXTERNALS}.Gdk_func_resize_enum)
			{EV_GTK_EXTERNALS}.gdk_window_set_functions (
				{EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object),
				close_fct
			)
			is_dialog_closeable := new_status
		end

	call_close_request_actions is
			-- Call the cancel actions if dialog is closeable.
		do
			Precursor {EV_TITLED_WINDOW_IMP}
			if is_dialog_closeable and then not App_implementation.is_in_transport then
				if internal_default_cancel_button /= Void and then
					internal_default_cancel_button.is_sensitive-- and then
					--internal_default_cancel_button.is_displayed
					then
						if internal_default_cancel_button.select_actions /= Void then
							internal_default_cancel_button.select_actions.call (Void)
						end
				end
			end
		end

	interface: EV_DIALOG
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

	is_dialog_closeable: BOOLEAN;
			-- Temporary flag whose only use is to enable functions
			-- `is_closeable', `enable_closeable' and `disable_closeable'
			-- to be executed without raising zillions of assertion violations.
			--| FIXME implement cited function, then remove me.

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




end -- class EV_DIALOG_IMP

