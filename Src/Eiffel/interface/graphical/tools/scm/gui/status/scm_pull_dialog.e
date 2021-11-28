note
	description: "[
		PULL dialog, for now, only git, but in the future, it could be used for any distributed SCM.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_PULL_DIALOG

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

			create remotes_combo
			create remote_custom

			create progress_log_box
			create progress_log_text

			create remotes_box
			make_dialog
		end

feature -- Access

	scm_service: SOURCE_CONTROL_MANAGEMENT_S

	parent_box: SCM_STATUS_BOX

	distributed_location: SCM_GIT_LOCATION

feature -- Widgets

	remotes_box: EV_VERTICAL_BOX

	remotes_combo: EV_COMBO_BOX

	remote_custom: EV_TEXT_FIELD

	is_custom_remote: BOOLEAN

	branches_text: EV_TEXT

	branches_box: EV_VERTICAL_BOX

	branches_combo: EV_COMBO_BOX

	progress_log_box: EV_VERTICAL_BOX

	progress_log_text: EV_TEXT

	use_external_terminal_checkbutton: EV_CHECK_BUTTON

	use_external_terminal: BOOLEAN
		do
			Result := use_external_terminal_checkbutton.is_selected
		end

feature -- Element change

	set_is_custom_remote (b: BOOLEAN)
		do
			is_custom_remote := b
			if b then
				remotes_combo.hide
				remote_custom.show
			else
				remote_custom.hide
				remotes_combo.show
			end
		end

feature {NONE} -- User interface initialization

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			br_cbox, rem_cbox: like remotes_combo
			l_remote_name: READABLE_STRING_GENERAL
			radio, radio_custom: EV_RADIO_BUTTON
			fb, b: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
--			f: EV_FRAME
			tf: EV_TEXT_FIELD
			sp: EV_VERTICAL_SPLIT_AREA
			txt: EV_TEXT
			s: STRING_32
			lab: EV_LABEL
			li: EV_LIST_ITEM
			l_curr_branch: detachable READABLE_STRING_32
			l_up_branch: detachable READABLE_STRING_8
			l_up_repo: detachable READABLE_STRING_8
			cb: like use_external_terminal_checkbutton
		do
			create sp
			a_container.extend (sp)

				-- Control box.
			create fb
			sp.extend (fb)
			fb.set_padding_width (default_padding_size)
			fb.set_border_width (default_border_size)

			b := remotes_box
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
							l_curr_branch := br.name
							if attached br.upstream_remote as upr then
								l_up_repo := upr.repository
								l_up_branch := upr.branch
							end
							li.enable_select
						end
					end
				end
			end
				-- Known remote
			create hb
			extend_non_expandable_to (b, hb)
			create radio.make_with_text (scm_names.label_branches)
			br_cbox.set_minimum_width_in_characters (20)
			extend_expandable_to (hb, br_cbox)

				-- Remotes info
			create lab.make_with_text (scm_names.label_remote_repositories)
			lab.align_text_left
			b.extend (lab)
			b.disable_item_expand (lab)

			rem_cbox := remotes_combo

			if attached distributed_location.remotes (scm_service.config) as lst then
				across
					lst as ic_remote
				loop
					l_remote_name := ic_remote.item.name
					create s.make_from_string_general (l_remote_name)
					if attached ic_remote.item.location as loc then
						s.append_character (' ')
						s.append_character ('(')
						s.append_string_general (loc)
						s.append_character (')')
					end

					create li.make_with_text (s)
					li.set_data ([l_remote_name, ic_remote.item.location])
					rem_cbox.extend (li)
					if l_up_repo /= Void and then l_up_repo.is_case_insensitive_equal_general (l_remote_name) then
						li.enable_select
					end
				end
			end

			create hb
				-- Remotes
			extend_non_expandable_to (b, hb)

			rem_cbox.set_minimum_width_in_characters (20)
			extend_expandable_to (hb, rem_cbox)

			tf := remote_custom
			tf.set_minimum_width_in_characters (20)
			extend_expandable_to (hb, tf)

			rem_cbox.show
			tf.hide

			create hb
				-- Remote kinds
			extend_non_expandable_to (b, hb)


			create radio.make_with_text (scm_names.label_remote)
			radio.select_actions.extend (agent (i_radio: EV_RADIO_BUTTON)
					do
						set_is_custom_remote (not i_radio.is_selected)
					end(radio))
			extend_non_expandable_to (hb, radio)

			create radio_custom.make_with_text (scm_names.label_remote_custom_location)
			radio_custom.select_actions.extend (agent (i_radio: EV_RADIO_BUTTON)
					do
						set_is_custom_remote (i_radio.is_selected)
					end(radio_custom))
			extend_non_expandable_to (hb, radio_custom)


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

			set_button_text (dialog_buttons.ok_button, scm_names.button_pull)
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
			l_remote, l_branch: READABLE_STRING_32
			l_unsupported_remote: BOOLEAN
			l_pull: SCM_PULL_OPERATION
--			l_remote_uri: URI
			l_cmd: STRING_32
--			l_credentials: TUPLE [username, password: detachable READABLE_STRING_GENERAL]
			l_use_external_terminal: like use_external_terminal
		do
			if attached button_pull as but then
				but.show
			end
			if attached button_close as but then
				but.show
			end

			l_pointer_style := dialog.pointer_style
			dialog.set_pointer_style ((create {EV_STOCK_PIXMAPS}).busy_cursor)

			if is_custom_remote then
				l_remote := remote_custom.text
			else
				if
					attached remotes_combo.selected_item as li and then
					attached {TUPLE [name: READABLE_STRING_GENERAL; location: detachable READABLE_STRING_GENERAL]} li.data as rem
				then
					if attached rem.location as remloc then
--						l_remote := remloc
						l_remote := rem.name
					else
						l_remote := rem.name
					end
				else
					l_remote := remotes_combo.text
				end
			end

			l_use_external_terminal := use_external_terminal

--			if l_remote.starts_with_general ("http://") or l_remote.starts_with_general ("https://") then
--				create l_remote_uri.make_from_string (l_remote)
--				if l_remote_uri.is_valid and then l_remote.same_string (l_remote_uri.string) then
--					if not attached l_remote_uri.username_password then
--						create l_credentials
--						ask_for_credential (l_credentials)
--						if
--							attached l_credentials.username as u and
--							attached l_credentials.password as p
--						then
--							l_remote_uri.set_username_password (u, p)
--						end
--					end
--					l_remote := l_remote_uri.string
--				else
--					l_remote_uri := Void
--					l_unsupported_remote := True
--				end
--			end

			l_branch := branches_combo.text

			if l_unsupported_remote then
				l_pull.report_error ({STRING_32} "Unsupported remote location: " + l_remote)
			else
				create l_pull.make (distributed_location, l_remote, l_branch)
				if l_use_external_terminal then
					l_cmd := scm_service.pull_command_line (l_pull)
					process_external_command (l_cmd, l_pull.root_location.location)
					l_pull.report_success ("Check the terminal for more information.")
				else
					scm_service.pull (l_pull)
				end
			end

			dialog.set_pointer_style (l_pointer_style)

			remotes_box.hide
			progress_log_box.show

			if attached l_pull.execution_message as m then
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
				if attached button_pull as but then
					but.hide
				end
				if attached button_cancel as but then
					but.hide
				end
			end

			veto_close
		end

--	ask_for_credential (a_credentials: TUPLE [username, password: detachable READABLE_STRING_GENERAL])
--		do

--		end

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
			Result := scm_names.title_scm_pull
		end

	button_pull: detachable EV_BUTTON
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
			Result.put_last (dialog_buttons.ok_button) -- Push
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
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
