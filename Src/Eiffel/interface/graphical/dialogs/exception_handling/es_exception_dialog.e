note
	description: "[
		Handles capture and display of an unhandled EiffelStudio exception.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	ES_EXCEPTION_DIALOG

inherit
	ES_ERROR_PROMPT
		rename
			make as make_prompt
		redefine
			on_before_initialize,
			build_prompt_interface,
			internal_recycle,
			standard_buttons,
			standard_default_button,
			standard_default_confirm_button,
			standard_default_cancel_button
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialize

	make
			-- Initializes the exception dialog prompt
		do
			make_standard ((create {WARNING_MESSAGES}).w_internal_error)
			set_sub_title ("Internal EiffelStudio Exception")

				-- Set dialog button text and actions
			set_button_text (ignore_button, "Ignore")
			set_button_action (ignore_button, agent on_ignore)

			set_button_text (restart_now_button, "Restart Now")
			set_button_action (restart_now_button, agent on_restart_now)

			set_button_text (quit_button, "Quit")
			set_button_action (quit_button, agent on_quit)

				-- Allow dialog to be resized so user is able to see the full trace.
			dialog.enable_user_resize
		end

	on_before_initialize
            -- Use to perform additional creation initializations, before the UI has been created.
			-- Note: No user interface initialization should be done here! Use `build_dialog_interface' instead
		do
			Precursor {ES_ERROR_PROMPT}
			create support_login.make
		end

	build_prompt_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			l_box: EV_HORIZONTAL_BOX
			l_layout: EV_LAYOUT_CONSTANTS
		do
			Precursor {ES_ERROR_PROMPT} (a_container)
			a_container.set_padding ({ES_UI_CONSTANTS}.dialog_button_vertical_padding)

			create l_layout

				-- Trace message
			create l_box
			l_box.set_border_width (1)
				-- Change color on show as the prompt BG color is propagated and will remove
				-- any set color.
			register_kamikaze_action (show_actions, agent l_box.set_background_color (colors.stock_colors.black))

			create exception_text_panel
			exception_text_panel.set_cursors (create {EB_EDITOR_CURSORS})
			exception_text_panel.disable_line_numbers
			exception_text_panel.widget.set_minimum_size (400, 165)
			if
				is_interface_usable and then
				(internal_development_window /= Void or else (is_initialized or is_initializing))
			then
				if attached development_window as l_dev_win then
					exception_text_panel.editor_drawing_area.set_pebble_function (agent : ANY do Result := Current end)
					exception_text_panel.editor_drawing_area.set_configurable_target_menu_mode
					exception_text_panel.editor_drawing_area.set_configurable_target_menu_handler (agent (l_dev_win.menus.context_menu_factory).exeception_dialog_menu (?, ?, ?, ?, exception_text_panel))
				end
			end
			if trace /= Void then
				resize_exception_text_panel
				exception_text_panel.load_text (trace)
			end
			l_box.extend (exception_text_panel.widget)
			a_container.extend (l_box)

				-- Trace operation buttons
			create l_box
			l_box.set_padding ({ES_UI_CONSTANTS}.dialog_button_horizontal_padding)
			l_box.extend (create {EV_CELL})

				-- Report button
			create submit_bug_button.make_with_text ("Submit Bug")
			l_layout.set_default_width_for_button (submit_bug_button)
			register_action (submit_bug_button.select_actions, agent on_submit_bug)
			l_box.extend (submit_bug_button)
			l_box.disable_item_expand (submit_bug_button)

				-- Save button
			create save_button.make_with_text ("Save Trace")
			l_layout.set_default_width_for_button (save_button)
			register_action (save_button.select_actions, agent on_save_trace)
			l_box.extend (save_button)
			l_box.disable_item_expand (save_button)

			if not support_login.is_support_accessible then
					-- Do not have access to cURL
				submit_bug_button.disable_sensitive
			end

			a_container.extend (l_box)
			a_container.disable_item_expand (l_box)
		end

feature {NONE} -- Clean up

	internal_recycle
			-- To be called when the button has became useless.
		do
			if is_initialized then
				support_login.dispose
				support_login := Void
			end
			Precursor {ES_ERROR_PROMPT}
		end

feature -- Access

	trace: STRING_32
			-- Exception trace message

	last_description: detachable STRING
			-- Last description for submitting bug report
			-- Maybe void if not recorded

	support_login: COMM_SUPPORT_BUG_REPORTER
			-- Support site login proxy communicator

feature {NONE} -- Access

	standard_buttons: DS_HASH_SET [INTEGER]
			-- Standard set of buttons for a current prompt
		once
			create Result.make (3)
			Result.put_last (ignore_button)
			Result.put_last (restart_now_button)
			Result.put_last (quit_button)
		end

	standard_default_button: INTEGER
			-- Standard buttons `standard_buttons' default button
		once
			Result := restart_now_button
		end

	standard_default_confirm_button: INTEGER
			-- Standard buttons `standard_buttons' default confirm button
		once
			Result := restart_now_button
		end

	standard_default_cancel_button: INTEGER
			-- Standard buttons `standard_buttons' default cancel button
		once
			Result := ignore_button
		end

feature -- Element change

	set_trace (a_trace: like trace)
			-- Set display trace information
		require
			not_is_recycled: not is_recycled
			a_trace_attached: a_trace /= Void
			not_a_trace_is_empty: not a_trace.is_empty
		do
			trace := a_trace
			if is_initialized then
				resize_exception_text_panel
				exception_text_panel.load_text (a_trace)
			end
		ensure
			trace_set: trace = a_trace
		end

feature {NONE} -- Basic operations

	resize_exception_text_panel
			-- Resizes the exception text panel to match that of the the trace text
		require
			is_initialized: is_initialized or is_initializing
			not_is_recycled: not is_recycled
			exception_text_panel_attached: exception_text_panel /= Void
		local
			l_width: INTEGER
		do
			l_width := (exception_text_panel.left_margin_width * 2) + exception_text_panel.font.string_width (trace) + exception_text_panel.vertical_scrollbar.width
			l_width := l_width.min ({ES_UI_CONSTANTS}.dialog_maximum_width)
			exception_text_panel.widget.set_minimum_width (l_width)
		end

feature {NONE} -- User interface elements

	exception_text_panel: SELECTABLE_TEXT_PANEL
			-- Widget diaplying exception log

	save_button: EV_BUTTON
			-- Button to save trace message

	submit_bug_button: EV_BUTTON
			-- Button to submit error to the bug report system

feature {NONE} -- Action handlers

	on_ignore
			-- Called when the user selects the Ignore button
		do
			--| Do nothing
		end

	on_restart_now
			-- Called when the user selects the Restart button
		do
				-- Launch new EiffelStudio process
			(create {COMMAND_EXECUTOR}).execute (eiffel_layout.studio_command_line (Void, Void, Void, True, False))

				-- Perform quit of current process
			on_quit
		end

	on_quit
			-- Called when the user selects the Quit button
		do
			(create {EXCEPTIONS}).die (-1)
		end

	on_save_trace
			-- Called when the user selects the Save Trace button
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		local
			l_save_dialog: EB_FILE_SAVE_DIALOG
			l_file: PLAIN_TEXT_FILE
			l_pref: PATH_PREFERENCE
			l_error: ES_ERROR_PROMPT
			l_constants: EB_FILE_DIALOG_CONSTANTS
			retried: BOOLEAN
		do
			if not retried then
				l_pref := preferences.dialog_data.last_saved_exception_directory_preference
				if l_pref.value = Void or else l_pref.value.is_empty then
					l_pref.set_value ((create {EIFFEL_LAYOUT}).eiffel_layout.user_projects_path)
				end
				create l_save_dialog.make_with_preference (l_pref)
				create l_constants
				l_constants.set_dialog_filters_and_add_all (l_save_dialog, <<l_constants.text_files_filter>>)
				l_save_dialog.show_modal_to_window (dialog)
				if not l_save_dialog.file_name.is_empty then
					create l_file.make_open_write (l_save_dialog.file_name)
					l_file.put_string (trace)
					l_file.close
				end
			else
				if l_save_dialog /= Void and then l_save_dialog.file_name /= Void then
					create l_error.make_standard ((create {WARNING_MESSAGES}).w_cannot_save_file (l_save_dialog.file_name))
				else
					create l_error.make_standard ((create {WARNING_MESSAGES}).w_cannot_save_file (Void))
				end
				l_error.show (dialog)
			end
		rescue
			retried := True
			retry
		end

	on_submit_bug
			-- Called when the user selects the Submit Bug button
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			support_login_attached: support_login /= Void
			support_login_is_support_accessible: support_login.is_support_accessible
		local
			l_dialog: ES_EXCEPTION_SUBMIT_DIALOG
			l_description: like last_description
			l_message: detachable STRING_GENERAL
		do
			l_description := last_description
			if not attached l_description then
					-- No previously set description, create a system description.
				create l_description.make (300)

				l_description.append_character ('%N')
				l_description.append_character ('%N')
				l_description.append (locale_formatter.formatted_translation (lb_project_loaded, [workbench.system_defined]))
				l_description.append_character ('%N')
				if workbench.system_defined then
					l_description.append (locale_formatter.formatted_translation (lb_was_compiled, [workbench.is_already_compiled]))
					l_description.append_character ('%N')
					l_description.append (locale_formatter.formatted_translation (lb_is_compiling, [workbench.is_compiling]))
					l_description.append_character ('%N')
					if workbench.is_compiling then
						l_description.append (locale_formatter.formatted_translation (lb_last_degree, [workbench.last_reached_degree]))
						l_description.append_character ('%N')
					end

					if attached workbench.system.current_class as l_class then
						l_description.append (locale_formatter.formatted_translation (lb_last_processed_class, [l_class.name]))
						l_description.append_character ('%N')
					end
				end
				if attached development_window as l_win then
					if attached l_win.status_bar as l_status_bar then
						l_message := l_status_bar.message
					end
				end

				if attached l_message and then not l_message.is_empty then
					l_description.append (locale_formatter.formatted_translation (lb_status_bar_text, [l_message]))
					l_description.append_character ('%N')
				end
				last_description := l_description
			end
			create l_dialog.make (support_login, l_description)
			l_dialog.show (dialog)
			if l_dialog.dialog_result = l_dialog.dialog_buttons.ok_button then
				if l_dialog.is_submit_successed then
					submit_bug_button.disable_sensitive
				else
					last_description := l_dialog.user_description
				end
			end
		end

feature -- Button constants

	ignore_button: INTEGER
			-- Button id for the Ignore dialog button
		once
			Result := {ES_DIALOG_BUTTONS}.yes_button
		end

	restart_now_button: INTEGER
			-- Button id for the Restart Now dialog button
		once
			Result := {ES_DIALOG_BUTTONS}.no_button
		end

	quit_button: INTEGER
			-- Button id for the Quit dialog button
		once
			Result := {ES_DIALOG_BUTTONS}.cancel_button
		end

feature {NONE} -- Internationalization

	lb_project_loaded: STRING = "Project loaded: $1"
	lb_was_compiled: STRING = "Project compiled: $1"
	lb_is_compiling: STRING = "Is compiling: $1"
	lb_last_degree: STRING = "Last compilation degree: $1"
	lb_last_processed_class: STRING = "Last known class processed: $1"
	lb_status_bar_text: STRING = "Last status message: $1"

invariant
	support_login_attached: is_interface_usable implies support_login /= Void

;note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
