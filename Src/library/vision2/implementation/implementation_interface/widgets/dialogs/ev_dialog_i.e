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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.14  2001/06/29 21:54:41  pichery
--| - Changed the behavior of the `default_push_button', we now use
--|   `current_push_button': the currently focused push button.
--| - The redrawing of the button with bold border is now done in vision2
--|   rather than by Windows itself.
--|
--| Revision 1.13  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.9.4.9  2001/05/18 00:18:28  rogers
--| Modified behaviour of dialog_key_press_action. If we have a default
--| cancel button and it has been disabled, then we do nothing when escape
--| is pressed.
--|
--| Revision 1.9.4.8  2001/05/02 22:58:26  rogers
--| We now always call the default_push_button, even if it does not have teh focus.
--|
--| Revision 1.9.4.7  2001/05/01 14:07:40  pichery
--| Exported `internal_default_[push|cancel]_button' to EV_DIALOG_I to be able
--| to copy these attributes between 2 implementations of EV_DIALOG_IMP
--| (modal and modeless for example)
--|
--| Revision 1.9.4.6  2001/04/27 22:56:13  king
--| Changed export clause to suit interface change
--|
--| Revision 1.9.4.5  2001/04/27 21:28:31  rogers
--| Added developer comment/warning in dialog_key_press_action.
--|
--| Revision 1.9.4.4  2001/04/27 20:14:54  rogers
--| Moved features here from ev_dialog to hide details of out implementation
--| from the user.
--|
--| Revision 1.9.4.3  2001/02/03 21:22:41  pichery
--| Added new feature `show_relative_to_window'
--|
--| Revision 1.9.4.2  2000/08/16 19:52:23  king
--| Added show_modal_to_window
--|
--| Revision 1.9.4.1  2000/05/03 19:09:04  oconnor
--| mergred from HEAD
--|
--| Revision 1.12  2000/04/29 03:01:48  pichery
--| Added feature `is_closeable', `enable/disable_closeable'.
--|
--| Revision 1.11  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.10  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.6.9  2000/02/08 01:00:12  king
--| Moved modality features from dialog to window
--|
--| Revision 1.9.6.8  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.9.6.7  2000/02/01 23:24:56  brendel
--| Removed export {NONE} of set_default_minimum_size.
--|
--| Revision 1.9.6.6  2000/01/27 19:30:01  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.6.5  2000/01/26 22:08:02  brendel
--| Added `blocking_window' and `set_blocking_window'.
--|
--| Revision 1.9.6.4  2000/01/26 18:10:38  brendel
--| Added features `is_modal', `enable_modal' and `disable_modal'.
--|
--| Revision 1.9.6.3  2000/01/26 01:38:49  brendel
--| Added features `block' and `show_modal'.
--|
--| Revision 1.9.6.2  2000/01/25 18:40:05  oconnor
--| incomplete reorgainisation
--|
--| Revision 1.9.6.1  1999/11/24 17:30:10  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.3  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
