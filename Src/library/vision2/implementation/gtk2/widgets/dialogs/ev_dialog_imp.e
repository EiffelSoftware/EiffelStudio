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
			propagate_background_color,
			dialog_key_press_action
		redefine
			interface
		end

	EV_TITLED_WINDOW_IMP
		redefine
			make,
			interface,
			call_close_request_actions,
			client_area
		end
		
create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Create empty dialog box.
		do
			base_make (an_interface)
			set_c_object (feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_dialog_new)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_dialog_set_has_separator (c_object, False)
			feature {EV_GTK_EXTERNALS}.gtk_widget_hide (feature {EV_GTK_EXTERNALS}.gtk_dialog_struct_action_area (c_object))
			feature {EV_GTK_EXTERNALS}.gtk_widget_realize (c_object)
			feature {EV_GTK_EXTERNALS}.gtk_window_set_policy (c_object, 0, 0, 1) -- allow_shrink = False, allow_grow = False, auto_shrink = True
			enable_closeable
		end
		
	client_area: POINTER is
			-- Pointer to the client area where the widgets are contained within the dialog.
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_dialog_struct_vbox (c_object)
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
			Result := not is_modal and feature {EV_GTK_EXTERNALS}.gtk_window_struct_transient_parent (c_object) /= default_pointer
				and is_show_requested
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

			set_blocking_window (a_window)			
			show
			block
			set_blocking_window (Void)
			
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
		do
			set_blocking_window (a_window)			
			show
		end

feature {NONE} -- Implementation

	dialog_key_press_action (a_key: EV_KEY) is
		local
			a_key_code: INTEGER
		do
			if a_key /= Void then
				a_key_code := a_key.code

				if a_key_code = Key_constants.Key_escape and then
					default_cancel_button /= Void then
						-- We now check if `default_cancel_button' is sensitive
						-- as we only call its select_actions if it is sensitive.
					if default_cancel_button.is_sensitive then
							-- Escape key pressed and `default_cancel_button' is
							-- sensitive so simulate a press.
						default_cancel_button.select_actions.call ([])
					end
	
				elseif a_key_code = Key_constants.Key_enter and then
					current_push_button /= Void then
					if current_push_button.is_sensitive and not current_push_button.has_focus then
							-- Enter key pressed and `current_push_button' is
							-- sensitive so simulate a press.
						current_push_button.select_actions.call ([])
					end
				end
			end
		end

	set_closeable (new_status: BOOLEAN) is
			-- Set `is_closeable' to `new_status'
		local
			close_fct: INTEGER
		do
			if new_status then
				close_fct := feature {EV_GTK_EXTERNALS}.gDK_FUNC_CLOSE_ENUM
			end
			feature {EV_GTK_EXTERNALS}.gdk_window_set_functions (
				feature {EV_GTK_EXTERNALS}.gtk_widget_struct_window (c_object),
				feature {EV_GTK_EXTERNALS}.gDK_FUNC_MOVE_ENUM.bit_or (close_fct)
			)
			is_dialog_closeable := new_status
		end

	call_close_request_actions is
			-- Call the cancel actions if dialog is closeable.
		do
			Precursor {EV_TITLED_WINDOW_IMP}
			if is_dialog_closeable then 
				if internal_default_cancel_button /= Void and then
					internal_default_cancel_button.is_sensitive-- and then
					--internal_default_cancel_button.is_displayed 
					then
						if internal_default_cancel_button.select_actions /= Void then
							internal_default_cancel_button.select_actions.call ([])
						end
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

