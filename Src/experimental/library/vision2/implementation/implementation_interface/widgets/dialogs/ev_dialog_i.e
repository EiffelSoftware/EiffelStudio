note
	description: "Eiffel Vision dialog. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DIALOG_I

inherit
	EV_TITLED_WINDOW_I
		redefine
			interface
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

feature -- Status Report

	is_closeable: BOOLEAN
			-- Is the window closeable by the user?
			-- (Through a clik on the Window Menu, or by
			-- pressing ALT-F4)
		deferred
		end

	is_modal: BOOLEAN
			-- Is `Current' shown modally to another window?
			-- If `True' then `Current' must be closed before
			-- application can receive user events again?
		deferred
		end

	is_relative: BOOLEAN
			-- Is `Current' shown relative to another window?
		deferred
		end

	blocking_window: detachable EV_WINDOW
			-- `Result' is window `Current' is shown to if
			-- `is_modal' or `is_relative'.

		deferred
		end

	default_push_button: detachable EV_BUTTON
			-- Default pushed button. This is the button that
			-- is pushed if the user press the enter key unless
			-- a push button is currently focused.
		do
			Result := internal_default_push_button
		end

	default_cancel_button: detachable EV_BUTTON
			-- Default cancel button. This is the button that
			-- is pushed if the user press the escape key or
			-- close the window using the close icon.
			-- If there is no default cancel button, the close
			-- icon is disabled.
		do
			Result := internal_default_cancel_button
		end

	current_push_button: detachable EV_BUTTON
			-- Currently focused push button.
			-- This is the button that is pushed when the user
			-- press the enter key when a push button is focused.
		do
			if internal_current_push_button /= Void then
				Result := internal_current_push_button
			else
				Result := internal_default_push_button
			end
		end

feature {EV_ANY, EV_ANY_I} -- Status Setting

	set_default_push_button (a_button: EV_BUTTON)
			-- Set the default push button to `a_button'.
			-- This is the button that is pushed if the user presses
			-- the enter key.
		require
			a_button_not_void: a_button /= Void
		do
			if internal_current_push_button = Void then
					-- No other button than `internal_default_push_button', if it is set,
					-- has the `is_default_push_button' flag.

					-- If we already had a default push button, we need to remove the
					-- `is_default_push_button' flag.
				if attached internal_default_push_button as l_internal_default_push_button then
					l_internal_default_push_button.disable_default_push_button
				end
					-- Now we set `a_button' with the `is_default_push_button' flag.
				a_button.enable_default_push_button
			else
					-- A button is already selected for being the current push button:
					-- nothing to be done here.
				check
					internal_default_push_button_disabled:
						attached internal_default_push_button as l_button implies
							not l_button.is_default_push_button
				end
			end
				-- Set the new `internal_default_push_button'.
			internal_default_push_button := a_button
		ensure
			default_push_button_set:
				default_push_button = a_button
		end

	remove_default_push_button
			-- Remove the default push button of this dialog.
		require
			has_default_push_button: default_push_button /= Void
		do
			if internal_current_push_button = Void then
					-- Simply remove `is_disable_default_push_button' status from our
					-- previous `default_push_button'.
				if attached internal_default_push_button as l_internal_default_push_button then
					l_internal_default_push_button.disable_default_push_button
				end
			else
				-- A button is already selected for being the current push button:
				-- nothing to be done here.
				check
					internal_default_push_button_disabled:
						attached internal_default_push_button as l_button and then not l_button.is_default_push_button
				end
			end
			internal_default_push_button := Void
		ensure
			not_has_default_push_button: default_push_button = Void
		end

	set_default_cancel_button (a_button: EV_BUTTON)
			-- Assign `a_button' to default_cancel_button.This is the button
			-- that is pushed if the user press the escape key or
			-- close the window using the close icon.
			-- If there is no default cancel button, the close
			-- icon is disabled.
		require
			a_button_not_void: a_button /= Void
		do
			internal_default_cancel_button := a_button
			enable_closeable
		ensure
			default_cancel_button_set:
				default_cancel_button = a_button
		end

	remove_default_cancel_button
			-- Remove the default cancel button of this dialog.
		require
			has_default_cancel_button: default_cancel_button /= Void
		do
			internal_default_cancel_button := Void
			disable_closeable
		ensure
			not_has_default_cancel_button: default_cancel_button = Void
		end

	enable_closeable
			-- Set the window to be closeable by the user.
		deferred
		ensure
			closeable: is_closeable
		end

	disable_closeable
			-- Set the window not to be closeable by the user.
		deferred
		ensure
			not_closeable: not is_closeable
		end

feature -- Basic operations

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show and wait until window is closed.
			-- `Current' is show modal with respect to `a_window'.
		deferred
		end

	show_relative_to_window (a_window: EV_WINDOW)
			-- Show `Current' with respect to `a_window'.
		deferred
		end

feature {EV_DIALOG} -- Implementation

	dialog_key_press_action (a_key: EV_KEY)
		local
			a_key_code: INTEGER
			l_app_i: detachable EV_APPLICATION_I
		do
				-- EV_KEY's may be void.
				--| If this behaviour is modified, then make sure to update
				--| the description in EV_DIALOG.
			check attached {EV_APPLICATION} ev_application as l_app then
				l_app_i := l_app.implementation
				check l_app_i_not_void: l_app_i /= Void end
				if a_key /= Void and l_app_i.captured_widget = Void and l_app_i.pick_and_drop_source = Void then
					a_key_code := a_key.code

					if a_key_code = {EV_KEY_CONSTANTS}.Key_escape and then
						attached default_cancel_button as l_default_cancel_button then
							-- We now check if `default_cancel_button' is sensitive
							-- as we only call its select_actions if it is sensitive.
						if l_default_cancel_button.is_sensitive then
								-- Escape key pressed and `default_cancel_button' is
								-- sensitive so simulate a press.
							l_default_cancel_button.select_actions.call (Void)
						end

					elseif a_key_code = {EV_KEY_CONSTANTS}.Key_enter and then
						attached current_push_button as l_current_push_button then
						if l_current_push_button.is_sensitive and not l_current_push_button.has_focus then
								-- Enter key pressed and `current_push_button' is
								-- sensitive so simulate a press, make sure it does not have focus as otherwise
								-- `select_actions' would be called twice.
							l_current_push_button.select_actions.call (Void)
						end
					end
				end
			end
		end

feature {EV_DIALOG, EV_DIALOG_I, EV_WIDGET_I} -- Implementation

	internal_default_push_button: detachable EV_BUTTON
			-- Default pushed button. This is the button that
			-- is pushed if the user pushes the enter key and
			-- if the widget that has the focus is not a push
			-- button.
			-- If the focused widget is a push button (it can
			-- be the default_push_button) it is pushed when
			-- the user presses the enter key.

	internal_default_cancel_button: detachable EV_BUTTON
			-- The default cancel button is the button pushed
			-- when the user press the escape key or close the
			-- window using the close icon.
			--
			-- If there is no default cancel button, the close
			-- icon is disabled.

	internal_current_push_button: detachable EV_BUTTON
			-- Current button pushed when the user press the enter
			-- key in the dialog.
			-- Void if none.

feature {EV_WIDGET_I} -- Implementation

	set_current_push_button (a_button: detachable EV_BUTTON)
			-- Set the push button to be `a_button'. `a_button' can
			-- be Void if there are no more current push button
		do
				-- Remove `is_default_push_button' status from either
				-- `internal_default_push_button' or `internal_current_push_button'.
			if attached current_push_button as l_current_push_button then
				l_current_push_button.disable_default_push_button
			end

				-- At this stage no button in Current dialog has the `is_default_push_button' flag.
			if a_button /= Void then
				if not a_button.is_default_push_button then
					a_button.enable_default_push_button
				end
				if a_button /= internal_default_push_button then
						-- Only set `internal_current_push_button' if `a_button'
						-- is different from `internal_default_push_button' as otherwise
						-- we would break the invariant.
					internal_current_push_button := a_button
				else
						-- Ensures the `internal_default_push_button_enabled' invariant
						-- so that only `a_button' is enabled
					internal_current_push_button := Void
				end
			else
				internal_current_push_button := Void
					-- If `internal_default_push_button' is set, then set its
					-- `is_default_push_button' flag.
				if attached internal_default_push_button as l_internal_default_push_button then
					l_internal_default_push_button.enable_default_push_button
				end
			end
		ensure
			current_push_button_set:
				(a_button = Void or else a_button /= internal_default_push_button) implies
					internal_current_push_button = a_button
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DIALOG note option: stable attribute end
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	internal_default_push_button_distinct_from_current_push_button:
		internal_default_push_button /= Void implies
			(internal_default_push_button /= internal_current_push_button)

	internal_current_push_button_distinct_from_default_push_button:
		internal_current_push_button /= Void implies
			(internal_current_push_button /= internal_default_push_button)

	internal_default_push_button_enabled:
		(attached internal_default_push_button as l_button and then l_button.is_default_push_button) implies
			internal_current_push_button = Void

	only_one_button_is_enabled:
		-- Only one button of Current has the `is_default_push_button' flag set.

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




end -- class EV_DIALOG_I











