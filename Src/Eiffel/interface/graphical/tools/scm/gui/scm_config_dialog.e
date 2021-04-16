note
	description: "Summary description for {SCM_PREFERENCES_DIALOG}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_CONFIG_DIALOG

inherit
	ES_DIALOG
		rename
			make as make_dialog
		redefine
			is_size_and_position_remembered
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES

	SHARED_SCM_NAMES

	EV_LAYOUT_CONSTANTS

create
	make

convert
	dialog: {EV_DIALOG}

feature {NONE} -- Initialization

	make (a_service: SOURCE_CONTROL_MANAGEMENT_S)
		do
			scm_service := a_service
			create git_field
			create svn_field
			create git_diff_field
			create svn_diff_field
			create git_field_error
			create svn_field_error

			make_dialog
		end

feature -- Access

	scm_service: SOURCE_CONTROL_MANAGEMENT_S

	is_git_command_valid: BOOLEAN
	is_svn_command_valid: BOOLEAN

	is_changed: BOOLEAN

feature -- Widgets

	git_field,
	svn_field: EV_TEXT_FIELD

	git_field_error, svn_field_error: EV_CELL

	git_diff_field,
	svn_diff_field: EV_TEXT_FIELD

feature {NONE} -- User interface initialization

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			field: EV_TEXT_FIELD
			lab: EV_LABEL
			labs: ARRAYED_LIST [EV_LABEL]
			w: INTEGER
		do
			create vb
			vb.set_padding_width (default_padding_size)
			a_container.extend (vb)

			create labs.make (4)

				-- Git
			create lab.make_with_text (scm_names.label_set_git_commands)
			lab.set_font (fonts.highlighted_label_font)
			lab.align_text_left
			vb.extend (lab)
			vb.disable_item_expand (lab)
			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create lab.make_with_text (scm_names.label_command)
			labs.force (lab)
			hb.extend (lab)
			hb.disable_item_expand (lab)
			field := git_field
			if attached scm_service.config.git_command as git_cmd then
				field.set_text (git_cmd)
			end
			register_input_widget (field)
			hb.extend (field)
			hb.extend (git_field_error)
			hb.disable_item_expand (git_field_error)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create lab.make_with_text (scm_names.label_diff_command)
			labs.force (lab)
			hb.extend (lab)
			hb.disable_item_expand (lab)
			field := git_diff_field
			if attached scm_service.config.git_diff_command as git_diff_cmd then
				field.set_text (git_diff_cmd)
			end
			register_input_widget (field)
			hb.extend (field)

				-- Subversion
			create lab.make_with_text (scm_names.label_set_svn_commands)
			lab.set_font (fonts.highlighted_label_font)
			lab.align_text_left
			vb.extend (lab)
			vb.disable_item_expand (lab)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create lab.make_with_text (scm_names.label_command)
			labs.force (lab)
			hb.extend (lab)
			hb.disable_item_expand (lab)
			field := svn_field
			if attached scm_service.config.svn_command as svn_cmd then
				field.set_text (svn_cmd)
			end
			register_input_widget (field)
			hb.extend (field)
			hb.extend (svn_field_error)
			hb.disable_item_expand (svn_field_error)

			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create lab.make_with_text (scm_names.label_diff_command)
			labs.force (lab)
			hb.extend (lab)
			hb.disable_item_expand (lab)
			field := svn_diff_field
			if attached scm_service.config.svn_diff_command as svn_diff_cmd then
				field.set_text (svn_diff_cmd)
			end
			register_input_widget (field)
			hb.extend (field)

				-- same width for the labels in `labs`
			across
				labs as ic
			loop
				w := w.max (ic.item.width)
			end
			across
				labs as ic
			loop
				ic.item.set_minimum_width (w)
			end

				-- Common
			set_button_text (dialog_buttons.apply_button, interface_names.b_apply)
			set_button_text (dialog_buttons.close_button, interface_names.b_close)
			set_button_text (dialog_buttons.reset_button, interface_names.b_reset)

			set_button_action_before_close (dialog_buttons.apply_button, agent on_save)
			set_button_action_before_close (dialog_buttons.close_button, agent on_close)
			set_button_action_before_close (dialog_buttons.reset_button, agent on_reset)

			check_commands_validity
		end

feature {NONE} -- Helpers

	register_input_widget (aw: EV_WIDGET)
			-- Register `aw' as an input widget
		do
			suppress_confirmation_key_close  (aw)
		end

feature -- Action

	set_size (w,h: INTEGER)
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
					end(a_tf, col, ?)
				)
		end

	reset_text_field (a_tf: EV_TEXT_FIELD)
		local
			v: READABLE_STRING_GENERAL
		do
			v := a_tf.text
			a_tf.key_press_actions.call ([create {EV_KEY}])
			a_tf.set_text (v)
		end

	check_commands_validity
		local
			l_old_svn_cmd, l_old_git_cmd: detachable READABLE_STRING_32
		do
			l_old_git_cmd := scm_service.config.git_command
			l_old_svn_cmd := scm_service.config.svn_command

			scm_service.config.set_git_command (git_field.text)
			scm_service.config.set_svn_command (svn_field.text)

			scm_service.check_scm_availability
			is_git_command_valid := scm_service.is_git_available
			is_svn_command_valid := scm_service.is_svn_available

			scm_service.config.set_git_command (l_old_git_cmd)
			scm_service.config.set_svn_command (l_old_svn_cmd)

			if is_git_command_valid then
				reset_text_field (git_field)
				git_field_error.wipe_out
			else
				notify_error_on_text_field (git_field)
				git_field_error.replace (stock_pixmaps.command_error_info_icon)
			end

			if is_svn_command_valid then
				reset_text_field (svn_field)
				svn_field_error.wipe_out
			else
				notify_error_on_text_field (svn_field)
				svn_field_error.replace (stock_pixmaps.command_error_info_icon)
			end
			if is_git_command_valid and is_svn_command_valid then
--				dialog_window_buttons.item ({ES_DIALOG_BUTTONS}.close_button).enable_sensitive
				set_button_text (dialog_buttons.close_button, interface_names.b_close)
			else
--				dialog_window_buttons.item ({ES_DIALOG_BUTTONS}.close_button).disable_sensitive
				set_button_text (dialog_buttons.close_button, interface_names.b_cancel)
			end
		end

	on_save
		local
			cfg: SCM_CONFIG
		do
			check_commands_validity
			cfg := scm_service.config
			if is_git_command_valid then
				if not cfg.git_command.same_string (git_field.text) then
					is_changed := True
					scm_service.config.set_git_command (git_field.text)
				end
				if not cfg.git_diff_command.same_string (git_diff_field.text) then
					is_changed := True
					scm_service.config.set_git_diff_command (git_diff_field.text)
				end
			end
			if is_svn_command_valid then
				if not cfg.svn_command.same_string (svn_field.text) then
					is_changed := True
					scm_service.config.set_svn_command (svn_field.text)
				end
				if not cfg.svn_diff_command.same_string (svn_diff_field.text) then
					is_changed := True
					scm_service.config.set_svn_diff_command (svn_diff_field.text)
				end
			end
			if is_changed then
				scm_service.on_configuration_updated (cfg)
			end
			veto_close
		end

	on_reset
		do
			if attached scm_service.config.git_command as v then
				git_field.set_text (v)
			else
				git_field.set_text (scm_service.config.default_git_command)
			end
			if attached scm_service.config.svn_command as v then
				svn_field.set_text (v)
			else
				git_field.set_text (scm_service.config.default_svn_command)
			end
			check_commands_validity
			veto_close
		end

	on_close
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
			Result := scm_names.title_scm_config
		end

	buttons: DS_HASH_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		once
			create Result.make (3)
			Result.put_last ({ES_DIALOG_BUTTONS}.reset_button)
			Result.put_last ({ES_DIALOG_BUTTONS}.apply_button)
			Result.put_last ({ES_DIALOG_BUTTONS}.close_button)
		end


	default_button: INTEGER
			-- The dialog's default action button
		once
			Result := dialog_buttons.close_button
		end

	default_cancel_button: INTEGER
			-- The dialog's default cancel button
		once
			Result := dialog_buttons.close_button
		end

	default_confirm_button: INTEGER
			-- The dialog's default confirm button
		once
			Result := dialog_buttons.apply_button
		end

	is_size_and_position_remembered: BOOLEAN = False
			-- Indicates if the size and position information is remembered for the dialog	

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
