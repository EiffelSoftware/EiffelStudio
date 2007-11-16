indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	ES_EXCEPTION_SUBMIT_DIALOG

inherit
	ES_DIALOG
		rename
			make as make_dialog
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_comm: like support_login)

		require
			a_comm_attached: a_comm /= Void
			a_comm_is_support_accessible: a_comm.is_support_accessible
		do
			support_login := a_comm
			make_dialog
		ensure
			support_login_set: support_login = a_comm
		end

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			l_vbox: EV_VERTICAL_BOX
			l_width: INTEGER
			l_user_label: EV_LABEL
			l_pass_label: EV_LABEL
			l_text: EV_LABEL
			l_link: EVS_LINK_LABEL
			l_hbox: EV_HORIZONTAL_BOX
			l_shrinkable: EV_FIXED
		do
			a_container.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

			create login_frame.make_with_text ("Account access")
			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			l_vbox.set_border_width ({ES_UI_CONSTANTS}.frame_border)
			login_frame.extend (l_vbox)

				-- Username and password
			create l_user_label.make_with_text ("Username: ")
			l_user_label.align_text_right
			create l_pass_label.make_with_text ("Password: ")
			l_pass_label.align_text_right
			l_width := l_user_label.width.max (l_pass_label.width)
			l_user_label.set_minimum_width (l_width)
			l_pass_label.set_minimum_width (l_width)

				-- Username
			create l_hbox
			l_hbox.extend (l_user_label)
			l_hbox.disable_item_expand (l_user_label)
			create username_text
			username_text.set_text (remembered_username.item)
			username_text.set_minimum_width (190)
			register_action (username_text.change_actions, agent enable_login)
			l_hbox.extend (username_text)

			l_vbox.extend (l_hbox)
			l_vbox.disable_item_expand (l_hbox)

				-- Password
			create l_hbox
			l_hbox.extend (l_pass_label)
			l_hbox.disable_item_expand (l_pass_label)
			create password_text
			password_text.set_text (remembered_password.item)
			register_action (password_text.change_actions, agent enable_login)
			password_text.set_minimum_width (190)
			l_hbox.extend (password_text)

			l_vbox.extend (l_hbox)
			l_vbox.disable_item_expand (l_hbox)

				-- Remember me check
			create l_hbox
			l_hbox.extend (create {EV_CELL})
			create remember_me_check.make_with_text ("Remember me")
			if is_user_remembered.item then
				remember_me_check.enable_select
			end
			l_hbox.extend (remember_me_check)
			l_hbox.disable_item_expand (remember_me_check)
			create login_button.make_with_text ("Login...")
			login_button.set_minimum_width ({ES_UI_CONSTANTS}.dialog_button_width)
			register_action (login_button.select_actions, agent on_login)
			l_hbox.extend (login_button)
			l_hbox.disable_item_expand (login_button)

			l_vbox.extend (l_hbox)
			l_vbox.disable_item_expand (l_hbox)

				-- Register
			create l_hbox
			create l_text.make_with_text ("If you do not already have an account, please register ")
			l_text.align_text_left
			create l_link.make_with_text ("here")
			l_link.select_actions.extend (agent
				local
					l_launcher: EB_PROCESS_LAUNCHER
				do
					l_launcher := (create {EB_SHARED_MANAGERS}).external_launcher
					l_launcher.open_dir_in_file_browser ("https://www2.eiffel.com/login/secure/register.aspx")
				end)
			l_link.align_text_left
			l_hbox.extend (l_text)
			l_hbox.disable_item_expand (l_text)
			l_hbox.extend (l_link)

			l_vbox.extend (l_hbox)
			l_vbox.disable_item_expand (l_hbox)

			create l_shrinkable
			l_shrinkable.extend (login_frame)
			shrink_widget := l_shrinkable

			l_shrinkable.set_background_color (colors.prompt_banner_color)
			l_shrinkable.resize_actions.extend (agent (a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32)
				do
					shrink_widget.set_item_size (login_frame, a_width, a_height)
				end)

			a_container.extend (l_shrinkable)
			a_container.disable_item_expand (l_shrinkable)

				-- Logged in text
			create logged_in_label
			logged_in_label.align_text_left
			logged_in_label.hide

			create log_out_link.make_with_text ("log out...")
			log_out_link.select_actions.extend (agent on_logout)
			log_out_link.align_text_left
			log_out_link.hide

			create l_hbox
			l_hbox.extend (logged_in_label)
			l_hbox.disable_item_expand (logged_in_label)
			l_hbox.extend (log_out_link)
			l_hbox.disable_item_expand (log_out_link)

			a_container.extend (l_hbox)
			a_container.disable_item_expand (l_hbox)


				--
				-- More bug information
				--
			create report_frame.make_with_text ("Bug information")
			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.vertical_padding)
			l_vbox.set_border_width ({ES_UI_CONSTANTS}.frame_border)
			report_frame.extend (l_vbox)

			a_container.extend (report_frame)

				-- Synopsis
			create synopsis_text
			synopsis_text.set_text (synopsis)
			register_action (synopsis_text.focus_in_actions, agent on_text_component_focused (synopsis_text))
			register_action (synopsis_text.focus_out_actions, agent on_text_component_focused_out (synopsis_text, default_synopsis))
			l_vbox.extend (synopsis_text)
			l_vbox.disable_item_expand (synopsis_text)

				-- Description
			create description_text
			description_text.set_minimum_size (400, 100)
			register_action (description_text.focus_in_actions, agent on_text_component_focused (description_text))
			register_action (description_text.focus_out_actions, agent on_text_component_focused_out (description_text, default_description))
			l_vbox.extend (description_text)

				-- Public bug
			create make_public_check.make_with_text ("Make bug publically available")
			l_vbox.extend (make_public_check)
			l_vbox.disable_item_expand (make_public_check)

				-- Add items to login context
			--login_context_item.force_last (l_frame)

				-- Enable content items based on login state.
			on_text_component_focused_out (synopsis_text, default_synopsis)
			on_text_component_focused_out (description_text, default_description)
			enable_login
			enable_login_content_widget (False)

			set_button_text ({ES_DIALOG_BUTTONS}.ok_button, "Submit")
			set_button_action_before_close ({ES_DIALOG_BUTTONS}.ok_button, agent on_submit)

			if is_user_remembered.item then
				register_kamikaze_action (show_actions, agent on_login)
			end
		end

feature {NONE} -- Access

	support_login: COMM_SUPPORT_BUG_REPORTER
			-- Reporter used to report bugs to the support system

	is_user_remembered: BOOLEAN_REF
			-- Indicates if user login information was remembered
		once
			create Result
			Result.set_item (False)
		ensure
			result_attached: Result /= Void
		end

	remembered_username: CELL [STRING_GENERAL]
			-- Last remembered user name
		once
			create Result
		ensure
			result_attached: Result /= Void
			result_item_attached: Result.item /= Void
		end

	remembered_password: CELL [STRING_GENERAL]
			-- Last remembered password
		once
			create Result
		ensure
			result_attached: Result /= Void
			result_item_attached: Result.item /= Void
		end

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		once
			Result := (create {EV_STOCK_PIXMAPS}).error_pixel_buffer
		end

	title: STRING_32
			-- The dialog's title
		once
			Result := "Submit EiffelStudio Unhandled Exception"
		end

	buttons: DS_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		once
			Result := dialog_buttons.ok_cancel_buttons
		end

	default_button: INTEGER
			-- The dialog's default action button
		once
			Result := {ES_DIALOG_BUTTONS}.ok_button
		end

	default_confirm_button: INTEGER
			-- The dialog's default confirm button
		once
			Result := {ES_DIALOG_BUTTONS}.ok_button
		end

	default_cancel_button: INTEGER
			-- The dialog's default cancel button
			-- Note: The default cancel button is set on show, so if you want to change the
			--       default cancel button after the dialog has been shown, please see the implmentation
			--       of `show' to see how it is done.
		once
			Result := {ES_DIALOG_BUTTONS}.cancel_button
		end

	default_synopsis: STRING = "Enter synopsis"
			-- Default text for the bug report synopsis

	default_description: STRING = "Enter supplimentry bug information"
			-- Default text for the bug report description

feature {NONE} -- Status report

	is_synopsis_available: BOOLEAN
			-- Determines if a synopsis has been entered by the user
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		do
			Result := synopsis_text.text /= Void and then not synopsis_text.text.is_empty and then not synopsis_text.text.is_equal (default_synopsis)
		end

	is_description_available: BOOLEAN
			-- Determines if a description has been entered by the user
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		do
			Result := description_text.text /= Void and then not description_text.text.is_empty and then not description_text.text.is_equal (default_description)
		end

	can_submit: BOOLEAN
			-- Determines if a report is submittable
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		do
			Result := support_login.is_support_accessible and then support_login.is_logged_in
		end

feature {NONE} -- Action handlers

	on_login
			-- Called when user requests to log in
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			is_support_accessible: support_login.is_support_accessible
		do
			execute_with_busy_cursor (agent
				local
					l_error: ES_ERROR_PROMPT
				do
					login_button.disable_sensitive
					support_login.force_logout
					support_login.attempt_logon (username_text.text, password_text.text, remember_me_check.is_selected)
					if support_login.is_logged_in then
						if remember_me_check.is_selected then
							is_user_remembered.set_item (True)
							remembered_username.put (username_text.text)
							remembered_password.put (password_text.text)
						end
						logged_in_label.set_text ("You are currently logged in as " + username_text.text + " ")
						logged_in_label.show
						log_out_link.show

						create shrink_timer.make_with_interval (shrink_interval)
						shrink_timer.actions.extend (agent on_shrink_interval_expired_for_collapse)
					else
						create l_error.make_standard ("Unable to login with the specified user name and password. Please check and try again.")
						l_error.show (dialog)

						logged_in_label.hide
						log_out_link.hide
						login_button.enable_sensitive
						enable_login_content_widget (False)
					end
				end)
		end

	on_logout
			-- Called when the user requests a log out of a current session
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			is_support_accessible: support_login.is_support_accessible
		do
			logged_in_label.hide
			log_out_link.hide

			login_button.enable_sensitive
			enable_login_content_widget (False)

			create shrink_timer.make_with_interval (shrink_interval)
			shrink_timer.actions.extend (agent on_shrink_interval_expired_for_expand)
		end

	on_submit
			-- Call when user chooses to submit a bug report
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			is_support_accessible: support_login.is_support_accessible
			can_submit: can_submit
		local
			l_warning: ES_WARNING_PROMPT
			l_error: ES_ERROR_PROMPT
			retried: BOOLEAN
		do
			if not retried then
				if not is_description_available then
					create l_warning.make_standard_with_cancel ("No bug description has been supplied. Submitting a report without additional details can make it hard to repoduce.%N%NDo you want to continue submitting a bug report?")
					l_warning.set_button_action ({ES_DIALOG_BUTTONS}.cancel_button, agent veto_close)
					l_warning.set_button_action ({ES_DIALOG_BUTTONS}.ok_button, agent do execute_with_busy_cursor (agent submit_bug_report) end)
					l_warning.show (dialog)
				else
					execute_with_busy_cursor (agent submit_bug_report)
				end
			else
				create l_error.make_standard ("There was a problem submitting the problem report. Please submit is manually at http://support.eiffel.com.")
				l_error.show (dialog)
			end
		end

	on_shrink_interval_expired_for_collapse
			-- Called when `shrink_timer' interval expires when collapsing.
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			shrink_timer_attached: shrink_timer /= Void
		do
			if shrink_widget.height = 0 then
				shrink_timer.destroy
				shrink_timer := Void
				enable_login_content_widget (True)
			else
				shrink_widget.set_minimum_height ((shrink_widget.height - 4).max (0))
			end
		end

	on_shrink_interval_expired_for_expand
			-- Called when `shrink_timer' interval expires when expanding.
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			shrink_timer_attached: shrink_timer /= Void
		do
			if shrink_widget.height = login_frame.height then
				shrink_timer.destroy
				shrink_timer := Void
				enable_login_content_widget (False)
			else
				shrink_widget.set_minimum_height ((shrink_widget.height + 4).min (login_frame.height))
			end
		end

	on_text_component_focused (a_text_widget: EV_TEXT_COMPONENT)
			-- Called when a registered text widget attains focused
			--
			-- `a_text_widget': The focused text_widget.
		require
			is_initialized: is_initialized or is_initializing
			not_is_recycled: not is_recycled
			a_text_widget_attached: a_text_widget /= Void
		local
			l_text: STRING_GENERAL
		do
			l_text := a_text_widget.text
			if l_text = Void or else l_text.as_string_8.is_equal (default_description) then
				a_text_widget.set_foreground_color (colors.grid_item_text_color)
				a_text_widget.set_text ("")
			end
		end

	on_text_component_focused_out (a_text_widget: EV_TEXT_COMPONENT; a_default_text: STRING_GENERAL)
			-- Called when a registered text widget loses focused
			--
			-- `a_text_widget': The unfocused text_widget.
			-- `a_default_text': The default text to show, if no text is available for the widget.
		require
			is_initialized: is_initialized or is_initializing
			not_is_recycled: not is_recycled
			a_text_widget_attached: a_text_widget /= Void
			a_default_text_attached: a_default_text /= Void
			not_a_default_text_is_empty: not a_default_text.is_empty
		local
			l_text: STRING_GENERAL
		do
			l_text := a_text_widget.text
			if l_text = Void or else l_text.is_empty then
				a_text_widget.set_foreground_color (colors.grid_disabled_item_text_color)
				a_text_widget.set_text (a_default_text)
			end
		end

feature {NONE} -- User interface manipulation

	enable_login
			-- Enable login
		require
			is_initialized: is_initialized or is_initializing
			not_is_recycled: not is_recycled
			login_button_attached: login_button /= Void
			remember_me_check_attached: remember_me_check /= Void
		do
			if username_text.text.count >= 6 and then password_text.text.count >= 4 then
				login_button.enable_sensitive
				remember_me_check.enable_sensitive
			else
				login_button.disable_sensitive
				remember_me_check.disable_sensitive
			end
		end

	enable_login_content_widget (a_enable: BOOLEAN)
			-- Enable/disable login context wdigets based on login state
		require
			is_initialized: is_initialized or is_initializing
			not_is_recycled: not is_recycled
			login_frame_attached: login_frame /= Void
		do
			if a_enable then
				login_frame.disable_sensitive
				report_frame.enable_sensitive
				if can_submit then
					dialog_window_buttons.item ({ES_DIALOG_BUTTONS}.ok_button).enable_sensitive
				else
					dialog_window_buttons.item ({ES_DIALOG_BUTTONS}.ok_button).disable_sensitive
				end
			else
				login_frame.enable_sensitive
				report_frame.disable_sensitive
				dialog_window_buttons.item ({ES_DIALOG_BUTTONS}.ok_button).disable_sensitive
			end
		end

feature {NONE} -- User interface elements

	login_frame: EV_FRAME
			-- Login container frame

	logged_in_label: EV_LABEL
			-- Logged in message label

	log_out_link: EVS_LINK_LABEL
			-- Logged in message lable link to log ou

	username_text: EV_TEXT_FIELD
			-- Login username

	password_text: EV_PASSWORD_FIELD
			-- Login password

	remember_me_check: EV_CHECK_BUTTON
			-- Login remember me

	login_button: EV_BUTTON
			-- Login button

	report_frame: EV_FRAME
			-- Bug report container frame

	synopsis_text: EV_TEXT_FIELD
			-- Report synopsis

	description_text: EV_TEXT
			-- Report description

	make_public_check: EV_CHECK_BUTTON
			-- Report privacy option

	shrink_timer: EV_TIMEOUT
			-- Timer used to perform shrinking of login widgets

	shrink_interval: INTEGER = 3
			-- Default shink interval

	shrink_widget: EV_FIXED
			-- Shrink widget used to perform shinking

feature {NONE} -- Reporting

	synopsis: STRING_32
			-- Synopsis text
		require
			is_initialized: is_initialized or is_initializing
			not_is_recycled: not is_recycled
		local
			l_class_name: STRING
			l_recipient: STRING
			l_exceptions: EXCEPTIONS
		do
			create Result.make (100)

			if not is_initialized or else not is_synopsis_available then
				create l_exceptions
				Result.append ("Autoreport: ")
				Result.append (l_exceptions.meaning (l_exceptions.exception))
				Result.prune_all_trailing ('.')
				Result.append_character (' ')

				if l_exceptions.assertion_violation then
					Result.append ("Tag: ")
					Result.append (l_exceptions.tag_name)
					Result.append_character (' ')
				end

				l_class_name := l_exceptions.class_name
				if l_class_name /= Void then
					Result.append ("in [")
					Result.append (l_class_name)
					l_recipient := l_exceptions.recipient_name
					if l_recipient /= Void then
						Result.append_character ('.')
						Result.append (l_recipient)
					end
					Result.append_character (']')
				end

				Result.append (" in ")
				Result.append (workbench_name)
				Result.append_character ('.')
			else
				Result.append (synopsis_text.text)
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	description: STRING_32
			-- Description text
		require
			is_initialized: is_initialized or is_initializing
			not_is_recycled: not is_recycled
		local
			l_trace: STRING
			l_exceptions: EXCEPTIONS
		do
			create Result.make (512)
			if is_initialized and then is_description_available then
				Result.append (description_text.text)
				Result.prune_all_trailing ('%N')
				Result.append ("%N%N")
			end

			create l_exceptions
			l_trace := l_exceptions.exception_trace
			Result.append (l_trace)
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	submit_bug_report
			-- Submits a bug report.
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			support_login_is_logged_in: support_login.is_logged_in
		local
			l_report: COMM_SUPPORT_BUG_REPORT
			l_thanks: ES_INFORMATION_PROMPT
		do
			create l_report.make (synopsis, description, compiler_version_number.version)
			l_report.environment := workbench_name + " " + version_number
			l_report.to_reproduce := "Please see description"
			l_report.confidential := not make_public_check.is_selected

			support_login.report_bug (l_report)

			create l_thanks.make_standard ("The submitted report is not available at http://support.eiffel.com.")
			l_thanks.set_sub_title ("Thank you for the bug report")
			l_thanks.show (dialog)
		end

invariant
	support_reporter: support_login /= Void
	login_frame_attached: (is_initialized and not is_recycled) implies login_frame /= Void
	logged_in_label_attached: (is_initialized and not is_recycled) implies logged_in_label /= Void
	log_out_link_attached: (is_initialized and not is_recycled) implies log_out_link /= Void
	username_text_attached: (is_initialized and not is_recycled) implies username_text /= Void
	password_text_attached: (is_initialized and not is_recycled) implies password_text /= Void
	remember_me_check_attached: (is_initialized and not is_recycled) implies remember_me_check /= Void
	login_button_attached: (is_initialized and not is_recycled) implies login_button /= Void
	report_frame_attached: (is_initialized and not is_recycled) implies report_frame /= Void
	synopsis_text_attached: (is_initialized and not is_recycled) implies synopsis_text /= Void
	more_info_text_attached: (is_initialized and not is_recycled) implies description_text /= Void
	make_public_check_attached: (is_initialized and not is_recycled) implies make_public_check /= Void
	shrink_timer_attached: (is_initialized and not is_recycled) implies shrink_timer /= Void
	shrink_widget_attached: (is_initialized and not is_recycled) implies shrink_widget /= Void
	shrink_interval_positive: shrink_interval > 0

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
