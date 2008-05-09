indexing
	description: "[
		A base dialog implementation for all dialogs resident in EiffelStudio.
		
		Note: Dialogs a becoming quite complex. As of 6.2 the dialogs now use the session manager service ({SESSION_MANAGER_S})
		      to store size/position information. This can be vetoed by redefining `is_size_and_position_remembered' to return False.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision: \$"

deferred class
	ES_DIALOG

inherit
	ES_WINDOW_FOUNDATIONS
		rename
			foundation_window as dialog
		redefine
			internal_recycle,
			on_before_initialize,
			on_after_initialized,
			on_handle_key
		end

	ES_SHARED_DIALOG_BUTTONS

	ES_HELP_REQUEST_BINDER
		export
			{NONE} all
		end

convert
	dialog: {EV_DIALOG}

feature {NONE} -- Initialization

	make_with_window (a_window: like development_window)
			-- Initialize dialog using a specific development window
		require
			a_window_attached: a_window /= Void
			a_window_is_interface_usable: a_window.is_interface_usable
		do
			internal_development_window := a_window
			make
		ensure
			development_window_set: development_window = a_window
		end

    on_before_initialize
            -- Use to perform additional creation initializations, before the UI has been created.
			-- Note: No user interface initialization should be done here! Use `build_dialog_interface' instead
		do
				-- Create action lists
			create show_actions
			create hide_actions
			create button_actions.make_default

			is_modal := True
			is_confirmation_key_active := True
			dialog_result := default_button

			Precursor {ES_WINDOW_FOUNDATIONS}
        end

    on_after_initialized
            -- <Precursor>
        local
        	l_sp_info: TUPLE [x, y, width, height: INTEGER]
        	l_screen: SD_SCREEN
        	l_titled_window: EV_WINDOW_ACTION_SEQUENCES
        do
			dialog.set_icon_pixmap (icon)

   				-- Remove key actions to prevent the ENTER and ESC from being processed by EV_DIALOG.
			dialog.key_press_actions.wipe_out
				-- Because the key actions are removed (or even if a default key handler is set) the close button
				-- will be inactive because of the way EV_DIALOG was implemented.
				-- As a result we must access the close request actions of the window to perform the proper close.
			l_titled_window := dialog
			register_action (l_titled_window.close_request_actions, agent on_cancel_dialog)
			register_action (dialog.show_actions, agent show_actions.call (Void))

			Precursor {ES_WINDOW_FOUNDATIONS}

       		bind_help_shortcut (dialog)

			if is_size_and_position_remembered then
	       		if session_manager.is_service_available then

	       				-- Retrieve persisted session data size/position information
	       			l_sp_info ?= session_data.value (dialog_session_id)
	       			if l_sp_info /= Void then
	       					-- Previous session data is available
	       				create l_screen
-- Currently the saved position is not used because it should be saved relative to the parent window.
--	       				if (l_sp_info.x >= 0 and then l_sp_info.x < l_screen.virtual_width) and (l_sp_info.y >= 0 and then l_sp_info.y < l_screen.virtual_height) then
--	       						-- Ensure dialog is not off-screen
--	       					dialog.set_position (l_sp_info.x, l_sp_info.y)
--	       				end
	       				dialog.set_size (l_sp_info.width, l_sp_info.height)
	       			end

	       				-- Hook up close action to store session size/position data
	       			register_action (hide_actions, (agent (a_ia_session: SESSION_I)
	       				do
	       					if is_size_and_position_remembered then
	       							-- Only persist data if a cancel button wasn't selected
		       					if a_ia_session.is_interface_usable then
		       							-- Store session data
									a_ia_session.set_value ([dialog.x_position.max (0), dialog.y_position.max (0), dialog.width, dialog.height], dialog_session_id)
		       					end
	       					end
	       				end (session_data)))
	       		end
			end
        end

feature {NONE} -- User interface initialization

	frozen build_interface
			-- Builds the dialog's user interface.
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

 			create l_container
			l_container.set_border_width (dialog_button_border_width)
			l_main_container.extend (l_container)
			l_main_container.disable_item_expand (l_container)
			l_container.extend (create_dialog_button_ribbon)

			dialog.extend (l_main_container)

			dialog.set_icon_pixmap (icon.to_pixmap)
			dialog.set_title (title)
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

	internal_recycle
			-- To be called when the button has became useless.
		local
			l_buttons: DS_SET_CURSOR [INTEGER]
			l_recycled: BOOLEAN
		do
			if is_initialized then
				l_recycled := is_recycled

					-- We are not recycled yet!
				is_recycled := False
				l_buttons := buttons.new_cursor
				from l_buttons.start until l_buttons.after loop
					unbind_dialog_button (l_buttons.item, dialog_window_buttons.item (l_buttons.item))
					l_buttons.forth
				end

				button_actions.wipe_out

				if internal_dialog /= Void and then not internal_dialog.is_destroyed then
					internal_dialog.hide
					internal_dialog.destroy
				end
				is_recycled := l_recycled
			end

			Precursor {ES_WINDOW_FOUNDATIONS}
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		require
			is_interface_usable: is_interface_usable
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

	dialog: EV_DIALOG
			-- Actual dialog
		do
			Result := internal_dialog
			if Result = Void then
				Result := create_dialog
				internal_dialog := Result
			end
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
		ensure
			buttons_contains_result: buttons.has (Result)
		end

	default_confirm_button: INTEGER
			-- The dialog's default confirm button
		deferred
		ensure
			buttons_contains_result: buttons.has (Result)
		end

	default_cancel_button: INTEGER
			-- The dialog's default cancel button
			-- Note: The default cancel button is set on show, so if you want to change the
			--       default cancel button after the dialog has been shown, please see the implmentation
			--       of `show' to see how it is done.
		deferred
		ensure
			buttons_contains_result: buttons.has (Result)
		end

	dialog_result: INTEGER
			-- Dialog return code, when dialog has closed.
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.

feature {NONE} -- Access

	development_window: EB_DEVELOPMENT_WINDOW
			-- Access to top-level parent window
		require
			is_interface_usable: is_interface_usable
			is_initialized: internal_development_window /= Void or else (is_initialized or is_initializing)
		local
			l_window: EV_WINDOW
			l_windows: BILINEAR [EB_WINDOW]
		do
			Result := internal_development_window
			if Result = Void then
				if is_modal then
					l_window := dialog.blocking_window
					if l_window /= Void then
						l_window := helpers.widget_top_level_window (l_window, True)
					end
				end
				if l_window /= Void then
						-- Attempt to find matching top level window.
					l_windows := (create {EB_SHARED_WINDOW_MANAGER}).window_manager.windows
					from l_windows.start until l_windows.after or Result /= Void loop
						if l_window = l_windows.item.window then
							Result ?= l_windows.item
						end
						l_windows.forth
					end
				else
					Result := (create {EB_SHARED_WINDOW_MANAGER}).window_manager.last_focused_development_window
				end
			end
		ensure
			not_result_is_recycled: Result /= Void implies not Result.is_recycled
		end

	dialog_border_width: INTEGER
			-- Dialog border width
		do
			Result := {ES_UI_CONSTANTS}.dialog_border
		ensure
			result_non_negative: Result >= 0
		end

	dialog_button_border_width: INTEGER
			-- Dialog border width for buttons
		do
			Result := {ES_UI_CONSTANTS}.dialog_border
		ensure
			result_non_negative: Result >= 0
		end

	frozen dialog_window_buttons: DS_HASH_TABLE [EV_BUTTON, INTEGER]
			-- Dialog window buttons indexed by a button id.
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		require
			is_interface_usable: is_interface_usable
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

	frozen button_actions: DS_HASH_TABLE [TUPLE [action: like button_action; before_close: BOOLEAN], INTEGER]
			-- Dialog button actions

	dialog_session_id: !STRING_8
			-- Dialog session ID for storing size/position information
		require
			is_interface_usable: is_interface_usable
		do
			create Result.make_from_string (generating_type)
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Element change

	set_button_text (a_id: INTEGER; a_text: STRING_32)
			-- Sets a buttons text, overriding the default.
			--
			-- `a_id': A button id corresponding to an actual dialog button.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
			-- `a_text': Text to change button text to.
		require
			is_interface_usable: is_interface_usable
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			a_text_attached: a_text /= Void
			not_a_text_is_empty: not a_text.is_empty
			not_is_shown: not is_shown
		local
			l_old_text: STRING_32
			l_button: EV_BUTTON
		do
			l_button := dialog_window_buttons.item (a_id)
			l_old_text := l_button.text
			if l_old_text = Void or else not l_old_text.is_equal (a_text) then
				l_button.set_text (a_text)
				if is_shown then
					adjust_dialog_button_widths
				end
			end
		ensure
			button_text_set: dialog_window_buttons.item (a_id).text.is_equal (a_text)
		end

	set_button_icon (a_id: INTEGER; a_icon: EV_PIXMAP)
			-- Sets a buttons text, overriding the default.
			--
			-- `a_id': A button id corresponding to an actual dialog button.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
			-- `a_icon': Icon to set on the button
		require
			is_interface_usable: is_interface_usable
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			a_icon_attached: a_icon /= Void
			not_a_text_is_destroyed: not a_icon.is_destroyed
			not_is_shown: not is_shown
		local
			l_button: EV_BUTTON
		do
			l_button := dialog_window_buttons.item (a_id)
			if a_icon /= l_button.pixmap then
				if a_icon = Void then
					l_button.remove_pixmap
				else
					l_button.set_pixmap (a_icon)
				end
				if is_shown then
					adjust_dialog_button_widths
				end
			end
		end

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
			button_actions.force ([a_action, False], a_id)
		ensure
			button_action_set: button_action (a_id) = a_action
		end

	set_button_action_before_close (a_id: INTEGER; a_action: PROCEDURE [ANY, TUPLE])
			-- Assigns an action to a specific button to be called prior to closing.
			-- Note: This routine can use `veto_close' to prevent the dialog from being closed.
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
			button_actions.force ([a_action, True], a_id)
		ensure
			button_action_set: button_action_before_close (a_id) = a_action
		end

feature -- Status report

	is_modal: BOOLEAN assign set_is_modal
			-- Indicates if dialog is a modal dialog

feature {NONE} -- Status report

	is_close_vetoed: BOOLEAN
			-- Indicates if the dialog's shutdown has been vetoed
			-- Note: See `veto_close' for more information

	is_recycled_on_closing: BOOLEAN
			-- Indicates if the dialog should be recycled on closing.
		do
			Result := True
		end

	is_size_and_position_remembered: BOOLEAN
			-- Indicates if the size and position information is remembered for the dialog
		do
			Result := session_manager.is_service_available
		end

	is_confirmation_key_active: BOOLEAN
			-- Indicates if the dialog can be closed using the ENTER key.
			-- Note: Register non-enter closing widget using `suppress_confirmation_key_close'

feature -- Status setting

	set_is_modal (a_modal: BOOLEAN)
			-- Sets dialog's modal state to `a_modal'
		require
			is_interface_usable: is_interface_usable
			not_is_shown: not is_shown
		do
			is_modal := a_modal
		ensure
			is_modal_set: is_modal = a_modal
		end

feature {NONE} -- Status setting

	suppress_confirmation_key_close (a_widget: EV_WIDGET)
			-- Suppresses a widget's ability to close a dialog using the default confirmation key.
			--
			-- `a_widget': A widget that when has focus, should supress the dialog from closing
			--             when the confirmation key is used.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized or is_initializing
			a_widget_attached: a_widget /= Void
			not_a_widget_is_destroyed: not a_widget.is_destroyed
		local
			l_recycler: EB_RECYCLABLE
		do
			l_recycler ?= a_widget
			if l_recycler = Void then
				l_recycler := Current
			end
			check l_recycler_attached: l_recycler /= Void end

			l_recycler.register_action (a_widget.focus_in_actions, agent
					-- Called when the widget is focused to prevent the dialog from closing when the confirmation key is pressed.
				do
					if is_interface_usable and is_shown then
						is_confirmation_key_active := False
						if dialog.default_push_button /= Void then
							dialog.remove_default_push_button
						end
					end
				end)

			l_recycler.register_action (a_widget.focus_out_actions, agent
					-- Called when the widget unfocused to resume the dialog closing when the confirmation key is pressed.
				do
					if is_interface_usable and is_shown then
						is_confirmation_key_active := True
						dialog.set_default_push_button (dialog_window_buttons.item (default_button))
					end
				end)
		end

feature -- Query

	button_action (a_id: INTEGER): PROCEDURE [ANY, TUPLE]
			-- Button action, called after the dialog is closed, for a specific button.
			--
			-- `a_id': A button id corresponding to an actual dialog button.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
			-- `Result': An action to be performed when the button is pressed.
		require
			is_interface_usable: is_interface_usable
			buttons_contains_a_id: buttons.has (a_id)
		local
			l_action: TUPLE [action: PROCEDURE [ANY, TUPLE]; on_close: BOOLEAN]
		do
			if button_actions.has (a_id) then
				l_action := button_actions.item (a_id)
				if l_action /= Void and then l_action.on_close = False then
					Result := l_action.action
				end
			end
		end

	button_action_before_close (a_id: INTEGER): PROCEDURE [ANY, TUPLE]
			-- Button action, called before the dialog is closed, for a specific button.
			--
			-- `a_id': A button id corresponding to an actual dialog button.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
			-- `Result': An action to be performed when the button is pressed.
		require
			is_interface_usable: is_interface_usable
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			buttons_contains_a_id: buttons.has (a_id)
		local
			l_action: TUPLE [action: PROCEDURE [ANY, TUPLE]; on_close: BOOLEAN]
		do
			if button_actions.has (a_id) then
				l_action := button_actions.item (a_id)
				if l_action /= Void and then l_action.on_close = True then
					Result := l_action.action
				end
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
			is_interface_usable: is_interface_usable
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
			when {ES_DIALOG_BUTTONS}.close_button then
				Result := interface_names.b_close
			when {ES_DIALOG_BUTTONS}.reset_button then
				Result := interface_names.b_reset
			when {ES_DIALOG_BUTTONS}.apply_button then
				Result := interface_names.b_apply
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature {NONE} -- Helpers

	frozen pixmap_factory: EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
			-- Factory for generating pixmaps for class data
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Basic operations

	show (a_window: EV_WINDOW)
			-- Show and wait until `Current' is closed.
			-- `Current' is shown modal with respect to `a_window'.
		require
			is_interface_usable: is_interface_usable
			a_window_not_void: a_window /= Void
			not_a_window_is_destoryed: not a_window.is_destroyed
			a_window_not_current: a_window /= dialog
		do
			is_confirmation_key_active := True
			on_before_show
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
			--dialog_closed_so_no_blocking_window: not dialog.is_destroyed implies dialog.blocking_window = Void
		end

	show_on_active_window
			-- Attempts to show the dialog parented to the last active window.
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

			if l_window /= Void then
				show (l_window)
			else
				on_before_show
				dialog.show
			end
		ensure
				-- When a dialog is displayed modally, execution of code is
				-- halted until the dialog is closed or destroyed. Therefore,
				-- this postcondition will only be executed after the dialog
				-- is closed or destroyed.
			--dialog_closed_so_no_blocking_window: not dialog.is_destroyed implies dialog.blocking_window = Void
		end

feature {NONE} -- Basic operation

	bind_dialog_button (a_id: INTEGER; a_button: EV_BUTTON)
			-- Binds any other actions to a dialog button
			--
			-- `a_id': The button id corrsponding to an id returned from `buttons'.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
			-- `a_button': The button to bind any actions to.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized or is_initializing
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
			is_initialized: is_initialized or is_initializing
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			buttons_has_a_id: buttons.has (a_id)
			a_button_attached: a_button /= Void
			not_a_button_is_destroyed: not a_button.is_destroyed
		do
		end

	veto_close
			-- Ensures dialog is not closed as a result of a button action.
			-- Note: This routine should be called in a registered button action.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			is_close_vetoed := True
		ensure
			is_close_vetoed: is_close_vetoed
		end

	adjust_dialog_button_widths
			-- Automatically adjusts dialog window button widths to fit the largest button text
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized or is_initializing
			dialog_window_buttons_attached: dialog_window_buttons /= Void
			not_dialog_window_buttons_is_empty: not dialog_window_buttons.is_empty
		local
			l_padding_button: EV_BUTTON
			l_buttons: DS_HASH_TABLE_CURSOR [EV_BUTTON, INTEGER]
			l_button: EV_BUTTON
			l_min_width: INTEGER
			l_padding: INTEGER
			l_allow_resize: BOOLEAN
		do
				-- HACK: We have to allow user resizing in order for the buttons to be resized correctly
				-- as well as the padding cell. If this code is removed the buttons are resized but incorrectly placed.
			l_allow_resize := dialog.user_can_resize
			if not l_allow_resize then
				dialog.enable_user_resize
			end

			l_min_width := {ES_UI_CONSTANTS}.dialog_button_width

				-- Retrieve padding for buttons
			create l_padding_button
			l_padding_button.set_text ("dummy")
			l_padding := l_padding_button.minimum_width - l_padding_button.font.string_width ("dummy")

				-- Determine minimum width
			l_buttons := dialog_window_buttons.new_cursor
			from l_buttons.start until l_buttons.after loop
				l_button := l_buttons.item
				check l_button_attached: l_button /= Void end
				if l_button.pixmap = Void then
					l_min_width := l_min_width.max (l_button.font.string_width (l_button.text) + l_padding)
				else
						-- Account for icon width, plus extra for style
					l_min_width := l_min_width.max (l_button.font.string_width (l_button.text) + l_padding + l_button.pixmap.width + 10)
				end

				l_buttons.forth
			end

				-- Set min width
			from l_buttons.start until l_buttons.after loop
				l_button := l_buttons.item
				check l_button_attached: l_button /= Void end
				if l_min_width > l_button.minimum_width then
					l_button.set_minimum_width (l_min_width)
				end
				l_buttons.forth
			end

			if not l_allow_resize then
				dialog.disable_user_resize
			end
		end

feature -- Actions

	frozen show_actions: !EV_LITE_ACTION_SEQUENCE [TUPLE]
			-- Actions performed when the window is shown

	frozen hide_actions: !EV_LITE_ACTION_SEQUENCE [TUPLE]
			-- Actions performed when the window is hided

feature {NONE} -- Action handlers

	on_before_show
			-- Called prior to the dialog being shown
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized or is_initializing
		do
			adjust_dialog_button_widths
			dialog.set_default_cancel_button (dialog_window_buttons.item (default_cancel_button))
			dialog.set_default_push_button (dialog_window_buttons.item (default_button))
		end

	on_close_requested (a_id: INTEGER)
			-- Called when a dialog button is pressed and a close is requested.
			-- Note: Redefine to veto a close request.
			--
			-- `a_id': A button id corrsponding to the button pressed to close the dialog.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			buttons_has_a_id: buttons.has (a_id)
			not_is_close_vetoed: not is_close_vetoed
		do
			dialog.hide
			hide_actions.call (Void)
		ensure
			not_is_close_vetoed: not is_close_vetoed
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
			l_action: like button_action
		do
			dialog_result := a_id
			l_action := button_action_before_close (a_id)
			if l_action /= Void then
				l_action.call (Void)
			end
			if not is_close_vetoed then
				l_action := button_action (a_id)
				on_close_requested (a_id)
				if l_action /= Void then
					l_action.call (Void)
				end
			end
			is_close_vetoed := False
		ensure
			not_is_close_vetoed: not is_close_vetoed
		end

	on_confirm_dialog
			-- Called when the user presses CTRL+ENTER to discard the dialog
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			on_dialog_button_pressed (default_confirm_button)
		end

	on_cancel_dialog
			-- Called when the user presses ESC
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			on_dialog_button_pressed (default_cancel_button)
		end

	on_reset_dialog_size_and_position
			-- Called when the user presses CTRL+F12 to reset the size and position information for the dialog
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			is_size_and_position_remembered: is_size_and_position_remembered
		local
			l_window: EV_WINDOW
			l_width: INTEGER
			l_height: INTEGER
		do
			l_width := dialog.minimum_width
			l_height := dialog.minimum_height

			l_window := dialog.blocking_window
			if l_window /= Void then
				dialog.set_position (l_window.x_position + ((l_window.width - l_width) / 2).floor, l_window.y_position + ((l_window.height - l_height) / 2).floor)
			end

			dialog.set_size (l_width, l_height)
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
		do
			if a_released then
				if a_ctrl and not a_alt and not a_shift then
					inspect a_key.code
					when {EV_KEY_CONSTANTS}.key_f12 then
						if is_size_and_position_remembered then
							on_reset_dialog_size_and_position
							Result := True
						end
					else
					end
				end
			else
				if not a_alt and not a_ctrl and not a_shift then
					inspect a_key.code
					when {EV_KEY_CONSTANTS}.key_escape then
						on_cancel_dialog
						Result := True
					else
					end
				elseif not Result and not a_alt and not a_shift and then (is_confirmation_key_active or a_ctrl) and a_key.code = {EV_KEY_CONSTANTS}.key_enter then
					if a_ctrl or else ({l_widget: !EV_WIDGET} ev_application.focused_widget and then not {l_button: !EV_BUTTON} l_widget) then
							-- We check if the focus widget is Void, because if it is then, technically the dialog does not have focus.
							-- The key processing will stil be effective if there is no focused widget, which could be a bug.
						on_confirm_dialog
					end
					Result := True
				end
			end

			if not Result and then is_interface_usable then
				Result := Precursor {ES_WINDOW_FOUNDATIONS} (a_key, a_alt, a_ctrl, a_shift, a_released)
			end
		end

feature {NONE} -- Factory

	create_dialog: EV_DIALOG
			-- Creates an implementation dialog
		require
			is_interface_usable: is_interface_usable
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
			is_interface_usable: is_interface_usable
			is_initializing: is_initializing
		local
			l_container: EV_HORIZONTAL_BOX
			l_tool_bar: SD_TOOL_BAR
			l_buttons: like dialog_window_buttons
			l_button: EV_BUTTON
			l_ids: DS_SET_CURSOR [INTEGER]
		do
			create l_container
			l_container.set_padding ({ES_UI_CONSTANTS}.dialog_button_horizontal_padding)

			if help_providers.is_service_available then
					-- Add a help button, if help is available
				if {l_help_context: !HELP_CONTEXT_I} Current and then l_help_context.is_help_available then
					create l_tool_bar.make
					l_tool_bar.extend (create_help_button)
					l_tool_bar.compute_minimum_size
					l_container.extend (l_tool_bar)
					l_container.disable_item_expand (l_tool_bar)
				end
			end

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
			is_interface_usable: is_interface_usable
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
					-- Add action to ensure the dialog result is set
				register_action (l_button.select_actions, agent on_dialog_button_pressed (l_id))
					-- Bind other actions
				bind_dialog_button (l_id, l_button)
				if is_recycled_on_closing then
						-- Process automatic recycling
					register_action (l_button.select_actions, agent do if not is_shown then recycle end end)
				end

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
			is_interface_usable: is_interface_usable
			is_initializing: is_initializing
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
		do
			create Result.make_with_text (dialog_button_label (a_id))
		ensure
			result_attached: Result /= Void
		end

	create_help_button: SD_TOOL_BAR_BUTTON
			-- Creates a help widget for use in the dialog button ribbon for recieving help
		require
			is_interface_usable: is_interface_usable
			is_initializing: is_initializing
			help_providers_is_service_available: help_providers.is_service_available
		local
			l_enable_help: BOOLEAN
		do
			create Result.make
			Result.set_pixel_buffer (stock_pixmaps.command_system_info_icon_buffer)
			Result.set_pixmap (stock_pixmaps.command_system_info_icon)

			l_enable_help := True
			if {l_context: !HELP_CONTEXT_I} Current then
				l_enable_help := l_context.is_interface_usable and then help_providers.service.is_provider_available (l_context.help_provider)
			end

			if l_enable_help then
				Result.set_tooltip (interface_names.e_show_help)

					-- Set click action
				register_action (Result.select_actions, agent show_help)
			else
				Result.disable_sensitive
				Result.set_tooltip (interface_names.e_show_help_unavailable)
			end
		ensure
			not_result_is_destroyed: Result /= Void implies not Result.is_destroyed
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

	internal_development_window: like development_window
			-- Mutable version of `development_window'

invariant
	dialog_result_is_valid_button_id: buttons.has (dialog_result)
	default_button_is_valid_button_id: buttons.has (default_button)
	default_confirm_button_is_valid_button_id: buttons.has (default_confirm_button)
	default_cancel_button_is_valid_button_id: buttons.has (default_cancel_button)
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
