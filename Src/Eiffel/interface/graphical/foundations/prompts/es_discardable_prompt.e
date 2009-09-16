note
	description: "[
		A base for all discardable prompts in EiffelStudio.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	ES_DISCARDABLE_PROMPT

inherit
	ES_PROMPT
		rename
			make as make_prompt,
			make_standard as make_standard_prompt,
			build_prompt_interface as build_discardable_check_interface
		export
			{NONE} show_actions, hide_actions
		redefine
			build_discardable_check_interface,
			on_close_requested,
			show,
			show_on_active_window
		end

	ES_DISCARDABLE_PROMPT_OVERRIDES
		rename
			session_manager as overide_session_manager,
			session_data as override_session_data
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_text: like text; a_buttons: like buttons; a_default: like default_button; a_default_confirm: like default_confirm_button; a_default_cancel: like default_cancel_button; a_discard_message: like discard_message; a_setting: like setting)
			-- Initialize a prompt using required information
			--
			-- `a_text': The text to display on the prompt.
			-- `a_buttons': A list of button ids corresponding created from {ES_DIALOG_BUTTONS}.
			-- `a_default': The prompt's default active button.
			-- `a_default_confirm': The prompt's default confirmation button (selected using CTRL+ENTER).
			-- `a_default_cancel': The prompt's default cancel button (selected using ESC).
			-- `a_discard_message': A message to inform the user what the discard option will do as a default.
			-- `a_setting': Setting used to dictate the discard state of the prompt.
		require
			a_text_attached: a_text /= Void
			a_buttons_attached: a_buttons /= Void
			not_a_buttons_is_empty: not a_buttons.is_empty
			a_buttons_contains_valid_ids: a_buttons.for_all (agent dialog_buttons.is_valid_button_id)
			a_buttons_contains_a_default: a_buttons.has (a_default)
			a_buttons_contains_a_default_confirm: a_buttons.has (a_default_confirm)
			a_buttons_contains_a_default_cancel: a_buttons.has (a_default_cancel)
			a_discard_message_attached: a_discard_message /= Void
			a_setting_attached: attached a_setting
			a_setting_is_interface_usable: a_setting.is_interface_usable
		do
			discard_message := a_discard_message
			discard_button := a_default_confirm
			setting := a_setting

				-- Automatically recycle the setting so it is cleaned up when the dialog closes
			auto_recycle (a_setting)
			make_prompt (a_text, a_buttons, a_default, a_default_confirm, a_default_cancel)
		ensure
			text_set: format_text (a_text).is_equal (text)
			default_button_set: default_button = a_default
			buttons_set: buttons = a_buttons
			discard_message_set: a_discard_message.is_equal (discard_message)
			setting_set: setting = a_setting
		end

	make_standard (a_text: like text; a_discard_message: like discard_message; a_setting: like setting)
			-- Initialize a prompt using required information
			--
			-- `a_text': The text to display on the prompt.
			-- `a_discard_message': A message to inform the user what the discard option will do as a default.
			-- `a_setting': Setting used to dictate the discard state of the prompt.
		require
			a_text_attached: a_text /= Void
			a_discard_message_attached: a_discard_message /= Void
			a_setting_attached: attached a_setting
			a_setting_is_interface_usable: a_setting.is_interface_usable
		do
			make (a_text, standard_buttons, standard_default_button, standard_default_confirm_button, standard_default_cancel_button, a_discard_message, a_setting)
		ensure
			text_set: format_text (a_text).is_equal (text)
			default_button_set: default_button = standard_default_button
			buttons_set: buttons = standard_buttons
			discard_message_set: a_discard_message.is_equal (discard_message)
			setting_set: setting = a_setting
		end

feature {NONE} -- User interface initialization

	frozen build_discardable_check_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			l_message: STRING_32
		do
			Precursor {ES_PROMPT} (a_container)

			build_prompt_interface (a_container)

				-- Add discardable check
			l_message := interface_names.l_do_not_show_again.twin
			if not l_message.is_empty and not discard_message.is_empty then
				l_message.prune_all_trailing ('.')
				l_message.append ((" (").as_string_32 + discard_message + ")")
			end
			if not l_message.is_empty then
				create discard_check.make_with_text (l_message)
			else
				create discard_check
			end
			if is_discarded then
					-- The check state is set because this may be a prompt that is shown because the discardable
					-- status has been overriden, using `is_non_discardable'.
				discard_check.enable_select
			end


			a_container.extend (discard_check)
			a_container.disable_item_expand (discard_check)
		ensure then
			discard_check_attached: discard_check /= Void
		end

	build_prompt_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			-- Note: Redefine to add widgets before the discardable check.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		require
			a_container_attached: a_container /= Void
			not_a_container_is_destoryed: not a_container.is_destroyed
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
		do
		end

feature -- Access

	discard_button: INTEGER assign set_discard_button
			-- Default discard operation button

feature {NONE} -- Access

	discard_message: STRING_32
			-- Message to inform user regarding the default actions perform when the dialog is discarded in the future.

	setting: ES_BOOLEAN_SETTING
			-- Boolean setting used for discard

feature -- Element change

	set_discard_button (a_id: like discard_button)
			-- Sets discard button so when the dialog is automatically discard
			-- it performs the actions of the specified button.
			--
			-- `a_id': A button id corrsponding to a dialog window button.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		do
			discard_button := a_id
		ensure
			discard_button_set: discard_button = a_id
		end

feature {NONE} -- User interface elements

	discard_check: EV_CHECK_BUTTON
			-- Check box used to discard dialog

feature -- Status report

	is_discarded: BOOLEAN
			-- Indicates if the prompt was already selected to be discarded in a previous session.
			-- Note: Use `is_discard_requested' to determine if the dialog has been requested
			--       to be discarded in the future.
		do
			Result := not setting.value
		end

	is_discard_requested: BOOLEAN assign set_is_discard_requested
			-- Indicates if user has opted to discard the dialog in the future.
			-- Note: Use `is_discarded' to determine if the dialog was selected
			--       to be discarded in a previous session.
		do
			Result := discard_check.is_selected
		end

feature -- Status setting

	set_is_discard_requested (a_discard: BOOLEAN)
			-- Set's dialog's discard status to `a_discard'
			--
			-- `a_discard': True to set the default to discard; False otherwise
		do
			if a_discard then
				discard_check.enable_select
			else
				discard_check.disable_select
			end
		ensure
			is_discard_requested_set: is_discard_requested = a_discard
		end

feature -- Basic operations

	show (a_window: EV_WINDOW)
			-- Show and wait until `Current' is closed.
			-- `Current' is shown modal with respect to `a_window'.
		do
			if not is_discarded or else is_non_discardable then
				Precursor {ES_PROMPT} (a_window)
			else
				on_dialog_button_pressed (discard_button)
					-- No need to call close request actions because the dialog is shown modal
					-- Also, the actions are not exported and the dialog was not actually shown!
			end
		end

	show_on_active_window
			-- Attempts to show the dialog parented to the last active window.
		do
			if not is_discarded or else is_non_discardable then
				Precursor {ES_PROMPT}
			else
				on_dialog_button_pressed (discard_button)
					-- No need to call close request actions because the dialog is shown modal
					-- Also, the actions are not exported and the dialog was not actually shown!
			end
		end

feature {NONE} -- Basic operations

	surpress_future_dialogs
			-- Sets all the information necessary to discard the dialog in the future
			-- and use the default settings
		do
			setting.set_value (False)
			setting.commit
		end

feature {NONE} -- Action handlers

	on_close_requested (a_id: INTEGER)
			-- Called when a dialog button is pressed and a close is requested.
			-- Note: Redefine to veto a close request.
			--
			-- `a_id': A button id corrsponding to the button pressed to close the dialog.
			--         Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		do
			Precursor {ES_PROMPT} (a_id)
			if not is_shown and is_discard_requested and dialog_result = discard_button then
					-- Set discarded state and perform any other operations.
					-- Note: only called when dialog is closed using the set discard button
				surpress_future_dialogs
			end
		end

invariant
	discard_message_attached: attached discard_message
	setting_attached: attached setting
	setting_is_auto_recycled: setting.is_auto_recycled
	discard_check_attached: attached discard_check
	buttons_contains_discard_button: buttons.has (discard_button)

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
