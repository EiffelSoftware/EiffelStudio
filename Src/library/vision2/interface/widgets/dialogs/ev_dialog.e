indexing
	description:
		"Window intended for transient user interaction.%N%
		%Optionaly modal. A modal dialog blocks the rest of the application%
		%until closed."
	status: "See notice at end of class"
	keywords: "dialog, dialogue, popup, window"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIALOG

inherit
	EV_TITLED_WINDOW
		export {NONE}
			close_request_actions
		redefine 
			implementation,
			create_implementation,
			initialize,
			is_modal
		end

create
	default_create

feature {NONE} -- Initialization

	initialize is
			-- Initialize the dialog box.
			-- Note that `dialog_key_press_action' is inserted into the
			-- `key_press_actions'. This handles the default and cancel
			-- button processing and can be removed if necessary.
			-- See comment of `dialog_key_press_action'.
		do
			set_icon_pixmap (default_pixmaps.Default_window_icon)
			key_press_actions.extend (~dialog_key_press_action)
			implementation.disable_closeable
			is_initialized := True
		end

feature -- Access

	default_push_button: EV_BUTTON is
			-- Default pushed button. This is the button that
			-- is pushed if the user press the enter key.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.default_push_button
		end

	default_cancel_button: EV_BUTTON is
			-- Default cancel button. This is the button that
			-- is pushed if the user press the escape key or
			-- close the window using the close icon.
			-- If there is no default cancel button, the close
			-- icon is disabled.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.default_cancel_button
		end

feature -- Access

	is_modal: BOOLEAN
			-- Must the window be closed before application can
			-- receive user events again?

feature -- Status Setting

	set_default_push_button (a_button: EV_BUTTON) is
			-- Set the default push button to `a_button'.
			-- This is the button that is pushed if the user presses
			-- the enter key.
		require
			not_destroyed: not is_destroyed
			a_button_not_void: a_button /= Void
			has_button: has_recursive (a_button)
		do
			implementation.set_default_push_button (a_button)
		end

	remove_default_push_button is
			-- Remove the default push button of this dialog.
		require
			not_destroyed: not is_destroyed
			has_default_push_button: default_push_button /= Void
		do
			implementation.remove_default_push_button
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
			not_destroyed: not is_destroyed
			a_button_not_void: a_button /= Void
			has_button: has_recursive (a_button)
		do
			implementation.set_default_cancel_button (a_button)
		ensure
			default_cancel_button_set: 
				default_cancel_button = a_button
		end
	

	remove_default_cancel_button is
			-- Remove the default cancel button of this dialog.
		require
			not_destroyed: not is_destroyed
			has_default_cancel_button: default_cancel_button /= Void
		do
			implementation.remove_default_cancel_button
		ensure
			not_has_default_cancel_button: default_cancel_button = Void
		end

feature -- Basic operations

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show and wait until `Current' is closed.
			-- `Current' is shown modal with respect to `a_window'.
		require
			not_destroyed: not is_destroyed
			dialog_modeless: not is_modal
			a_window_not_void: a_window /= Void
			a_window_not_current: a_window /= Current
		do
			implementation.show_modal_to_window (a_window)
		end

	show_relative_to_window (a_window: EV_WINDOW) is
			-- Show `Current' with respect to `a_window'.
		require
			not_destroyed: not is_destroyed
			a_window_not_void: a_window /= Void
			a_window_not_current: a_window /= Current
		do
			implementation.show_relative_to_window (a_window)
		end
		
	dialog_key_press_action (a_key: EV_KEY) is
			-- The action performed to process the default push and cancel
			-- buttons. This is inserted in the `key_press_actions' and the
			-- behviour is as follows:
			-- If escape is pressed at any time then
				-- If there is a `default_cancel_button' then
					-- If it is sensitive, call its `select_actions',
					-- otherwise, close the dialog.
					-- If there is no `default_cancel_button', do nothing.	
			-- If enter is pressed at any time then
				-- If there is a default push button which is sensitive,
				-- call its `select_actions'.
					
		do
			implementation.dialog_key_press_action (a_key)
		end
		
feature {EV_DIALOG} -- Constants

	Key_constants: EV_KEY_CONSTANTS is
		once
			create Result
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_DIALOG_I
			-- Responsible for interaction with the native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_DIALOG_IMP} implementation.make (Current)
		end

end -- class EV_DIALOG

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
