indexing
	description: "[
						Bug report submitting dialog when an exception happens.
						This dialog can submit a bug report to http://support.eiffel.com without opening a web browser.
																														]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXCEPTION_SUBMIT_DIALOG

inherit
	EB_DIALOG

	SYSTEM_CONSTANTS
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	EB_SHARED_MANAGERS
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation method
		do
			default_create
			init_ui

			show_actions.extend_kamikaze (agent username.set_focus)
		end

	init_ui is
			-- Create UI components.
		local
			l_vertical_box: EV_VERTICAL_BOX
			l_horizontal_box: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
		do
			set_title ("Report Bug")

			create l_vertical_box
			l_vertical_box.set_padding (layout_constant.default_padding_size)
			l_vertical_box.set_border_width (layout_constant.default_border_size)
			extend (l_vertical_box)

			-- First information line
			create l_horizontal_box
			l_vertical_box.extend (l_horizontal_box)
			l_vertical_box.disable_item_expand (l_horizontal_box)

			create l_label.make_with_text ("The result available at: ")
			l_horizontal_box.extend (l_label)
			l_horizontal_box.disable_item_expand (l_label)

			create l_label.make_with_text ("http://support.eiffel.com")
			init_link_label (l_label, "http://support.eiffel.com")
			l_horizontal_box.extend (l_label)
			l_horizontal_box.disable_item_expand (l_label)

			create l_label.make_with_text (".")
			l_horizontal_box.extend (l_label)
			l_horizontal_box.disable_item_expand (l_label)

			-- Second information line
			create l_horizontal_box
			l_vertical_box.extend (l_horizontal_box)
			l_vertical_box.disable_item_expand (l_horizontal_box)

			create l_label.make_with_text ("For the information we collected. See our ")
			l_horizontal_box.extend (l_label)
			l_horizontal_box.disable_item_expand (l_label)

			create l_label.make_with_text ("private policy")
			init_link_label (l_label, "http://www.eiffel.com/general/privacy_policy.html")
			l_horizontal_box.extend (l_label)
			l_horizontal_box.disable_item_expand (l_label)

			create l_label.make_with_text (".")
			l_horizontal_box.extend (l_label)
			l_horizontal_box.disable_item_expand (l_label)

			-- Third information line
			-- Maybe we should add a line:
			-- To view what data this error report contains, click here.

			-- 4th information line
			create l_horizontal_box
			l_vertical_box.extend (l_horizontal_box)
			l_vertical_box.disable_item_expand (l_horizontal_box)

			create l_label.make_with_text ("If you don't have Eiffel Software support site id, please ")
			l_horizontal_box.extend (l_label)
			l_horizontal_box.disable_item_expand (l_label)

			create l_label.make_with_text ("register")
			init_link_label (l_label, "https://www2.eiffel.com/login/secure/register.aspx")
			l_horizontal_box.extend (l_label)
			l_horizontal_box.disable_item_expand (l_label)

			create l_label.make_with_text (" first.")
			l_horizontal_box.extend (l_label)
			l_horizontal_box.disable_item_expand (l_label)

			create l_horizontal_box
			l_horizontal_box.set_padding (layout_constant.default_padding_size)
			l_vertical_box.extend (l_horizontal_box)
			l_vertical_box.disable_item_expand (l_horizontal_box)

			create l_label.make_with_text ("Username:")
			l_horizontal_box.extend (l_label)
			l_horizontal_box.disable_item_expand (l_label)

			create username
			username.set_minimum_width (text_field_width)
			l_horizontal_box.extend (username)
			l_horizontal_box.disable_item_expand (username)

			create l_label.make_with_text ("Password:")
			l_horizontal_box.extend (l_label)
			l_horizontal_box.disable_item_expand (l_label)

			create password
			password.set_minimum_width (text_field_width)
			l_horizontal_box.extend (password)
			l_horizontal_box.disable_item_expand (password)

			create submit.make_with_text_and_action ("Submit", agent on_submit)
			layout_constant.set_default_width_for_button (submit)
			l_horizontal_box.extend (submit)
			l_horizontal_box.disable_item_expand (submit)

			create cancel.make_with_text_and_action ("Cancel", agent on_cancel)
			layout_constant.set_default_width_for_button (cancel)
			l_horizontal_box.extend (cancel)
			l_horizontal_box.disable_item_expand (cancel)

			set_default_push_button (submit)
			-- We need following line to show top right close button.
			set_default_cancel_button (cancel)
		end

	init_link_label (a_label: EV_LABEL; a_url: STRING) is
			-- Set a `a_label' actions, then it can works as a link.
		require
			not_void: a_label /= Void
			not_void: a_url /= Void
		local
			l_stock_pixmaps: EV_STOCK_PIXMAPS
		do
			a_label.set_foreground_color ((create {EV_STOCK_COLORS}).blue)
			
			create l_stock_pixmaps
			a_label.set_pointer_style (l_stock_pixmaps.hyperlink_cursor)

			a_label.pointer_button_press_actions.force_extend (agent open_url (a_url))
			a_label.pointer_enter_actions.extend (agent (a_label_to_init: EV_LABEL)
														local
															l_font: EV_FONT
														do
															l_font := a_label_to_init.font
															l_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
															a_label_to_init.set_font (l_font)
														end (a_label))
			a_label.pointer_leave_actions.extend (agent (a_label_to_init: EV_LABEL)
														local
															l_font: EV_FONT
														do
															l_font := a_label_to_init.font
															l_font.set_weight ({EV_FONT_CONSTANTS}.weight_regular)
															a_label_to_init.set_font (l_font)
														end (a_label))
		end

feature -- Command

	set_exception_trace (a_string: STRING_GENERAL) is
			-- Set `exception_trace' with `a_string'.
		require
			not_void: a_string /= Void
		do
			exception_trace := a_string
		ensure
			set: exception_trace = a_string
		end

	open_url (a_url: STRING) is
			-- Open `a_dir' in browser.
		require
			a_dir_not_void: a_url /= Void
			a_dir_not_empty: not a_url.is_empty
		local
			prc_launcher: EB_PROCESS_LAUNCHER
		do
			prc_launcher := external_launcher
			prc_launcher.open_dir_in_file_browser (a_url)
		end

feature -- Query

	exception_trace: STRING_GENERAL
			-- Exception trace

feature {NONE} -- Implementation

	on_submit is
			-- Handle sumit button pressed action.
		require
			set: exception_trace /= Void
		local
			l_filler: BUG_REPORT_FILLER
			l_dialog: ES_INFORMATION_PROMPT
		do
			if username.text.is_empty or password.text.is_empty then
				on_blank_username_password
			else
				create l_filler.make
				l_filler.login_failed_actions.extend (agent on_login_fail)
				l_filler.curl_failed_actions.extend (agent on_curl_fail)
				l_filler.fill_report (prepare_data)

				if not is_failed and then l_filler.last_result = {CURL_CODES}.curle_ok then
					create l_dialog.make_standard ("Your bug report is submitted.")
					l_dialog.show (Current)
					destroy
				end
			end
		end

	on_cancel is
			-- Handel cancel button pressed action.
		do
			destroy
		end

	on_login_fail is
			-- Notify end user login failed.
		local
			l_dialog: ES_WARNING_PROMPT
		do
			is_failed := True
			create l_dialog.make_standard ("Login failed. Please make sure your username and password are correct.")
			l_dialog.show (Current)
			destroy
		end

	on_curl_fail (a_exception: STRING) is
			-- Handle cURL exceptions.
		require
			not_void: a_exception /= Void
		local
			l_dialog: ES_WARNING_PROMPT
		do
			is_failed := True
			create l_dialog.make_standard ("Failed when submitting bug report.%N" + a_exception)
			l_dialog.show (Current)
			destroy
		end

	on_blank_username_password is
			-- Handle the case username/password not inputed.
		local
			l_warning: ES_WARNING_PROMPT
		do
			create l_warning.make_standard ("Please enter username and password first.")
			l_warning.show (Current)
		end

	prepare_data: BUG_REPORT_DATA is
			-- Filling a bug report form data.
		require
			not_void: exception_trace /= Void
		local
			l_platform: STRING
			l_version_number: STRING
			l_class_name: STRING
			l_exceptions: EXCEPTIONS
		do
			create Result
			Result.set_description (exception_trace)
			l_platform := eiffel_layout.eiffel_platform
			Result.set_environment (l_platform)
			Result.set_password (password.text)
			l_version_number := version_number
			l_version_number.replace_substring_all (" - " + l_platform, "")
			Result.set_release (l_version_number)

			create l_exceptions
			l_class_name := l_exceptions.class_name
			Result.set_synopsis ("[" + l_class_name + "] crashes in Eiffel Studio.")

			Result.set_to_reproduce ("")
			Result.set_username (username.text)
		ensure
			not_void: Result /= Void
			ready: Result.is_all_data_filled
		end

feature {NONE} -- UI implementations

	username: EV_TEXT_FIELD
			-- Text field where end user input username.

	password: EV_PASSWORD_FIELD
			-- Text field where end user inout password.

	cancel: EV_BUTTON
			-- Button to cancel current operation

	submit: EV_BUTTON
			-- Button to submit

	text_field_width: INTEGER is 100
			-- Text field minimum width.

	layout_constant: EV_LAYOUT_CONSTANTS is
			-- Layout constants.
		once
			create Result
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Attributes

	filler: BUG_REPORT_FILLER
			-- Filler which using cURL library.

	is_failed: BOOLEAN;
			-- If bug report fail action been called?

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

end -- class EB_EXCEPTION_SUBMIT_DIALOG
