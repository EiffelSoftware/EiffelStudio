indexing
	description: "Eiffel Vision dialog. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIALOG_IMP
	
inherit
	EV_DIALOG_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_TITLED_WINDOW_IMP
		redefine
			make,
			interface,
			call_close_request_actions
		end

create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Create empty dialog box.
		do
			base_make (an_interface)
			set_c_object (C.gtk_window_new (C.Gtk_window_dialog_enum))
			C.gtk_widget_realize (c_object)
			C.gtk_window_set_position (c_object, C.Gtk_win_pos_center_enum)
			C.gtk_window_set_policy (c_object, 0, 0, 1) -- False, False, True
			enable_closeable
		end
		
feature -- Status Report

	is_closeable: BOOLEAN is
			-- Is the window closeable by the user?
			-- (Through a clik on the Window Menu, or by
			-- pressing ALT-F4)
		do
			Result := is_dialog_closeable
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

feature -- Basic operations

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show `Current' modal with respect to `a_window'.
		local
			was_modal: BOOLEAN
			parent_was_modal: BOOLEAN
			a_window_imp: EV_WINDOW_IMP
		do
				-- Remove the modality of the parent if it is modal
			if a_window /= Void then
				a_window_imp ?= a_window.implementation

				if a_window_imp.is_modal then
					parent_was_modal := True
					a_window_imp.disable_modal
				end
			end

			if is_modal then
				was_modal := True
			else
				enable_modal
			end

			if a_window /= Void then
				C.gtk_window_set_transient_for (c_object, a_window_imp.c_object)
			else
				C.gtk_window_set_transient_for (c_object, NULL)
			end				
			
			show
			block
			if not is_destroyed and then not was_modal then
				disable_modal
			end

				-- Put parent's original modality back.
			if a_window /= Void and then parent_was_modal then
				a_window_imp.enable_modal
			end
		end

	show_relative_to_window (a_window: EV_WINDOW) is
			-- Show `Current' with respect to `a_window'.
		local
			a_window_imp: EV_WINDOW_IMP
		do
			if a_window /= Void then
				a_window_imp ?= a_window.implementation
				C.gtk_window_set_transient_for (c_object, a_window_imp.c_object)
			else
				C.gtk_window_set_transient_for (c_object, NULL)
			end				
			show
		end

feature {NONE} -- Implementation

	set_closeable (new_status: BOOLEAN) is
			-- Set `is_closeable' to `new_status'
		local
			close_fct: INTEGER
		do
			if new_status then
				close_fct := C.GDK_FUNC_CLOSE_ENUM
			end
			C.gdk_window_set_functions (
				C.gtk_widget_struct_window (c_object),
				C.GDK_FUNC_MOVE_ENUM.bit_or (close_fct)
			)
			is_dialog_closeable := new_status
		end

	call_close_request_actions is
			-- Call the cancel actions if dialog is closeable.
		do
			if is_dialog_closeable and then internal_default_cancel_button /= Void then
				if internal_default_cancel_button.select_actions /= Void then
					internal_default_cancel_button.select_actions.call ([])
				end
			end
		end

	interface: EV_DIALOG
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

	is_dialog_closeable: BOOLEAN
			-- Temporary flag whose only use is to enable functions
			-- `is_closeable', `enable_closeable' and `disable_closeable'
			-- to be executed without raising zillions of assertion violations.
			--| FIXME implement cited function, then remove me.

end -- class EV_DIALOG_IMP

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

