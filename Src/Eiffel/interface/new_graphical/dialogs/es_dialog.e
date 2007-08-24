indexing
	description: "[
		A base dialog implementation for all dialogs resident in EiffelStudio.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	ES_DIALOG

inherit
	EB_RECYCLABLE

	ES_SHARED_DIALOG_BUTTONS

-- inherit {NONE}

	EV_BUILDER
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	ES_SHARED_COLORS
		export
			{NONE} all
		end

convert
	to_dialog: {EV_DIALOG}

feature {NONE} -- Initialization

	make
			-- Initialilze dialog
		local
			l_init: BOOLEAN
		do
			l_init := is_initializing
			is_initializing := True

			is_modal := True

			initialize
			build_interface

			dialog_result := buttons.first
			dialog.set_icon_pixmap (icon)
			dialog.key_press_actions.extend (agent on_key_pressed)
			dialog.key_release_actions.extend (agent on_key_release)
			dialog.show_actions.extend (agent show_actions.call ([]))

			is_initialized := True
			is_initializing := l_init
		ensure
			is_initialized: is_initialized
		end

	initialize
			-- Common initialization for any class attributes or other data structures.
			-- Note: No user interface initialization should be done here! Use `build_dialog_interface' instead
		do
			create show_actions
			create close_actions
			create button_actions.make_default
		end

feature {NONE} -- User interface initialization

	frozen build_interface
			-- Builds the dialog's user interface.
		require
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
		local
			l_main_container: EV_VERTICAL_BOX
			l_container: EV_VERTICAL_BOX
		do
			create l_main_container
			l_main_container.set_padding (0)
			l_main_container.set_border_width (0)

			create l_container
			l_container.set_border_width (dialog_border_width)
			l_main_container.extend (l_container)
			build_dialog_interface (l_container)
			dialog.show_actions.extend (agent adjust_dialog_button_widths)

 			create l_container
			l_container.set_border_width (dialog_border_width)
			l_main_container.extend (l_container)
			l_main_container.disable_item_expand (l_container)
			l_container.extend (create_dialog_button_ribbon)

			dialog.extend (l_main_container)

			dialog.set_icon_pixmap (icon.to_pixmap)
			dialog.set_title (title)
		ensure
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
			dialog_attached: dialog /= Void
		end

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		require
			a_container_attached: a_container /= Void
			not_a_container_is_destoryed: not a_container.is_destroyed
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
		deferred
		ensure
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
		end

feature {NONE} -- Clean up

	internal_recycle is
			-- To be called when the button has became useless.
		local
			l_buttons: DS_SET_CURSOR [INTEGER]
		do
			if is_initialized then
				l_buttons := buttons.new_cursor
				from l_buttons.start until l_buttons.after loop
					unbind_dialog_button (l_buttons.item, dialog_window_buttons.item (l_buttons.item))
					l_buttons.forth
				end

				dialog.key_press_actions.prune (agent on_key_pressed)
				dialog.key_release_actions.prune (agent on_key_release)
				dialog.show_actions.prune (agent show_actions.call ([]))

				button_actions.wipe_out

				dialog.destroy
				is_initialized := False
			end
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		deferred
		ensure
			result_attached: Result /= Void
		end

	title: STRING_32
			-- The dialog's title
		deferred
		ensure
			result_attached: Result /= Void
		end

	buttons: DS_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_valid_items: Result.for_all (agent dialog_buttons.is_valid_button_id)
		end

	default_button: INTEGER
			-- The dialog's default action button
		deferred
		end

	default_cancel_button: INTEGER
			-- The dialog's default cancel button
		deferred
		end

	dialog_result: INTEGER
			-- Dialog return code, when dialog has closed.
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.

feature {NONE} -- Access

	dialog: EV_DIALOG
			-- Actual dialog
		require
			not_is_recycled: not is_recycled
		do
			Result := internal_dialog
			if Result = Void then
				Result := create_dialog
				internal_dialog := Result
			end
		ensure
			result_attached: Result /= Void
			not_result_is_destroyed: not Result.is_destroyed
			result_consistent: Result = dialog
		end

	dialog_border_width: INTEGER
			-- Dialog border width
		do
			Result := {ES_UI_CONSTANTS}.dialog_border
		ensure
			result_non_negative: Result >= 0
		end

	frozen dialog_window_buttons: DS_HASH_TABLE [EV_BUTTON, INTEGER]
			-- Dialog window buttons indexed by a button id.
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		require
			not_is_recycled: not is_recycled
		do
			Result := internal_dialog_window_buttons
			if Result = Void then
				Result := create_dialog_window_buttons
				internal_dialog_window_buttons := Result
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_attached_items: not Result.has_item (Void)
			result_consistent: Result = dialog_window_buttons
		end

	frozen button_actions: DS_HASH_TABLE [like button_action, INTEGER]
			-- Dialog button actions

feature {NONE} -- Helpers

	frozen interface_names: INTERFACE_NAMES
			-- Access to EiffelStudio's interface names
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	frozen stock_pixmaps: ES_PIXMAPS_16X16
			-- Shared access to stock 16x16 EiffelStudio pixmaps
		once
			Result := (create {EB_SHARED_PIXMAPS}).icon_pixmaps
		ensure
			result_attached: Result /= Void
		end

	frozen preferences: EB_PREFERENCES
		require
			preferences_initialized: (create {EB_SHARED_PREFERENCES}).preferences_initialized
		once
			Result := (create {EB_SHARED_PREFERENCES}).preferences
		ensure
			result_attached: Result /= Void
		end

	frozen pixmap_factory: EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
			-- Factory for generating pixmaps for class data
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Element change

	set_button_text (a_id: INTEGER; a_text: STRING_32)
			-- Sets a buttons text, overriding the default.
			--
			-- `a_id': A button id corresponding to an actual dialog button.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
			-- `a_text': Text to change button text to.
		require
			not_is_recycled: not is_recycled
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			a_text_attached: a_text /= Void
			not_a_text_is_empty: not a_text.is_empty
			not_is_shown: not is_shown
		do
			dialog_window_buttons.item (a_id).set_text (a_text)
			if is_shown then
				adjust_dialog_button_widths
			end
		ensure
			button_text_set: dialog_window_buttons.item (a_id).text.is_equal (a_text)
		end

	set_button_action (a_id: INTEGER; a_action: PROCEDURE [ANY, TUPLE])
			-- Assigns an action to a specific button.
			--
			-- `a_id': A button id corresponding to an actual dialog button.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
			-- `a_action': An action to be performed when the button is pressed.
		require
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			buttons_contains_a_id: buttons.has (a_id)
			a_action_attached: a_action /= Void
		do
			button_actions.force (a_action, a_id)
		ensure
			button_action_set: button_action (a_id) = a_action
		end

feature -- Status report

	is_shown: BOOLEAN
			-- Indicates if dialog is current visible
		do
			Result := dialog.is_show_requested
		end

	is_modal: BOOLEAN assign set_is_modal
			-- Indicates if dialog is a modal dialog

feature -- Status setting

	set_is_modal (a_modal: BOOLEAN)
			-- Sets dialog's modal state to `a_modal'
		do
			is_modal := a_modal
		ensure
			is_modal_set: is_modal = a_modal
		end

feature {NONE} -- Status report

	is_initialized: BOOLEAN
			-- Indicates if the user interface has been initialized

	is_initializing: BOOLEAN
			-- Indicates if the user interface is currently being initialized

feature -- Query

	button_action (a_id: INTEGER): PROCEDURE [ANY, TUPLE]
			-- Button action for a specific button
			--
			-- `a_id': A button id corresponding to an actual dialog button.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
			-- `Result': An action to be performed when the button is pressed.
		require
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			buttons_contains_a_id: buttons.has (a_id)
		do
			if button_actions.has (a_id) then
				Result := button_actions.item (a_id)
			end
		end

feature {NONE} -- Query

	dialog_button_label (a_id: INTEGER): STRING_32
			-- Retrieves a dialog label for a button id
			--
			-- `a_id': A button id corresponding to an actual dialog button/
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
			-- `Result': A non-empty string
		require
			not_is_recycled: not is_recycled
			is_initializing: is_initializing
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
		do
			inspect a_id
			when {ES_DIALOG_BUTTONS}.ok_button then
				Result := interface_names.b_ok
			when {ES_DIALOG_BUTTONS}.cancel_button then
				Result := interface_names.b_cancel
			when {ES_DIALOG_BUTTONS}.yes_button then
				Result := interface_names.b_yes
			when {ES_DIALOG_BUTTONS}.no_button then
				Result := interface_names.b_no
			when {ES_DIALOG_BUTTONS}.abort_button then
				Result := interface_names.b_abort
			when {ES_DIALOG_BUTTONS}.retry_button then
				Result := interface_names.b_retry
			when {ES_DIALOG_BUTTONS}.ignore_button then
				Result := interface_names.b_ignore
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature -- Basic operations

	show (a_window: EV_WINDOW) is
			-- Show and wait until `Current' is closed.
			-- `Current' is shown modal with respect to `a_window'.
		require
			not_is_recycled: not is_recycled
			a_window_not_void: a_window /= Void
			a_window_not_current: a_window /= to_dialog
		do
			--adjust_dialog_button_widths
			if is_modal then
				dialog.show_modal_to_window (a_window)
			else
				dialog.show_relative_to_window (a_window)
			end
		ensure
				-- When a dialog is displayed modally, execution of code is
				-- halted until the dialog is closed or destroyed. Therefore,
				-- this postcondition will only be executed after the dialog
				-- is closed or destroyed.
			dialog_closed_so_no_blocking_window: not dialog.is_destroyed implies dialog.blocking_window = Void
		end

	show_on_development_window is
			-- Attempts to show the dialog parented to the last active window.
		require
			not_is_recycled: not is_recycled
		local
			l_shared_wm: EB_SHARED_WINDOW_MANAGER
			l_manager: EB_WINDOW_MANAGER
			l_window: EV_WINDOW
			l_dialog: EV_DIALOG
		do
			create l_shared_wm
			l_manager := l_shared_wm.window_manager
			if l_manager.has_active_development_windows then
					-- Attempt to grab best top-most window.
				l_window := l_manager.last_focused_window.window
				l_dialog ?= l_window
				if l_dialog = Void or else not l_dialog.has_focus then
					l_window := l_manager.last_focused_development_window.window
				end
			end

			if l_window /= Void then
				show (l_window)
			else
				--adjust_dialog_button_widths
				dialog.show
			end
		ensure
				-- When a dialog is displayed modally, execution of code is
				-- halted until the dialog is closed or destroyed. Therefore,
				-- this postcondition will only be executed after the dialog
				-- is closed or destroyed.
			dialog_closed_so_no_blocking_window: not dialog.is_destroyed implies dialog.blocking_window = Void
		end

feature {NONE} -- Basic operations

	bind_dialog_button (a_id: INTEGER; a_button: EV_BUTTON)
			-- Binds any other actions to a dialog button
			--
			-- `a_id': The button id corrsponding to an id returned from `buttons'.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
			-- `a_button': The button to bind any actions to.
		require
			not_is_recycled: not is_recycled
			is_initializing: is_initializing
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			buttons_has_a_id: buttons.has (a_id)
			a_button_attached: a_button /= Void
			not_a_button_is_destroyed: not a_button.is_destroyed
		do
		end

	unbind_dialog_button (a_id: INTEGER; a_button: EV_BUTTON)
			-- Uninds any other actions to a dialog button
			--
			-- `a_id': The button id corrsponding to an id returned from `buttons'.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
			-- `a_button': The button to unbind an bindings from.
		require
			is_initialized: is_initialized
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			buttons_has_a_id: buttons.has (a_id)
			a_button_attached: a_button /= Void
			not_a_button_is_destroyed: not a_button.is_destroyed
		do
		end

	adjust_dialog_button_widths
			-- Automatically adjusts dialog window button widths to fit the largest button text
		require
			dialog_window_buttons_attached: dialog_window_buttons /= Void
			not_dialog_window_buttons_is_empty: not dialog_window_buttons.is_empty
		local
			l_buttons: DS_HASH_TABLE_CURSOR [EV_BUTTON, INTEGER]
			l_button: EV_BUTTON
			l_min_width: INTEGER
			l_padding: INTEGER
		do
			l_min_width := {ES_UI_CONSTANTS}.dialog_button_width

				-- Determine minimum width
			l_buttons := dialog_window_buttons.new_cursor
			from l_buttons.start until l_buttons.after loop
				l_button := l_buttons.item
				check l_button_attached: l_button /= Void end

				if l_padding = 0 then
						-- Retrieve padding for buttons
					l_padding := l_button.minimum_width - l_button.font.string_width (l_button.text)
				end
				l_min_width := l_min_width.max (l_button.font.string_width (l_button.text) + l_padding)
				l_buttons.forth
			end

				-- Set min width
			from l_buttons.start until l_buttons.after loop
				l_button := l_buttons.item
				check l_button_attached: l_button /= Void end
				if l_min_width > l_button.minimum_width then
					l_button.reset_minimum_width
					l_button.set_minimum_width (l_min_width)
				end
				l_buttons.forth
			end
		end

feature -- Actions

	show_actions: EV_LITE_ACTION_SEQUENCE [TUPLE]
			-- Actions performed when the dialog is shown

	close_actions: EV_LITE_ACTION_SEQUENCE [TUPLE]
			-- Actions performed when the dialog is closed

feature {NONE} -- Action handlers

	on_dialog_button_pressed (a_id: INTEGER)
			-- Called when a dialog button is pressed
			--
			-- `a_id': A button id corrsponding to the button pressed.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		require
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			buttons_has_a_id: buttons.has (a_id)
		local
			l_action: like button_action
		do
			dialog_result := a_id
			l_action := button_action (a_id)
			if l_action /= Void then
				l_action.call ([])
			end
		end

	on_close_requested (a_id: INTEGER)
			-- Called when a dialog button is pressed and a close is requested.
			-- Note: Redefine to veto a close request.
			--
			-- `a_id': A button id corrsponding to the button pressed to close the dialog.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		require
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			buttons_has_a_id: buttons.has (a_id)
		do
			dialog.hide
			close_actions.call ([])
		end

	frozen on_key_pressed (a_key: EV_KEY)
			-- Called when the dialog recieves a key press
			--
			-- `a_key': The key pressed
		require
			a_key_attached: a_key /= Void
		local
			l_application: like ev_application
			l_handled: BOOLEAN
		do
			l_application := ev_application
			l_handled := on_handle_key (a_key, l_application.alt_pressed, l_application.ctrl_pressed, l_application.shift_pressed, False)
		end

	frozen on_key_release (a_key: EV_KEY)
			-- Called when the dialog recieves a key release
			--
			-- `a_key': The key pressed
		require
			a_key_attached: a_key /= Void
		local
			l_application: like ev_application
			l_handled: BOOLEAN
		do
			l_application := ev_application
			l_handled := on_handle_key (a_key, l_application.alt_pressed, l_application.ctrl_pressed, l_application.shift_pressed, True)
		end

	on_handle_key (a_key: EV_KEY; a_alt: BOOLEAN; a_ctrl: BOOLEAN; a_shift: BOOLEAN; a_released: BOOLEAN): BOOLEAN
			-- Called when the dialog recieve a key event
			--
			-- `a_key': The key pressed.
			-- `a_alt': True if the ALT key was pressed; False otherwise
			-- `a_ctrl': True if the CTRL key was pressed; False otherwise
			-- `a_shift': True if the SHIFT key was pressed; False otherwise
			-- `a_released': True if the key event pertains to the release of a key, False to indicate a press.
			-- `Result': True to indicate the key was handled
		require
			a_key_attached: a_key /= Void
		local
			l_button: EV_BUTTON
		do
			if a_released then
				if not a_alt and not a_ctrl and not a_shift then
					Result := True
					inspect a_key.code
					when {EV_KEY_CONSTANTS}.key_escape then
						dialog_result := default_cancel_button
						dialog.hide
					else
						Result := False
					end
				end

				if not Result and then a_ctrl and not a_alt and not a_shift then
					Result := True
					inspect a_key.code
					when {EV_KEY_CONSTANTS}.key_enter then
							-- Regular dialogs require CTRL+ENTER to exit
						l_button := dialog_window_buttons.item (default_button)
						if l_button /= Void then
							l_button.select_actions.call ([])
						end
					else
						Result := False
					end
				end
			end
		end

feature -- Conversion

	to_dialog: EV_DIALOG
			-- Converts Current to an actual EiffelVision2 dialog
		require
			not_is_recycled: not is_recycled
		do
			Result := dialog
		ensure
			result_attached: Result /= Void
			not_result_is_destroyed: not Result.is_destroyed
		end

feature {NONE} -- Factory

	create_dialog: EV_DIALOG
			-- Creates an implementation dialog
		require
			not_is_recycled: not is_recycled
			is_initializing: is_initializing
		do
			create Result
		ensure
			result_attached: Result /= Void
			not_result_is_destroyed: not Result.is_destroyed
		end

	create_dialog_button_ribbon: EV_CONTAINER
			-- Creates a container with all of the dialog buttons.
		require
			not_is_recycled: not is_recycled
			is_initializing: is_initializing
		local
			l_container: EV_HORIZONTAL_BOX
			l_buttons: like dialog_window_buttons
			l_button: EV_BUTTON
			l_ids: DS_SET_CURSOR [INTEGER]
		do
			create l_container
			l_container.set_padding ({ES_UI_CONSTANTS}.dialog_button_horizontal_padding)
			l_container.extend (create {EV_CELL})

				-- Add buttons in the order in which they were originally set.
			l_buttons := dialog_window_buttons
			l_ids := buttons.new_cursor
			from l_ids.start until l_ids.after loop
				l_button := l_buttons.item (l_ids.item)
				l_container.extend (l_button)
				l_container.disable_item_expand (l_button)
				l_ids.forth
			end

			Result := l_container
		ensure
			result_attached: Result /= Void
		end

	frozen create_dialog_window_buttons: DS_HASH_TABLE [EV_BUTTON, INTEGER]
			-- Creates the table of dialog buttons indexed by their id.
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		require
			not_is_recycled: not is_recycled
			is_initializing: is_initializing
		local
			l_buttons: DS_SET_CURSOR [INTEGER]
			l_button: EV_BUTTON
			l_id: INTEGER
		do
			create Result.make (3)
			l_buttons := buttons.new_cursor
			from l_buttons.start until l_buttons.after loop
				l_id := l_buttons.item

				l_button := create_dialog_button (l_id)
					-- Add close action
				l_button.select_actions.extend (agent on_close_requested (l_id))
					-- Add action to ensure the dialog result is set
				l_button.select_actions.extend (agent on_dialog_button_pressed (l_id))
					-- Bind other actions
				bind_dialog_button (l_id, l_button)

				Result.force (l_button, l_id)
				l_buttons.forth
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_contains_attached_items: not Result.has_item (Void)
		end

	create_dialog_button (a_id: INTEGER): EV_BUTTON
			-- Create a single dialog button for use on the dialog.
			--
			-- `a_id': A button id corresponding to an actual dialog button.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
			-- `Result': A non-empty string
		require
			not_is_recycled: not is_recycled
			is_initializing: is_initializing
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
		local
			l_label: STRING_32
		do
			l_label := dialog_button_label (a_id)
			create Result.make_with_text (l_label)
			Result.set_minimum_size ({ES_UI_CONSTANTS}.dialog_button_width, {ES_UI_CONSTANTS}.dialog_button_height)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Internal implementation cache

	internal_dialog: like dialog
			-- Cached version of `dialog'
			-- Note: Do not use directly.

	internal_dialog_window_buttons: like dialog_window_buttons
			-- Cached version of `dialog_buttons'
			-- Note: Do not use directly.

	internal_buttons: like buttons
			-- Cached version of `buttons'
			-- Note: Do not use directly.

invariant
	dialog_result_is_valid_button_id: buttons.has (dialog_result)
	default_button_is_valid_button_id: buttons.has (default_button)
	default_cancel_button_is_valid_button_id: dialog_buttons.default_cancel_buttons.has (default_cancel_button) and
		buttons.has (default_cancel_button)
	show_actions_attached: show_actions /= Void
	close_actions_attached: close_actions /= Void
	button_actions_attached: button_actions /= Void

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
