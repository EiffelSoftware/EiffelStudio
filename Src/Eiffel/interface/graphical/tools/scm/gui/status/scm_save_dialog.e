note
	description: "Summary description for {SCM_SAVE_DIALOG}."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_SAVE_DIALOG

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

create
	make,
	make_with_changelist

convert
	dialog: {EV_DIALOG}

feature {NONE} -- Initialization

	make (a_service: SOURCE_CONTROL_MANAGEMENT_S; a_commit: SCM_COMMIT_SET; a_parent_box: SCM_STATUS_BOX)
		do
			parent_box := a_parent_box
			scm_service := a_service
			commit := a_commit
			create commit_log_box
			create commit_log_text

			create progress_log_box
			create progress_log_text

			create status_box
			create status_text
			make_dialog
		end

	make_with_changelist (a_service: SOURCE_CONTROL_MANAGEMENT_S; a_changelist: SCM_CHANGELIST_COLLECTION; a_parent_box: SCM_STATUS_BOX)
		do
			parent_box := a_parent_box
			scm_service := a_service

			a_changelist.remove_empty_changelists

			changelist := a_changelist
			if a_changelist.changelist_count = 1 and then attached a_changelist.first_changelist as l_changelist then
				create {SCM_SINGLE_COMMIT_SET} commit.make_with_changelist (Void, l_changelist)
			else
				create {SCM_MULTI_COMMIT_SET} commit.make_with_changelists (Void, a_changelist)
			end
			commit.set_message (a_changelist.description)

			create commit_log_box
			create commit_log_text

			create progress_log_box
			create progress_log_text

			create status_box
			create status_text
			make_dialog
		end

feature -- Access

	scm_service: SOURCE_CONTROL_MANAGEMENT_S

	parent_box: SCM_STATUS_BOX

	commit: SCM_COMMIT_SET

	changelist: detachable SCM_CHANGELIST_COLLECTION

	grid: detachable SCM_CHANGELIST_GRID

feature -- Widgets

	status_text: EV_TEXT

	status_box: EV_VERTICAL_BOX

	progress_log_box: EV_VERTICAL_BOX

	progress_log_text: EV_TEXT

	commit_log_box: EV_VERTICAL_BOX

	commit_log_text: EV_TEXT

feature {NONE} -- User interface initialization

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			fb, b: EV_VERTICAL_BOX
--			f: EV_FRAME
			sp: EV_VERTICAL_SPLIT_AREA
			txt: EV_TEXT
			lab: EV_LABEL
			g: like grid
		do
			create sp
			a_container.extend (sp)

				-- Changes box
			create fb
			sp.extend (fb)
			fb.set_padding_width (default_padding_size)
			fb.set_border_width (default_border_size)

			b := status_box
			fb.extend (b)
			b.set_padding_width (small_padding_size)
			b.set_border_width (small_border_size)

			create lab.make_with_text (scm_names.label_changes)
			lab.align_text_left
			b.extend (lab)
			b.disable_item_expand (lab)

			if attached changelist as l_changelist then
				create g.make_with_workspace (l_changelist, parent_box)
				grid := g
				b.extend (g)
			else
				txt := status_text
				txt.set_text (commit.changes_description)
				txt.disable_edit
				b.extend (txt)
			end

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

				-- Commit log box
			b := commit_log_box
			sp.extend (b)
			b.set_padding_width (small_padding_size)
			b.set_border_width (small_border_size)

			create lab.make_with_text (scm_names.label_commit_message)
			lab.align_text_left
			b.extend (lab)
			b.disable_item_expand (lab)

			txt := commit_log_text
			txt.set_minimum_height (3 * txt.font.line_height)
			if attached commit.message as msg then
				txt.set_text (msg)
			end
			b.extend (txt)

			show_actions.extend_kamikaze (agent (i_sp: EV_VERTICAL_SPLIT_AREA)
						do
							i_sp.set_proportion (0.75)
							ev_application.add_idle_action_kamikaze (agent i_sp.set_proportion (0.75))
						end (sp)
				)

			if attached button_close as but then
				but.hide
			end
			if attached button_next as but then
				but.hide
			end

			set_button_text (dialog_buttons.ok_button, scm_names.button_commit_changelist)
			set_button_text (dialog_buttons.cancel_button, interface_names.b_cancel)
			set_button_text (dialog_buttons.reset_button, interface_names.b_close)

			set_button_text (dialog_buttons.open_button, scm_names.button_diff)
			set_button_tooltip (dialog_buttons.open_button, scm_names.tooltip_button_diff)

			set_button_text (dialog_buttons.apply_button, scm_names.button_process_post_commit_operations)
			set_button_tooltip (dialog_buttons.apply_button, scm_names.tooltip_button_process_post_commit_operations)

			set_button_action_before_close (dialog_buttons.ok_button, agent on_ok)
			set_button_action_before_close (dialog_buttons.cancel_button, agent on_cancel)
			set_button_action_before_close (dialog_buttons.reset_button, agent on_close)
			set_button_action_before_close (dialog_buttons.open_button, agent on_open_diff)
			set_button_action_before_close (dialog_buttons.apply_button, agent on_process_post_commit_operations)

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

	on_open_diff
		local
			d: SCM_DIFF
		do
			if attached {SCM_MULTI_COMMIT_SET} commit as l_multi_commit_set then
					-- TODO: improve this non user friendly behavior.
				across
					l_multi_commit_set.changelists as ic
				loop
					if attached scm_service.diff (ic.item) as l_diff then
						if d = Void then
							d := l_diff
						else
							d.append_diff (l_diff)
						end
					end
				end
				if d /= Void then
					parent_box.show_diff (d)
				end
			elseif attached {SCM_SINGLE_COMMIT_SET} commit as l_single_commit_set then
				d := scm_service.diff (l_single_commit_set.changelist)
				if d /= Void then
					parent_box.show_diff (d)
				end
			end

			veto_close
		end

	on_process_post_commit_operations
		do
			if attached scm_service.post_commit_operations (commit) as l_ops and then not l_ops.is_empty then
				across
					l_ops as ic
				loop
					progress_log_text.append_text ("%N - processing: ")
					progress_log_text.append_text (ic.item.description)
					progress_log_text.append_text ("%N")
				end
			end
		end

	on_ok
		local
			err: BOOLEAN
			l_pointer_style: detachable EV_POINTER_STYLE
			txt: STRING_32
		do
			if attached button_commit as but then
				but.hide
			end
			if attached button_close as but then
				but.show
			end
			if attached button_next as but then
				but.hide
			end

			l_pointer_style := dialog.pointer_style
			dialog.set_pointer_style ((create {EV_STOCK_PIXMAPS}).busy_cursor)

			commit.set_message (commit_log_text.text)
			scm_service.commit (commit)

			dialog.set_pointer_style (l_pointer_style)

			status_box.hide
			commit_log_box.hide
			progress_log_box.show

			if attached commit.execution_message as m then
				progress_log_text.set_text (m)
			else
				progress_log_text.set_text (scm_names.text_no_output)
			end

			if attached scm_service.post_commit_operations (commit) as l_ops and then not l_ops.is_empty then
				if attached button_next as but then
					but.show
						-- FIXME: for now, hide as it is not yet implemented:
					but.hide
				end
				txt := progress_log_text.text
				txt.append_character ('%N')
				txt.append (scm_names.message_for_post_commit_operations (l_ops.count))
				txt.append_character ('%N')
				across
					l_ops as ic
				loop
					if attached {SCM_POST_COMMIT_GIT_PUSH_OPERATION} ic.item as l_git_push then
						txt.append ({STRING_32} " - ")
						txt.append (l_git_push.description)
						txt.append_character ('%N')
					end
				end
				progress_log_text.set_text (txt)
			end

			err := commit.has_error

			if err then
				if attached button_commit as but then
					but.show
				end
				if attached button_close as but then
					but.hide
				end
				if attached button_diff as but then
					but.show
				end
				if attached button_cancel as but then
					but.show
				end
			else
				if attached button_diff as but then
					but.hide
				end
				if attached button_cancel as but then
					but.hide
				end
			end

			veto_close
		end

	on_close
		do
				-- Bye
			commit.set_message (commit_log_text.text)
			if attached grid as g then
				g.destroy
			end
		end

	on_cancel
		do
			commit.reset
			commit.set_message (commit_log_text.text)
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
			Result := scm_names.title_scm_commit
		end

	button_diff: detachable EV_BUTTON
		do
			Result := dialog_window_buttons [dialog_buttons.open_button]
		end
	button_next: detachable EV_BUTTON
		do
			Result := dialog_window_buttons [dialog_buttons.apply_button]
		end
	button_commit: detachable EV_BUTTON
		do
			Result := dialog_window_buttons [dialog_buttons.ok_button]
		end
	button_close: detachable EV_BUTTON
		do
			Result := dialog_window_buttons [dialog_buttons.reset_button]
		end
	button_cancel: detachable EV_BUTTON
		do
			Result := dialog_window_buttons [dialog_buttons.cancel_button]
		end

	buttons: DS_HASH_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		once
			create Result.make (5)
			Result.put_last (dialog_buttons.open_button) -- Diff
			Result.put_last (dialog_buttons.apply_button) -- Apply post commit operations
			Result.put_last (dialog_buttons.ok_button) -- Apply/Commit/...
			Result.put_last (dialog_buttons.reset_button) -- Close
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
