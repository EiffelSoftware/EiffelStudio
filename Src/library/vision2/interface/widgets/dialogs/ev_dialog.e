indexing
	description:
		"Window intended for transient user interaction.%N%
		%Optionally modal. A modal dialog blocks the rest of the application%
		%until closed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "dialog, dialogue, popup, window"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIALOG

inherit
	EV_TITLED_WINDOW
		export {EV_DOCKABLE_SOURCE_I}
			close_request_actions
		redefine 
			implementation,
			create_implementation,
			initialize
		end

create
	default_create

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
			-- Note that `dialog_key_press_action' is inserted into the
			-- `key_press_actions'. This handles the default and cancel
			-- button processing and can be removed if necessary.
			-- See comment of `dialog_key_press_action'.
		do
			key_press_actions.extend (agent dialog_key_press_action)
			implementation.disable_closeable
			Precursor {EV_TITLED_WINDOW}
		end

feature -- Access

	default_push_button: EV_BUTTON is
			-- Default pushed button. This is the button that
			-- is pushed if the user press the enter key unless
			-- a push button is currently focused.
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

	is_modal: BOOLEAN is
			-- Is `Current' shown modally to another window?
			-- If `True' then `Current' must be closed before
			-- application can receive user events again?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_modal
		end
		
	is_relative: BOOLEAN is
			-- Is `Current' shown relative to another window?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_relative
		end
		
	blocking_window: EV_WINDOW is
			-- `Result' is window `Current' is shown to if
			-- `is_modal' or `is_relative'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.blocking_window
		ensure
			bridge_ok: Result = implementation.blocking_window
		end
		

feature -- Status Setting

	set_default_push_button (a_button: EV_BUTTON) is
			-- Assign `a_button' to `default push button'.
		require
			not_destroyed: not is_destroyed
			a_button_not_void: a_button /= Void
			has_button: has_recursive (a_button)
		do
			implementation.set_default_push_button (a_button)
		ensure
			default_push_button_set: default_push_button = a_button
		end

	remove_default_push_button is
			-- Remove `default_push_button'.
		require
			not_destroyed: not is_destroyed
			has_default_push_button: default_push_button /= Void
		do
			implementation.remove_default_push_button
		ensure
			not_has_default_push_button: default_push_button = Void
		end
	
	set_default_cancel_button (a_button: EV_BUTTON) is
			-- Assign `a_button' to `default_cancel_button'.
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
			-- Remove `default_cancel_button'.
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
		ensure
				-- When a dialog is displayed modally, execution of code is
				-- halted until the dialog is closed or destroyed. Therefore,
				-- this postcondition will only be executed after the dialog
				-- is closed or destroyed.
			dialog_closed_so_no_blocking_window:
				not is_destroyed implies blocking_window = Void
		end

	show_relative_to_window (a_window: EV_WINDOW) is
			-- Show `Current' with respect to `a_window'.
		require
			not_destroyed: not is_destroyed
			a_window_not_void: a_window /= Void
			a_window_not_current: a_window /= Current
		do
			implementation.show_relative_to_window (a_window)
		ensure
			is_relative_to_window: is_relative
			blocking_window_set: blocking_window = a_window
		end
		
	dialog_key_press_action (a_key: EV_KEY) is
			-- The action performed to process default push and cancel
			-- buttons. This is inserted in `key_press_actions' and
			-- behaves as follows:
			-- If escape is pressed at any time then
				-- If there is a `default_cancel_button' then
					-- If it is sensitive, call its `select_actions',
					-- otherwise, close the dialog.
					-- If there is no `default_cancel_button', do nothing.	
			-- If enter is pressed at any time then
				-- If a push button is currently focused then call its
				-- `select_actions'. If no push button has the focus, then
				-- call the `select_actions' of the default push button if
				-- it is sensitive.
		require
			not_destroyed: not is_destroyed
		do
			implementation.dialog_key_press_action (a_key)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_DIALOG_I
			-- Responsible for interaction with native graphics toolkit.
			
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_DIALOG_IMP} implementation.make (Current)
		end
		
invariant
	
	modal_or_relative: is_usable implies (is_modal implies not is_relative and is_relative implies not is_modal)
	blocking_window_correct: is_usable implies (is_modal or is_relative implies blocking_window /= Void)
	no_blocking_window_correct: is_usable implies (not is_modal and not is_relative implies blocking_window = Void)
	no_blocking_window_when_hidden: is_usable implies (not is_show_requested implies blocking_window = Void)
	

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




end -- class EV_DIALOG

