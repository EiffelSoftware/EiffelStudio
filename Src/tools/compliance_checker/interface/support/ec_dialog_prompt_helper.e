indexing
	description: "[
		EiffelVision 2 helper to ease of creation of EiffelVision2 question/error/warning dialogs.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_DIALOG_PROMPT_HELPER

feature -- Basic Operations

	ask_question (a_question: STRING; a_confirm: STRING; a_cancel: STRING; a_default_button: STRING; a_format_args: TUPLE; a_window: EV_WINDOW): BOOLEAN is
			-- Asks user a question via a question dialog.
			-- `a_question' is a question to ask, it may include {n} where n relates to an index in `a_format_args'.
			-- `a_confirm' confirmation button text.
			-- `a_cancel' cancel button text.
			-- `a_format_args' arguments to format `a_question' with.
			-- `a_window' window to show prompt modal to.
		require
			a_question_not_void: a_question /= Void
			not_a_question_is_empty: not a_question.is_empty
			a_confirm_not_void: a_confirm /= Void
			not_a_confirm_is_empty: not a_confirm.is_empty
			a_cancel_not_void: a_cancel /= Void
			not_a_cancel_is_empty: not a_cancel.is_empty
			a_default_button_not_void: a_default_button /= Void
			a_default_button_is_confirm_or_cancel: a_default_button.is_equal (a_confirm) or a_default_button.is_equal (a_cancel)
			a_format_args_not_void: a_format_args /= Void
			a_window_not_void: a_window /= Void
		local			
			l_text: STRING
			l_dialog: EV_QUESTION_DIALOG
		do
			if not a_format_args.is_empty then
				l_text := formatter.format (a_question, a_format_args)
			else
				l_text := a_question
			end
			l_text.replace_substring_all ("%R", "")
			create l_dialog.make_with_text (l_text)
			l_dialog.set_buttons (<<a_confirm, a_cancel>>)
			l_dialog.set_default_push_button (l_dialog.button (a_default_button))
			l_dialog.set_default_cancel_button (l_dialog.button (a_cancel))
			l_dialog.show_modal_to_window (a_window)
			Result := l_dialog.selected_button.is_equal (a_confirm)
		end
	
	show_information (a_message: STRING; a_format_args: TUPLE; a_window: EV_WINDOW) is
			-- Shows information dialog prompt.
			-- `a_message' information message.
			-- `a_format_args' format arguments for `a_error'.
			-- `a_window' window to show prompt modal to.
		require
			a_message_not_void: a_message /= Void
			not_a_message_is_empty: not a_message.is_empty
			a_format_args_not_void: a_format_args /= Void
			a_window_not_void: a_window /= Void
		local
			l_text: STRING
			l_dialog: EV_INFORMATION_DIALOG
			l_ok: STRING
		do
			if not a_format_args.is_empty then
				l_text := formatter.format (a_message, a_format_args)
			else
				l_text := a_message
			end
			l_ok := "Ok"
			l_text.replace_substring_all ("%R", "")
			create l_dialog.make_with_text (l_text)
			l_dialog.set_buttons (<<l_ok>>)
			l_dialog.set_default_push_button (l_dialog.button (l_ok))
			l_dialog.set_default_cancel_button (l_dialog.button (l_ok))
			l_dialog.show_modal_to_window (a_window)
		end
		
	show_error (a_error: STRING; a_format_args: TUPLE; a_window: EV_WINDOW) is
			-- Shows error dialog prompt.
			-- `a_error' error message.
			-- `a_format_args' format arguments for `a_error'.
			-- `a_window' window to show prompt modal to.
		require
			a_error_not_void: a_error /= Void
			not_a_error_is_empty: not a_error.is_empty
			a_format_args_not_void: a_format_args /= Void
			a_window_not_void: a_window /= Void
		local
			l_text: STRING
			l_dialog: EV_ERROR_DIALOG
			l_ok: STRING
		do
			if not a_format_args.is_empty then
				l_text := formatter.format (a_error, a_format_args)
			else
				l_text := a_error
			end
			l_ok := "Ok"
			l_text.replace_substring_all ("%R", "")
			create l_dialog.make_with_text (l_text)
			l_dialog.set_buttons (<<l_ok>>)
			l_dialog.set_default_push_button (l_dialog.button (l_ok))
			l_dialog.set_default_cancel_button (l_dialog.button (l_ok))
			l_dialog.show_modal_to_window (a_window)
		end
		
feature {NONE} -- Implementation

	formatter: EC_STRING_FORMATTER is
			-- STRING formatter
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
end -- class EC_DIALOG_PROMPT_HELPER
