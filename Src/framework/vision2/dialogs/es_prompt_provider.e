indexing
	description: "[
		Prompt dialog provider for showing various pre-configured prompts to the user.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_PROMPT_PROVIDER

feature -- Factory

	show_error_prompt (a_message: STRING_32; a_window: EV_WINDOW; a_ok_action: PROCEDURE [ANY, TUPLE])
			-- Displays an error prompt to the user with an Ok button only
			--
			-- `a_message': A message to display to the user
			-- `a_window': A parent window, or Void if none is available
			-- `a_ok_action': An option action to perform when the user clicks the 'Ok' button.
		require
			a_message_attached: a_message /= Void
			not_a_message_is_empty: not a_message.is_empty
		local
			l_error: EB_ERROR_DIALOG
		do
			create l_error.make_with_text (a_message)
			l_error.set_buttons_and_actions (<<interface_names.b_ok>>, <<a_ok_action>>)
			l_error.set_default_push_button (l_error.button (interface_names.b_ok))
			safe_show_dialog (l_error, a_window)
		end

	show_info_prompt (a_message: STRING_32; a_window: EV_WINDOW; a_ok_action: PROCEDURE [ANY, TUPLE])
			-- Displays an information prompt to the user with an Ok button only
			--
			-- `a_message': A message to display to the user
			-- `a_window': A parent window, or Void if none is available
			-- `a_ok_action': An option action to perform when the user clicks the 'Ok' button.
		require
			a_message_attached: a_message /= Void
			not_a_message_is_empty: not a_message.is_empty
		local
			l_info: EB_INFORMATION_DIALOG
		do
			create l_info.make_with_text (a_message)
			l_info.set_buttons_and_actions (<<interface_names.b_ok>>, <<a_ok_action>>)
			l_info.set_default_push_button (l_info.button (interface_names.b_ok))
			safe_show_dialog (l_info, a_window)
		end

	show_warning_prompt (a_message: STRING_32; a_window: EV_WINDOW; a_ok_action: PROCEDURE [ANY, TUPLE])
			-- Displays a warning prompt to the user with an Ok button only.
			--
			-- `a_message': A message to display to the user
			-- `a_window': A parent window, or Void if none is available
			-- `a_ok_action': An option action to perform when the user clicks the 'Ok' button.
		require
			a_message_attached: a_message /= Void
			not_a_message_is_empty: not a_message.is_empty
		local
			l_warning: EB_WARNING_DIALOG
		do
			create l_warning.make_with_text (a_message)
			l_warning.set_buttons_and_actions (<<interface_names.b_ok>>, <<a_ok_action>>)
			l_warning.set_default_push_button (l_warning.button (interface_names.b_ok))
			safe_show_dialog (l_warning, a_window)
		end

	show_warning_prompt_with_cancel (a_message: STRING_32; a_window: EV_WINDOW; a_ok_action: PROCEDURE [ANY, TUPLE]; a_cancel_action: PROCEDURE [ANY, TUPLE])
			-- Displays an warning prompt to the user with Ok & Cancel buttons
			--
			-- `a_message': A message to display to the user
			-- `a_window': A parent window, or Void if none is available
			-- `a_ok_action': An option action to perform when the user clicks the 'Ok' button.
			-- `a_cancel_action': An option action to perform when the user clicks the 'Cancel' button.
		require
			a_message_attached: a_message /= Void
			not_a_message_is_empty: not a_message.is_empty
		local
			l_warning: EB_WARNING_DIALOG
		do
			create l_warning.make_with_text (a_message)
			l_warning.set_buttons_and_actions (<<interface_names.b_ok, interface_names.b_cancel>>, <<a_ok_action, a_cancel_action>>)
			l_warning.set_default_push_button (l_warning.button (interface_names.b_ok))
			safe_show_dialog (l_warning, a_window)
		end

	show_question_prompt (a_message: STRING_32; a_window: EV_WINDOW; a_yes_action: PROCEDURE [ANY, TUPLE]; a_no_action: PROCEDURE [ANY, TUPLE];)
			-- Displays a question prompt to the user with an Ok button only.
			--
			-- `a_message': A message to display to the user
			-- `a_window': A parent window, or Void if none is available
			-- `a_yes_action': An option action to perform when the user clicks the 'Yes' button.
			-- `a_no_action': An option action to perform when the user clicks the 'No' button.
		require
			a_message_attached: a_message /= Void
			not_a_message_is_empty: not a_message.is_empty
		local
			l_confirm: EB_CONFIRMATION_DIALOG
		do
			create l_confirm.make_with_text (a_message)
			l_confirm.set_buttons_and_actions (<<interface_names.b_yes, interface_names.b_no>>, <<a_yes_action, a_no_action>>)
			l_confirm.set_default_push_button (l_confirm.button (interface_names.b_yes))
			safe_show_dialog (l_confirm, a_window)
		end

	show_question_prompt_with_cancel (a_message: STRING_32; a_window: EV_WINDOW; a_yes_action: PROCEDURE [ANY, TUPLE]; a_no_action: PROCEDURE [ANY, TUPLE]; a_cancel_action: PROCEDURE [ANY, TUPLE])
			-- Displays an question prompt to the user with Ok & Cancel buttons
			--
			-- `a_message': A message to display to the user
			-- `a_window': A parent window, or Void if none is available
			-- `a_yes_action': An option action to perform when the user clicks the 'Yes' button.
			-- `a_no_action': An option action to perform when the user clicks the 'No' button.
			-- `a_cancel_action': An option action to perform when the user clicks the 'Cancel' button.
		require
			a_message_attached: a_message /= Void
			not_a_message_is_empty: not a_message.is_empty
		local
			l_confirm: EB_CONFIRMATION_DIALOG
		do
			create l_confirm.make_with_text (a_message)
			l_confirm.set_buttons_and_actions (<<interface_names.b_yes, interface_names.b_no, interface_names.b_cancel>>, <<a_yes_action, a_no_action, a_cancel_action>>)
			l_confirm.set_default_push_button (l_confirm.button (interface_names.b_yes))
			safe_show_dialog (l_confirm, a_window)
		end

feature {NONE} -- Access

	frozen interface_names: INTERFACE_NAMES
			-- Shared access to interface name strings
		once
			create Result
		end

feature {NONE} -- Display

	safe_show_dialog (a_dialog: EV_DIALOG; a_window: EV_WINDOW) is
			-- Displays a dialog prompt.
			--
			-- `a_dialog': Dialog prompt to show
			-- `a_window': A window to show the prompt parented to, or Void if no parent is available.
		require
			a_dialog_attached: a_dialog /= Void
			not_a_dialog_is_shown: not a_dialog.is_displayed
		do
			if a_window = Void or else a_window.is_destroyed or else not a_window.is_show_requested then
				a_dialog.show
			else
				a_dialog.show_modal_to_window (a_window)
			end
		end

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
