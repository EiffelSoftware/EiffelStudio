indexing
	description: "Eiffel Vision dialog. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_DIALOG_I

inherit
	EV_TITLED_WINDOW_I
		export
			{NONE} set_default_colors
		redefine
			interface
		end

feature -- Status Report

	is_closeable: BOOLEAN is
			-- Is the window closeable by the user?
			-- (Through a clik on the Window Menu, or by
			-- pressing ALT-F4)
		deferred
		end
	
	default_push_button: EV_BUTTON is
			-- Default pushed button. This is the button that
			-- is pushed if the user press the enter key unless
			-- a push button is currently focused.
		do
			Result := internal_default_push_button
		end
		
	default_cancel_button: EV_BUTTON is
			-- Default cancel button. This is the button that
			-- is pushed if the user press the escape key or
			-- close the window using the close icon.
			-- If there is no default cancel button, the close
			-- icon is disabled.
		do
			Result := internal_default_cancel_button
		end
		
	current_push_button: EV_BUTTON is
			-- Currently focused push button.
			-- This is the button that is pushed when the user
			-- press the enter key when a push button is focused.
		do
			if internal_current_push_button /= Void then
				Result := internal_current_push_button
			else
				Result := default_push_button
			end
		end

feature -- Status Setting

	set_default_push_button (a_button: EV_BUTTON) is
			-- Set the default push button to `a_button'.
			-- This is the button that is pushed if the user presses
			-- the enter key.
		require
			a_button_not_void: a_button /= Void
			has_button: interface.has_recursive (a_button)
		do
			if default_push_button /= Void then
				default_push_button.disable_default_push_button
			end 
			a_button.enable_default_push_button
			internal_default_push_button := a_button
		ensure
			default_push_button_set: 
				default_push_button = a_button
		end
		
	remove_default_push_button is
			-- Remove the default push button of this dialog.
		require
			has_default_push_button: default_push_button /= Void
		do
			default_push_button.disable_default_push_button
			internal_default_push_button := Void
		ensure
			not_has_default_push_button: default_push_button = Void
		end
		
	set_default_cancel_button (a_button: EV_BUTTON) is
			-- Assign `a_button' to default_cancel_button.This is the button
			-- that is pushed if the user press the escape key or
			-- close the window using the close icon.
			-- If there is no default cancel button, the close
			-- icon is disabled.
		require
			a_button_not_void: a_button /= Void
			has_button: interface.has_recursive (a_button)
		do
			internal_default_cancel_button := a_button
			enable_closeable
		ensure
			default_cancel_button_set: 
				default_cancel_button = a_button
		end
		
	remove_default_cancel_button is
			-- Remove the default cancel button of this dialog.
		require
			has_default_cancel_button: default_cancel_button /= Void
		do
			internal_default_cancel_button := Void
			disable_closeable
		ensure
			not_has_default_cancel_button: default_cancel_button = Void
		end
	
	enable_closeable is
			-- Set the window to be closeable by the user.
		deferred
		ensure
			closeable: is_closeable
		end

	disable_closeable is
			-- Set the window not to be closeable by the user.
		deferred
		ensure
			not_closeable: not is_closeable
		end

feature -- Basic operations

	block is
			-- Wait until window is closed by the user.
		deferred
		end

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show and wait until window is closed.
			-- `Current' is show modal with respect to `a_window'.
		deferred
		end

	show_relative_to_window (a_window: EV_WINDOW) is
			-- Show `Current' with respect to `a_window'.
		deferred
		end
		
feature {EV_DIALOG} -- Implementation 

	dialog_key_press_action (a_key: EV_KEY) is
		local
			a_key_code: INTEGER
		do
			-- EV_KEY's may be void.
			--| If this behaviour is modified, then make sure to update
			--| the description in EV_DIALOG.
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
					if current_push_button.is_sensitive then
							-- Enter key pressed and `current_push_button' is
							-- sensitive so simulate a press.
						current_push_button.select_actions.call ([])
					end
				end
			end
		end

feature {EV_DIALOG, EV_DIALOG_I, EV_WIDGET_I} -- Implementation

	internal_default_push_button: EV_BUTTON
			-- Default pushed button. This is the button that
			-- is pushed if the user pushes the enter key and
			-- if the widget that has the focus is not a push
			-- button.
			-- If the focused widget is a push button (it can
			-- be the default_push_button) it is pushed when
			-- the user presses the enter key.

	internal_default_cancel_button: EV_BUTTON
			-- The default cancel button is the button pushed 
			-- when the user press the escape key or close the 
			-- window using the close icon.
			--
			-- If there is no default cancel button, the close
			-- icon is disabled.
			
	internal_current_push_button: EV_BUTTON
			-- Current button pushed when the user press the enter
			-- key in the dialog.
			-- Void if none.
			
feature {EV_WIDGET_I} -- Implementation

	set_current_push_button (a_button: EV_BUTTON) is
			-- Set the push button to be `a_button'. `a_button' can
			-- be Void if there are no more current push button
		do
			internal_current_push_button := a_button
		ensure
			current_push_button_set: internal_current_push_button = a_button
		end
		
feature -- Implementation

	interface: EV_DIALOG
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_DIALOG_I

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

