note
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
			l_error: ES_ERROR_PROMPT
		do
			create l_error.make_standard (a_message)
			safe_set_button_action (l_error, l_error.dialog_buttons.ok_button, a_ok_action)
			safe_show_prompt (l_error, a_window)
			l_error.recycle
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
			l_info: ES_INFORMATION_PROMPT
		do
			create l_info.make_standard (a_message)
			safe_set_button_action (l_info, l_info.dialog_buttons.ok_button, a_ok_action)
			safe_show_prompt (l_info, a_window)
			l_info.recycle
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
			l_warning: ES_WARNING_PROMPT
		do
			create l_warning.make_standard (a_message)
			safe_set_button_action (l_warning, l_warning.dialog_buttons.ok_button, a_ok_action)
			safe_show_prompt (l_warning, a_window)
			l_warning.recycle
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
			l_warning: ES_WARNING_PROMPT
		do
			create l_warning.make_standard_with_cancel (a_message)
			safe_set_button_action (l_warning, l_warning.dialog_buttons.ok_button, a_ok_action)
			safe_set_button_action (l_warning, l_warning.dialog_buttons.cancel_button, a_cancel_action)
			safe_show_prompt (l_warning, a_window)
			l_warning.recycle
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
			l_question: ES_QUESTION_PROMPT
		do
			create l_question.make_standard (a_message)
			safe_set_button_action (l_question, l_question.dialog_buttons.yes_button, a_yes_action)
			safe_set_button_action (l_question, l_question.dialog_buttons.no_button, a_no_action)
			safe_show_prompt (l_question, a_window)
			l_question.recycle
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
			l_question: ES_QUESTION_PROMPT
		do
			create l_question.make_standard_with_cancel (a_message)
			safe_set_button_action (l_question, l_question.dialog_buttons.yes_button, a_yes_action)
			safe_set_button_action (l_question, l_question.dialog_buttons.no_button, a_no_action)
			safe_set_button_action (l_question, l_question.dialog_buttons.cancel_button, a_cancel_action)
			safe_show_prompt (l_question, a_window)
			l_question.recycle
		end

feature {NONE} -- Display

	safe_set_button_action (a_prompt: ES_PROMPT; a_button: INTEGER; a_action: PROCEDURE [ANY, TUPLE])
			-- Associates a dialog prompt's button with an action
			--
			-- `a_prompt': Dialog prompt to set the button action on.
			-- `a_button': The button identifer to associate the action with.
			-- `a_action': The action to perform when the associated button is pressed.
		require
			a_prompt_attached: a_prompt /= Void
			not_a_prompt_is_recycled: not a_prompt.is_recycled
			a_button_is_prompt_button: a_prompt.buttons.has (a_button)
		do
			if a_action /= Void then
				a_prompt.set_button_action (a_button, a_action)
			end
		ensure
			button_action_set: a_prompt.button_action (a_button) = a_action
		end

	safe_show_prompt (a_prompt: ES_PROMPT; a_window: EV_WINDOW)
			-- Displays a prompt.
			--
			-- `a_prompt': Dialog prompt to show
			-- `a_window': A window to show the prompt parented to, or Void if no parent is available.
		require
			a_prompt_attached: a_prompt /= Void
			not_a_prompt_is_recycled: not a_prompt.is_recycled
			not_a_prompt_is_shown: not a_prompt.is_shown
		do
			if a_window = Void or else a_window.is_destroyed or else not a_window.is_show_requested then
				a_prompt.show_on_active_window
			else
				a_prompt.show (a_window)
			end
		end

;note
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
