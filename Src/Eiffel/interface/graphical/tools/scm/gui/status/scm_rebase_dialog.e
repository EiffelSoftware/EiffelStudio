note
	description: "[
		REBASE dialog, for now, only git, but in the future, it could be used for any distributed SCM.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_REBASE_DIALOG

inherit
	ES_DIALOG
		rename
			make as make_dialog
		redefine
			is_size_and_position_remembered
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

	SHARED_SCM_NAMES

	EV_LAYOUT_CONSTANTS

	SHARED_EXECUTION_ENVIRONMENT

create
	make

convert
	dialog: {EV_DIALOG}

feature {NONE} -- Initialization

	make (a_service: SOURCE_CONTROL_MANAGEMENT_S; a_git_location: SCM_GIT_LOCATION; a_parent_box: SCM_STATUS_BOX)
		do
			parent_box := a_parent_box
			scm_service := a_service
			distributed_location := a_git_location

			create use_external_terminal_checkbutton.make_with_text (scm_names.checkbutton_use_external_terminal)

			create branches_combo
			create branches_box

			create progress_log_box
			create progress_log_text

			make_dialog
		end

feature -- Access

	scm_service: SOURCE_CONTROL_MANAGEMENT_S

	parent_box: SCM_STATUS_BOX

	distributed_location: SCM_GIT_LOCATION

feature -- Widgets

	branches_box: EV_VERTICAL_BOX

	branches_combo: EV_COMBO_BOX

	progress_log_box: EV_VERTICAL_BOX

	progress_log_text: SCM_TEXT

	use_external_terminal_checkbutton: EV_CHECK_BUTTON

	use_external_terminal: BOOLEAN
		do
			Result := use_external_terminal_checkbutton.is_selected
		end

feature {NONE} -- User interface initialization

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			br_cbox: like branches_combo
			radio: EV_RADIO_BUTTON
			fb, b: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
--			f: EV_FRAME
			sp: EV_VERTICAL_SPLIT_AREA
			txt: EV_TEXT
			lab: EV_LABEL
			li: EV_LIST_ITEM
			cb: like use_external_terminal_checkbutton
		do
			create sp
			a_container.extend (sp)

				-- Control box.
			create fb
			sp.extend (fb)
			fb.set_padding_width (default_padding_size)
			fb.set_border_width (default_border_size)

			b := branches_box
			fb.extend (b)
			b.set_padding_width (small_padding_size)
			b.set_border_width (small_border_size)


				-- Branches
			create lab.make_with_text (scm_names.label_branches)
			lab.align_text_left
			b.extend (lab)
			b.disable_item_expand (lab)

			br_cbox := branches_combo
			if attached distributed_location.branches (scm_service.config) as lst then
				across
					lst as ic_branch
				loop
					if attached ic_branch.item as br then
						create li.make_with_text (br.name)
						br_cbox.extend (li)
						if br.is_active then
							li.enable_select
						end
					end
				end
			end

			create hb
			extend_non_expandable_to (b, hb)
			create radio.make_with_text (scm_names.label_branches)
			br_cbox.set_minimum_width_in_characters (20)
			extend_expandable_to (hb, br_cbox)

			extend_non_expandable_to (hb, create {EV_HORIZONTAL_SEPARATOR})
			cb := use_external_terminal_checkbutton
			extend_non_expandable_to (b, cb)
			cb.enable_select
			create lab.make_with_text ("Warning: this is an experimental implementation.%NAdditional operations may be needed in terminal/console.")
			lab.set_foreground_color (colors.high_priority_foreground_color)
			extend_non_expandable_to (b, lab)

			b := progress_log_box
			fb.extend (b)
			b.set_padding_width (small_padding_size)
			b.set_border_width (small_border_size)

			create lab.make_with_text (scm_names.label_operation_logs)
			lab.align_text_left
			b.extend (lab)
			b.disable_item_expand (lab)

			txt := progress_log_text
			txt.disable_edit
			b.extend (txt)

			b.hide

			show_actions.extend_kamikaze (agent (i_sp: EV_VERTICAL_SPLIT_AREA)
						do
							i_sp.set_proportion (0.75)
							ev_application.add_idle_action_kamikaze (agent i_sp.set_proportion (0.75))
						end (sp)
				)

			if attached button_close as but then
				but.hide
			end

			set_button_text (dialog_buttons.ok_button, scm_names.button_rebase)
			set_button_text (dialog_buttons.close_button, interface_names.b_close)
			set_button_text (dialog_buttons.cancel_button, interface_names.b_cancel)

			set_button_action_before_close (dialog_buttons.ok_button, agent on_ok)
			set_button_action_before_close (dialog_buttons.close_button, agent on_close)
			set_button_action_before_close (dialog_buttons.cancel_button, agent on_cancel)

			progress_log_box.hide
		end

feature -- Access: Help

	help_context_id: STRING_32
			-- <Precursor>
		once
			Result := {STRING_32} "6109AFC3-43A4-4524-9ED8-C02B486CABAF"
				-- Same as {ES_SCM_TOOL_PANEL}.help_context_id
		end

feature {NONE} -- Helpers

	register_input_widget (aw: EV_WIDGET)
			-- Register `aw' as an input widget
		do
			suppress_confirmation_key_close (aw)
		end

	extend_non_expandable_to (b: EV_BOX; w: EV_WIDGET)
			-- Extend `w' to `b', and disable expand
		do
			extend_to (b, w, False)
		end

	extend_expandable_to (b: EV_BOX; w: EV_WIDGET)
			-- Extend `w' to `b', and disable expand
		do
			extend_to (b, w, True)
		end

	extend_to (b: EV_BOX; w: EV_WIDGET; is_expandable: BOOLEAN)
			-- Extend `w' to `b', and keep expand enabled (default)
		do
			b.extend (w)
			if not is_expandable then
				b.disable_item_expand (w)
			end
		end

feature -- Action

	set_size (w, h: INTEGER)
		do
			dialog.set_size (w, h)
		end

	error_background_color: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (255, 210, 210)
		end

	notify_error_on_text_field (a_tf: EV_TEXT_FIELD)
			--
		local
			col: EV_COLOR
		do
			col := a_tf.background_color
			a_tf.set_background_color (error_background_color)
			a_tf.key_press_actions.extend_kamikaze (agent (atf: EV_TEXT_FIELD; acol: EV_COLOR; akey: EV_KEY)
						do
							atf.set_background_color (acol)
						end (a_tf, col, ?)
				)
		end

	on_ok
		local
			err: BOOLEAN
			l_pointer_style: detachable EV_POINTER_STYLE
			l_branch: READABLE_STRING_32
			l_rebase: SCM_REBASE_OPERATION
			l_cmd: STRING_32
			l_use_external_terminal: like use_external_terminal
		do
			if attached button_rebase as but then
				but.show
			end
			if attached button_close as but then
				but.show
			end

			l_pointer_style := dialog.pointer_style
			dialog.set_pointer_style ((create {EV_STOCK_PIXMAPS}).busy_cursor)

			l_use_external_terminal := use_external_terminal

			l_branch := branches_combo.text

			create l_rebase.make (distributed_location, l_branch)
			if l_use_external_terminal then
				l_cmd := scm_service.rebase_command_line (l_rebase)
				process_external_command (l_cmd, l_rebase.root_location.location)
				l_rebase.report_success ("Check the terminal for more information.")
			else
				scm_service.rebase (l_rebase)
			end

			dialog.set_pointer_style (l_pointer_style)

			branches_box.hide
			progress_log_box.show

			if attached l_rebase.execution_message as m then
				progress_log_text.set_text (m)
			else
				progress_log_text.set_text (scm_names.text_no_output)
			end

			if err then
				if attached button_close as but then
					but.hide
				end
				if attached button_cancel as but then
					but.show
				end
			else
				if attached button_rebase as but then
					but.hide
				end
				if attached button_cancel as but then
					but.hide
				end
			end

			veto_close
		end

	process_external_command (a_command_line: READABLE_STRING_GENERAL; a_working_dir: PATH)
		local
			cl: STRING_32
			l_old_path: PATH
		do
			if attached preferences.misc_data.execute_in_console_shell_command (a_command_line) as l_console_shell then
				cl := l_console_shell
			else
				cl := a_command_line
			end
			l_old_path := Execution_environment.current_working_path
			Execution_environment.change_working_path (a_working_dir)
			Execution_environment.system (cl)
			Execution_environment.change_working_path (l_old_path)
		end

	on_close
		do
		end

	on_cancel
		do
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		do
			Result := stock_pixmaps.source_version_control_icon_buffer
		end

	title: STRING_32
			-- <Precursor>
		do
			Result := scm_names.title_scm_rebase
		end

	button_rebase: detachable EV_BUTTON
		do
			Result := dialog_window_buttons [dialog_buttons.ok_button]
		end
	button_close: detachable EV_BUTTON
		do
			Result := dialog_window_buttons [dialog_buttons.close_button]
		end
	button_cancel: detachable EV_BUTTON
		do
			Result := dialog_window_buttons [dialog_buttons.cancel_button]
		end

	buttons: DS_HASH_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		once
			create Result.make (3)
			Result.put_last (dialog_buttons.ok_button) -- Rebase
			Result.put_last (dialog_buttons.close_button) -- Close
			Result.put_last (dialog_buttons.cancel_button) -- Cancel
		end

	default_button: INTEGER
			-- The dialog's default action button
		once
			Result := dialog_buttons.cancel_button
		end

	default_cancel_button: INTEGER
			-- The dialog's default cancel button
		once
			Result := dialog_buttons.cancel_button
		end

	default_confirm_button: INTEGER
			-- The dialog's default confirm button
		once
			Result := dialog_buttons.ok_button
		end

	is_size_and_position_remembered: BOOLEAN = True
			-- Indicates if the size and position information is remembered for the dialog
;

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
