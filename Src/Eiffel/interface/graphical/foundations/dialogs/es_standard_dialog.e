note
	description: "[
		An ESF standard dialog, used in places of EiffelVision2 standard dialogs.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_STANDARD_DIALOG [G -> EV_STANDARD_DIALOG]

inherit
	ES_RECYCLABLE
		redefine
			internal_detach_entities
		end

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE} all
		end

	ES_SHARED_DIALOG_BUTTONS

feature {NONE} -- Initialization

	frozen make (a_title: !READABLE_STRING_GENERAL)
			-- Initialize a new standard dialog.
			--
			-- `a_title': The title to set on the standard dialog.
		require
			not_a_title_is_empty: not a_title.is_empty
		local
			l_init: BOOLEAN
		do
			l_init := is_initializing
			is_initializing := True

			on_before_initialize
			build_interface
			dialog.set_title (a_title.as_string_32)

			is_initialized := True
			is_initializing := l_init

			on_after_initialized
			reset
		ensure
			is_initialized: is_initialized
			is_initializing_unchanged: old is_initializing = is_initializing
		end

	frozen make_with_window (a_title: !READABLE_STRING_GENERAL; a_window: !like development_window)
			-- Initialize a new standard dialog assigned to a development window.
			--
			-- `a_title': The title to set on the standard dialog.
			-- `a_window': An assigned development window Current should be shown on.
		require
			not_a_title_is_empty: not a_title.is_empty
		do
			internal_development_window := a_window
			make (a_title)
		ensure
			is_initialized: is_initialized
			is_initializing_unchanged: old is_initializing = is_initializing
			internal_development_window_set: internal_development_window = a_window
		end

    on_before_initialize
            -- Use to perform additional creation initializations, before the UI has been created.
			--|Note: No user interface initialization should be done here! Use `build_dialog_interface' instead.
		require
			not_is_initialized: not is_initialized
		do
			create button_actions.make_default
        end

    on_after_initialized
            -- Performs additional initialization of the UI, after the widget structure has been created.
            --|Note: Here is it safe to perform operations on widgets created in `build_dialog_interface'.
        require
        	is_initialized: is_initialized
        do
        end

feature {NONE} -- User interface initialization

	frozen build_interface
			-- Builds the foundataion user interface.
		require
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
		do
			build_dialog_interface (dialog)
		ensure
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
		end

	build_dialog_interface (a_dialog: like dialog)
			-- Builds the foundataion standard dialog's user interface.
			--
			-- `a_dialog': The dialog to build the user interface for.
		require
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
			not_a_dialog_is_destroyed: not a_dialog.is_destroyed
		deferred
		ensure
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			button_actions.wipe_out
			if internal_dialog /= Void then
				internal_dialog.destroy
			end
			is_initialized := False
		ensure then
			button_actions_is_empty: button_actions.is_empty
			internal_dialog_is_destroyed: internal_dialog /= Void implies internal_dialog.is_destroyed
			not_is_initialized: not is_initialized
		end

	internal_detach_entities
			-- <Precursor>
		local
			l_default: G
		do
			Precursor
			internal_dialog := l_default
			internal_development_window := Void
		ensure then
			internal_development_window_detached: internal_development_window = Void
		end

feature -- Access

	dialog: !G
			-- Actual dialog.
		local
			l_result: like internal_dialog
		do
			l_result := internal_dialog
			if l_result = Void then
				Result := new_dialog
				internal_dialog := Result
			else
				Result := l_result
			end
		ensure
			result_consistent: Result = dialog
		end

	buttons: !DS_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
			result_contains_valid_items: Result.for_all (agent dialog_buttons.is_valid_button_id)
			has_confirmation_button: Result.there_exists (agent (ia_id: INTEGER): BOOLEAN
				do
					Result := (ia_id & dialog_buttons.ok_button) = dialog_buttons.ok_button
				end)
			has_cancel_button: Result.there_exists (agent (ia_id: INTEGER): BOOLEAN
				do
					Result := ia_id = dialog_buttons.cancel_button
				end)
		end

	dialog_result: INTEGER
			-- Dialog return code, when dialog has closed.
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.

feature {NONE} -- Access

	development_window: EB_DEVELOPMENT_WINDOW
			-- The development window the dialog is to be display on or at leasted utilized with.
		require
			is_interface_usable: is_interface_usable
			is_initialized: internal_development_window /= Void or else (is_initialized or is_initializing)
		local
			l_result: like internal_development_window
			l_window: EV_WINDOW
			l_windows: BILINEAR [EB_WINDOW]
			l_wm: ?EB_WINDOW_MANAGER
		do
			l_result := internal_development_window
			if l_result = Void then
				l_window := dialog.blocking_window
				if l_window /= Void then
					l_window := helpers.widget_top_level_window (l_window, True)
				end
				if l_window /= Void then
						-- Attempt to find matching top level window.
					l_windows := (create {EB_SHARED_WINDOW_MANAGER}).window_manager.windows
					from l_windows.start until l_windows.after or l_result /= Void loop
						if l_window = l_windows.item.window and then {l_result_window: EB_DEVELOPMENT_WINDOW} l_windows.item then
							l_result := l_result_window
						end
						l_windows.forth
					end
				else
					l_wm := (create {EB_SHARED_WINDOW_MANAGER}).window_manager
					if l_wm /= Void then
						l_result := l_wm.last_focused_development_window
					end
				end
			end
			Result := l_result
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	frozen button_actions: !DS_HASH_TABLE [PROCEDURE [ANY, TUPLE], INTEGER]
			-- Dialog button actions.

feature -- Element change

	set_button_action (a_id: INTEGER; a_action: PROCEDURE [ANY, TUPLE])
			-- Assigns an action to a specific button.
			--
			-- `a_id': A button id corresponding to an actual dialog button.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
			-- `a_action': An action to be performed when the button is pressed.
		require
			is_interface_usable: is_interface_usable
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			buttons_contains_a_id: buttons.has (a_id)
			a_action_attached: a_action /= Void
		do
			button_actions.force (a_action, a_id)
		ensure
			button_action_set: button_action (a_id) = a_action
		end

feature -- Status report

	is_initialized: BOOLEAN
			-- Indicates if the user interface has been initialized

	is_confirmed: BOOLEAN
			-- Indicates if the dialog operation was confirmed (Ok or similar pressed).
		local
			l_buttons: like dialog_buttons
		do
			l_buttons := dialog_buttons
			Result := (dialog_result & l_buttons.ok_button) = l_buttons.ok_button
		ensure
			dialog_ok_button_pressed: Result implies (dialog_result & dialog_buttons.ok_button) = dialog_buttons.ok_button
		end

feature {NONE} -- Status report

	is_initializing: BOOLEAN
			-- Indicates if the user interface is currently being initialized

feature -- Query

	button_action (a_id: INTEGER): ?PROCEDURE [ANY, TUPLE]
			-- Button action for a specific button.
			--
			-- `a_id': A button id corresponding to an actual dialog button.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
			-- `Result': An action to be performed when the button is pressed.
		require
			is_interface_usable: is_interface_usable
			buttons_contains_a_id: buttons.has (a_id)
		do
			if button_actions.has (a_id) then
				Result := button_actions.item (a_id)
			end
		end

feature {NONE} -- Query

	button_from_dialog_selected_button (a_dialog: !G): INTEGER
			-- Retrieves a corresponding button ID from the actual dialog
		require
			is_interface_usable: is_interface_usable
			a_dialog_closed: a_dialog.blocking_window = Void
		deferred
		ensure
			result_is_valid_button_id: dialog_buttons.is_valid_button_id (Result)
			buttons_contains_result: buttons.has (Result)
		end

feature {NONE} -- Helpers

	frozen helpers: !EVS_HELPERS
			-- Helpers to extend the operations of EiffelVision2
		once
			create Result
		end

feature -- Basic operations

	show (a_window: !EV_WINDOW)
			-- Show the standard dialog on a designated window.
			--
			-- `a_window': The window to show the dialog modal to.
		require
			is_interface_usable: is_interface_usable
			not_a_window_is_destoryed: not a_window.is_destroyed
		do
			on_before_shown
			dialog.show_modal_to_window (a_window)
			on_closed
		end

	show_on_active_window
			-- Show the standard dialog on the determined active window.
		require
			is_interface_usable: is_interface_usable
		local
			l_dev_window: like development_window
			l_window: EV_WINDOW
		do
			l_window := helpers.parent_window_of_focused_widget
			if l_window = Void then
				l_dev_window := development_window
				if l_dev_window /= Void then
					l_window := l_dev_window.window
				end
			end

			check l_window_attached: l_window /= Void end
			show (l_window)
		end

feature {NONE} -- Basic operation

	reset
			-- Resets current's state, removing and cached data
		do
			dialog_result := 0
		ensure
			not_is_confirmed: not is_confirmed
		end

feature {NONE} -- Action handlers

	on_before_shown
			-- Called prior to the dialog being shown.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			dialog_result := 0
		ensure
			dialog_result_reset: dialog_result = 0
		end

	on_closed
			-- Called when the dialog is closed
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_id: INTEGER
		do
				-- Retrieve the id corresponding to the selected button and process the action.
			l_id := button_from_dialog_selected_button (dialog)
			on_dialog_button_pressed (l_id)
		end

	on_confirm: BOOLEAN
			-- Called when the user slsected the confirm button.
			--
			-- `Result': True to indicate any post-confirmation action was processed correctly; False
			--           otherwise.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			Result := True
		end

	on_cancel
			-- Called when the user slsected the confirm button.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
		end

	on_dialog_button_pressed (a_id: INTEGER)
			-- Called when a dialog button is pressed
			--
			-- `a_id': A button id corrsponding to the button pressed.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			buttons_has_a_id: buttons.has (a_id)
		local
			l_buttons: like dialog_buttons
			l_action: like button_action
			l_id: INTEGER
		do
			l_buttons := dialog_buttons
			l_id := a_id
			dialog_result := a_id
			if (l_id & l_buttons.ok_button) = l_buttons.ok_button then
				if not on_confirm then
						-- Confirmation failed, the dialog should be considered cancelled.
					l_id := l_buttons.cancel_button
					dialog_result := l_id
				end
			end
			if l_id = l_buttons.cancel_button then
				on_cancel
			end
			l_action := button_action (l_id)
			if l_action /= Void then
				l_action.call (Void)
			end
		end

feature {NONE} -- Factory

	new_dialog: !G
			-- Creates a new file dialog
		deferred
		ensure
			not_result_is_destroyed: not Result.is_destroyed
		end

feature {NONE} -- Implementation: Internal cache

	internal_development_window: ?like development_window
			-- Set version of `development_window'.
			-- Note: Used during creation to indicate an assigned window.

	internal_dialog: ?like dialog
			-- Cached version of `dialog'.
			-- Note: Do not use directly!

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
