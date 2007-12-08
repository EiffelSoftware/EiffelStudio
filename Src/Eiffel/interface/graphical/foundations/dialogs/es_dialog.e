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

inherit {NONE}

	ES_SHARED_DIALOG_BUTTONS

	EV_BUILDER
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	ES_SHARED_FONTS_AND_COLORS
		export
			{NONE} all
		end

convert
	to_dialog: {EV_DIALOG}

feature {NONE} -- Initialization

	make
			-- Initialize dialog
		local
			l_init: BOOLEAN
		do
			l_init := is_initializing
			is_initializing := True

			is_modal := True

			initialize
			build_interface

			dialog_result := default_button
			dialog.set_icon_pixmap (icon)
			register_action (dialog.key_press_actions, agent on_key_pressed)
			register_action (dialog.key_release_actions, agent on_key_release)
			register_action (dialog.show_actions, agent show_actions.call ([]))

			is_initialized := True
			is_initializing := l_init
		ensure
			is_initialized: is_initialized
		end

	make_with_window (a_window: like development_window)
			-- Initialize dialog using a specific development window
		require
			a_window_attached: a_window /= Void
			not_a_window_is_recycled: not a_window.is_recycled
		do
			internal_development_window := a_window
			make
		ensure
			development_window_set: development_window = a_window
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

 			create l_container
			l_container.set_border_width (dialog_button_border_width)
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

				dialog.destroy
				is_initialized := False
				is_recycled := l_recycled
			end
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		require
			not_is_recycled: not is_recycled
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

	development_window: EB_DEVELOPMENT_WINDOW
			-- Access to top-level parent window
		require
			not_is_recycled: not is_recycled
		local
			l_window: EV_WINDOW
			l_windows: BILINEAR [EB_WINDOW]
		do
			Result := internal_development_window
			if Result = Void then
				if is_modal then
					l_window := helpers.widget_top_level_window (dialog.blocking_window, True)
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

	frozen button_actions: DS_HASH_TABLE [TUPLE [action: like button_action; before_close: BOOLEAN], INTEGER]
			-- Dialog button actions

	frozen session_data: SESSION_I
			-- Provides access to the environment session data
		require
			not_is_recycled: not is_recycled
			is_session_manager_available: session_manager.is_service_available
		do
			Result := session_manager.service.retrieve (False)
		ensure
			result_attached: Result /= Void
			result_is_interface_usable: Result.is_interface_usable
		end

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

	frozen helpers: EVS_HELPERS
			-- Helpers to extend the operations of EiffelVision2
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	frozen session_manager: SERVICE_CONSUMER [SESSION_MANAGER_S]
			-- Access to the session manager service {SESSION_MANAGER_S} consumer
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	frozen help_providers: SERVICE_CONSUMER [HELP_PROVIDERS_S]
			-- Access to the help providers service {HELP_PROVIDERS_S} consumer
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
			not_is_recycled: not is_recycled
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
			not_is_recycled: not is_recycled
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			buttons_contains_a_id: buttons.has (a_id)
			a_action_attached: a_action /= Void
		do
			button_actions.force ([a_action, True], a_id)
		ensure
			button_action_set: button_action_before_close (a_id) = a_action
		end

feature -- Status report

	is_shown: BOOLEAN
			-- Indicates if dialog is current visible
		do
			if is_initialized and then not is_recycled then
				Result := dialog.is_show_requested
			end
		end

	is_modal: BOOLEAN assign set_is_modal
			-- Indicates if dialog is a modal dialog

feature {NONE} -- Status report

	is_initialized: BOOLEAN
			-- Indicates if the user interface has been initialized

	is_initializing: BOOLEAN
			-- Indicates if the user interface is currently being initialized

	is_recycled_on_closing: BOOLEAN
			-- Indicates if the dialog should be recycled on closing.
		require
			not_is_recycled: not is_recycled
		once
			Result := True
		end

	is_close_vetoed: BOOLEAN
			-- Indicates if the dialog's shutdown has been vetoed
			-- Note: See `veto_close' for more information

feature -- Status setting

	set_is_modal (a_modal: BOOLEAN)
			-- Sets dialog's modal state to `a_modal'
		do
			is_modal := a_modal
		ensure
			is_modal_set: is_modal = a_modal
		end

feature -- Query

	button_action (a_id: INTEGER): PROCEDURE [ANY, TUPLE]
			-- Button action, called before the dialog is closed, for a specific button.
			--
			-- `a_id': A button id corresponding to an actual dialog button.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
			-- `Result': An action to be performed when the button is pressed.
		require
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
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

feature -- Basic operations

	show (a_window: EV_WINDOW) is
			-- Show and wait until `Current' is closed.
			-- `Current' is shown modal with respect to `a_window'.
		require
			not_is_recycled: not is_recycled
			a_window_not_void: a_window /= Void
			a_window_not_current: a_window /= to_dialog
		do
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

	show_on_active_window is
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
			l_padding_button: EV_BUTTON
			l_buttons: DS_HASH_TABLE_CURSOR [EV_BUTTON, INTEGER]
			l_button: EV_BUTTON
			l_min_width: INTEGER
			l_padding: INTEGER
			l_allow_resize: BOOLEAN
		do
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
				l_min_width := l_min_width.max (l_button.font.string_width (l_button.text) + l_padding)
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

    execute_with_busy_cursor (a_action: PROCEDURE [ANY, TUPLE])
            -- Executes a action with a wait cursor
            --
            -- `a_action': An action to execute with a wait cursor displayed until the action has been completed
        require
            not_is_recycled: not is_recycled
            is_initialized: is_initialized
            a_action_attached: a_action /= Void
        local
            l_style: EV_POINTER_STYLE
        do
            if is_initialized then
                l_style := dialog.pointer_style
                dialog.set_pointer_style ((create {EV_STOCK_PIXMAPS}).busy_cursor)
            end
            a_action.call ([])
            if l_style /= Void then
                check is_initialized: is_initialized end
                dialog.set_pointer_style (l_style)
            end
        rescue
            if l_style /= Void then
                check is_initialized: is_initialized end
                dialog.set_pointer_style (l_style)
            end
        end

	veto_close
			-- Ensures dialog is not closed as a result of a button action.
			-- Note: This routine should be called in a registered button action.
		do
			is_close_vetoed := True
		ensure
			is_close_vetoed: is_close_vetoed
		end

	show_help
			-- Attempts to show help given the current help context implemented on Current.
			-- Note: Descendents should implement {HELP_CONTEXT_I} or use the base implementation {HELP_CONTEXT}
			--       in order for help to be displayed
		do
			if help_providers.is_service_available then
					-- Add a help button, if help is available
				if {l_help_context: !HELP_CONTEXT_I} Current and then l_help_context.is_help_available then
					on_help_requested (l_help_context)
				end
			end
		end

feature -- Actions

	show_actions: EV_LITE_ACTION_SEQUENCE [TUPLE]
			-- Actions performed when the dialog is shown

	close_actions: EV_LITE_ACTION_SEQUENCE [TUPLE]
			-- Actions performed when the dialog is closed

feature {NONE} -- Action handlers

	on_before_show
			-- Called prior to the dialog being shown
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
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
			buttons_has_a_id: buttons.has (a_id)
			not_is_close_vetoed: not is_close_vetoed
		do
			dialog.hide
			close_actions.call ([])
		ensure
			not_is_close_vetoed: not is_close_vetoed
		end

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
			l_action := button_action_before_close (a_id)
			if l_action /= Void then
				l_action.call ([])
			end
			if not is_close_vetoed then
				on_close_requested (a_id)
				l_action := button_action (a_id)
				if l_action /= Void then
					l_action.call ([])
				end
			end
			is_close_vetoed := False
		ensure
			not_is_close_vetoed: not is_close_vetoed
		end

	on_confirm_dialog
			-- Called when the user presses CTRL+ENTER to discard the dialog
		do
			on_dialog_button_pressed (default_confirm_button)
		end

	on_cancel_dialog
			-- Called when the user presses ESC
		do
			on_dialog_button_pressed (default_cancel_button)
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
		do
			if a_released then
				if not a_alt and not a_ctrl and not a_shift then
					Result := True
					inspect a_key.code
					when {EV_KEY_CONSTANTS}.key_escape then
						on_cancel_dialog
					else
						Result := False
					end
				end

				if not Result and then a_ctrl and not a_alt and not a_shift then
					Result := True
					inspect a_key.code
					when {EV_KEY_CONSTANTS}.key_enter then
						on_confirm_dialog
					else
						Result := False
					end
				end
			end
		end

	on_help_requested (a_context: !HELP_CONTEXT_I) is
			-- Called when help is requested for the dialog.
			--
			-- `a_context': The help context to show help for
		require
			a_context_is_interface_usable: a_context.is_interface_usable
			a_context_is_help_available: a_context.is_help_available
		do
			if help_providers.is_service_available then
				help_providers.service.show_help (a_context)
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

			if help_providers.is_service_available then
					-- Add a help button, if help is available
				if {l_help_context: !HELP_CONTEXT_I} Current and then l_help_context.is_help_available then
					if {l_help_widget: !EV_WIDGET} create_help_widget then
						l_container.extend (l_help_widget)
						l_container.disable_item_expand (l_help_widget)
					end
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
			not_is_recycled: not is_recycled
			is_initializing: is_initializing
			a_id_is_valid_button_id: dialog_buttons.is_valid_button_id (a_id)
		local
			l_label: STRING_32
		do
			l_label := dialog_button_label (a_id)
			create Result.make_with_text (l_label)
		ensure
			result_attached: Result /= Void
		end

	create_help_widget: EV_WIDGET
			-- Creates a help widget for use in the dialog button ribbon for recieving help
		local
			l_pixmap: EV_PIXMAP
		do
			l_pixmap := stock_pixmaps.command_system_info_icon
			l_pixmap.set_tooltip ("Click to show the help documentation.")

				-- Set click action
			register_action (l_pixmap.pointer_button_release_actions, agent (a_ia_x, a_ia_y, a_ia_button: INTEGER_32; a_ia_x_tilt, a_ia_y_tilt, a_ia_pressure: REAL_64; a_ia_screen_x, a_ia_screen_y: INTEGER_32)
				do
					if a_ia_button = {EV_POINTER_CONSTANTS}.left then
						show_help
					end
				end)

				-- Set enter action (change cursor)
			register_action (l_pixmap.pointer_enter_actions, agent (a_ia_pixmap: EV_PIXMAP)
				do
					a_ia_pixmap.set_pointer_style ((create {EV_STOCK_PIXMAPS}).hyperlink_cursor)
				end (l_pixmap))

				-- Set leave action (change cursor)
			register_action (l_pixmap.pointer_leave_actions, agent (a_ia_pixmap: EV_PIXMAP)
				do
					a_ia_pixmap.set_pointer_style (dialog.pointer_style)
				end (l_pixmap))

			Result := l_pixmap
			Result.set_minimum_size (l_pixmap.width, l_pixmap.height)
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
