note
	description: "Ixport or import tabs."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TABS_EXPORT_IMPORT_DIALOG

inherit

	ES_DIALOG
		rename
			make as make_dialog
		end

	SD_ACCESS
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

	EB_SHARED_ID_SOLUTION
		export
			{NONE} all
		end

create
	make

convert
	dialog: {EV_DIALOG}

feature {NONE} -- Initialization

	make (wm: EB_WINDOW_MANAGER)
		do
			window_manager := wm
			make_dialog
			show_actions.extend_kamikaze (agent on_update)
		end

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			l_export_frame, l_import_frame: EV_FRAME
			but: EV_BUTTON
		do
			create label
			create wrapping_button
			create tabs_text
			create hb
			hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			hb.extend (label);
			hb.disable_item_expand (label)
			hb.extend (create {EV_CELL})
			hb.extend (wrapping_button);
			hb.disable_item_expand (wrapping_button)
			a_container.extend (hb);
			a_container.disable_item_expand (hb)
			a_container.extend (tabs_text)
			label.set_minimum_height (20)
			wrapping_button.enable_select
			wrapping_button.set_text (interface_names.l_wrap)
			tabs_text.enable_word_wrapping
				--			message_text.disable_edit
			tabs_text.set_minimum_width (300)
			tabs_text.set_minimum_height (80)
			tabs_text.set_background_color (colors.stock_colors.white)
			tabs_text.key_press_actions.extend (agent (k: EV_KEY)
					do
						if k.code = {EV_KEY_CONSTANTS}.key_f5 then
							on_update
						end
					end)
			wrapping_button.select_actions.extend (agent set_wrapping_mode)
			create l_export_frame.make_with_text ("Export...")
			create l_import_frame.make_with_text ("Import...")
			create hb
			hb.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			a_container.extend (hb);
			a_container.disable_item_expand (hb)
			hb.extend (l_export_frame)
			hb.extend (l_import_frame)
			create vb
			l_export_frame.extend (vb)
			create but.make_with_text_and_action (interface_names.b_save_as, agent on_save)
			save_button := but
			vb.extend (but);
			vb.disable_item_expand (but)
			create but.make_with_text_and_action (interface_names.l_copy_text_to_clipboard, agent on_clipboard)
			clipboard_button := but
			vb.extend (but);
			vb.disable_item_expand (but)
			create vb
			l_import_frame.extend (vb)
			create but.make_with_text_and_action ("Load", agent on_load)
			load_button := but
			vb.extend (but);
			vb.disable_item_expand (but)
			create but.make_with_text_and_action (interface_names.b_import, agent on_import)
			import_button := but
			vb.extend (but);
			vb.disable_item_expand (but)
			set_title_and_label (title, "Share following text...")
			set_button_text (dialog_buttons.close_button, interface_names.b_close)
			set_button_action_before_close (dialog_buttons.close_button, agent on_close)
			close_button := dialog_window_buttons.item (dialog_buttons.close_button)
			dialog.set_size (400, 400)
		end

feature -- Access

	window_manager: EB_WINDOW_MANAGER

feature -- Widgets

	tabs_text: EV_TEXT
			-- Message text field.

	wrapping_button: EV_CHECK_BUTTON
			-- Wrapping button

	label: EV_LABEL
			-- label

	save_button, clipboard_button, load_button, import_button, close_button: EV_BUTTON
			-- Dialog's buttons

feature -- Element change

	set_title_and_label (t, l: STRING_GENERAL)
			-- Set the title and the label of the window
		require
			title_not_void: t /= Void
			label_not_void: l /= Void
		do
			dialog.set_title (t)
			label.set_text (l)
		end

	set_text (t: like text)
		do
			text := t
			display_text
		end

	display_text
			-- Display `text`.
		local
			s: STRING_32
		do
			create s.make_empty
			if attached text as l_text then
				s.append_string (l_text)
			end
			if s.occurrences ('%R') > 0 then
				s.prune_all ('%R')
			end
			tabs_text.set_text (s)
				--			message_text.disable_edit
				--			message_text.set_background_color ((create {EV_STOCK_COLORS}).white)
			if s.count > 0 then
				save_button.enable_sensitive
				clipboard_button.enable_sensitive
				load_button.enable_sensitive
				import_button.enable_sensitive
			else
				save_button.disable_sensitive
				clipboard_button.disable_sensitive
					--				load_button.enable_sensitive
				import_button.disable_sensitive
			end
		end

feature {NONE} -- Implementation

	text: detachable READABLE_STRING_32
			-- Exception meaning, message, and text

	save_text
			-- Save text into a file
		local
			l_save_tool: EB_SAVE_STRING_TOOL
		do
			create l_save_tool.make (dialog)
			if attached workbench as wb and then attached wb.lace.directory_name as dn then
				l_save_tool.set_start_directory (dn)
				l_save_tool.set_filename (wb.lace.target_name + ".tabs")
			end
			l_save_tool.set_text (tabs_text.text)
			l_save_tool.set_title ("Save to text into file...")
			l_save_tool.set_filter_for_extensions (<<"tabs">>, "Text files (*.tabs)")
			l_save_tool.save
		end

	copy_text_to_clipboard
		local
			dlg: EB_INFORMATION_DIALOG
		do
			ev_application.clipboard.set_text (tabs_text.text)
			create dlg.make_with_text ("Text copied to clipboard.")
			dlg.set_title ("Copy to clipboard")
			dlg.show_modal_to_window (dialog)
		end

	on_save
			-- Action to do when "Save" button is activated
		do
			save_text
			veto_close
		end

	on_clipboard
		do
			copy_text_to_clipboard
			veto_close
		end

	on_load
		local
			dlg: EV_FILE_OPEN_DIALOG
		do
			create dlg.make_with_title ("Load tabs from file...")
			if attached workbench as wb and then attached wb.lace.directory_name as dn then
				dlg.set_start_directory (dn)
				dlg.set_file_name (wb.lace.target_name + ".tabs")
			end
			dlg.disable_multiple_selection
			dlg.filters.extend (["*.tabs", "Text file containing tabs exportation"])
			dlg.open_actions.extend (agent  (i_dlg: EV_FILE_OPEN_DIALOG)
				local
					f: PLAIN_TEXT_FILE
					utf: UTF_CONVERTER
					s: STRING
				do
					create f.make_with_path (i_dlg.full_file_path)
					if f.exists and then f.is_access_readable then
						create s.make (f.count)
						f.open_read
						from
						until
							f.exhausted or f.end_of_file
						loop
							f.read_stream (1_024)
							s.append (f.last_string)
						end
						f.close
						set_text (utf.utf_8_string_8_to_string_32 (s))
					end
				end (dlg))
			dlg.show_modal_to_window (dialog)
			veto_close
		end

	on_update
		local
			l_editor: EB_EDITOR
			l_zone: SD_ZONE
			s: STRING_32
			l_zones_indexes: ARRAYED_LIST [TUPLE [zone: SD_ZONE; idx: INTEGER]]
			l_editors_by_zone: ARRAYED_LIST [TUPLE [editors: ARRAYED_LIST [TUPLE [editor: EB_EDITOR; is_active: BOOLEAN]]]] -- Indexed by `l_zones_indexes.item.idx`
			lst: detachable ARRAYED_LIST [TUPLE [editor: EB_EDITOR; is_active: BOOLEAN]]
			idx: INTEGER
		do
			if attached window_manager.development_windows as l_dev_windows then
				create s.make_empty
				across
					l_dev_windows as wic
				loop
					if attached {EB_DEVELOPMENT_WINDOW} wic.item as l_dev_window and then attached {EB_EDITORS_MANAGER} l_dev_window.editors_manager as l_editor_manager then
						create l_zones_indexes.make (1)
						create l_editors_by_zone.make (1)
						across
							l_dev_window.docking_manager.contents as sd_ic
						loop
							if attached sd_ic.item as l_content and then l_content.type = {SD_ENUMERATION}.editor then
								if attached {SD_DOCKING_STATE} l_content.state as l_dock_state then
									l_zone := l_dock_state.zone
								elseif attached {SD_TAB_STATE} l_content.state as l_tab_state then
									l_zone := l_tab_state.zone
								else
									l_zone := Void
								end
								l_editor := l_editor_manager.editor_with_content (l_content)
								if l_editor /= Void then
									if l_zone /= Void then
										idx := 0
										across
											l_zones_indexes as z_ic
										until
											idx > 0
										loop
											if z_ic.item.zone = l_zone then
												idx := z_ic.item.idx
											end
										end
										if idx > 0 and l_editors_by_zone.valid_index (idx) then
											lst := l_editors_by_zone.i_th (idx).editors
										else
											create lst.make (1)
											l_zones_indexes.force ([l_zone, l_zones_indexes.count + 1])
											l_editors_by_zone.force ([lst])
											check l_zones_indexes.count = l_editors_by_zone.count end
										end
											-- There is unique current editor for a window
											-- TODO: find a way to know if this is the selected notebook tab.
										lst.force ([l_editor, l_editor_manager.current_editor = l_editor])
									end
								end
							end
						end
						s.append ("[window_")
						s.append (l_dev_window.window_id.out)
						s.append ("]%N")
						across
							l_editors_by_zone as ic
						loop
							if l_editors_by_zone.count > 1 then
								s.append ("{zone_")
								s.append (ic.cursor_index.out)
								s.append ("}%N")
							end
							across
								ic.item.editors as ed_ic
							loop
								if
									attached {EB_EDITOR} ed_ic.item.editor as e and then
									attached {CLASSI_STONE} e.stone as st
								then
										-- FIXME: handle other kind of editor content ?
									if ed_ic.item.is_active then
										s.append_character ('*')
									end
									s.append (e.docking_content.unique_title)
									s.append_character ('=')
									s.append (id_of_class (st.class_i.config_class))
									s.append_character ('%N')
								end
							end
							s.append_character ('%N')
						end
					end
				end
			end
			set_text (s)
		end

	on_import
		local
			s: STRING_32
			l_line: STRING_32
			l_dev_window: EB_DEVELOPMENT_WINDOW
			l_stone: CLASSI_STONE
			l_next_active_editors: ARRAYED_LIST [TUPLE [window: EB_DEVELOPMENT_WINDOW; editor: EB_SMART_EDITOR; stone: CLASSI_STONE]]
			l_prev_window_id, l_window_id: NATURAL_32
			l_prev_zone_id, l_zone_id: NATURAL_32
			l_id: detachable READABLE_STRING_GENERAL
			l_name: detachable READABLE_STRING_GENERAL
			i: INTEGER
			l_editors_manager: EB_EDITORS_MANAGER
			l_prev_sd_content: detachable SD_CONTENT
			l_split_direction: INTEGER
			l_is_active: BOOLEAN
		do
			s := tabs_text.text
			l_dev_window := window_manager.last_focused_development_window
			if l_dev_window = Void then
				l_dev_window := window_manager.a_development_window
			end
			if l_dev_window = Void then
				window_manager.create_window
				l_dev_window := window_manager.last_created_window
			end
			if l_dev_window /= Void then
				l_editors_manager := l_dev_window.editors_manager
			end
			if l_editors_manager /= Void then
				create l_next_active_editors.make (0)
				l_editors_manager.close_all_editor
				l_dev_window.docking_manager.restore_editor_area
				l_editors_manager.synchronize_with_docking_manager

				across
					s.split ('%N') as ic
				loop
					l_line := ic.item
					if l_line.is_whitespace then
						-- Skip
					elseif l_line.starts_with_general ("[") then
						i := l_line.last_index_of (']', l_line.count)
						if i > 0 then
							l_id := l_line.substring (2, i -1)
							l_window_id := string_to_window_id (l_id)
							if l_prev_window_id /= 0 and then l_prev_window_id /= l_window_id then
								if attached window_manager.development_window_from_id (l_window_id) as w then
									l_dev_window := w
									l_editors_manager := l_dev_window.editors_manager
									l_editors_manager.close_all_editor
									l_editors_manager.synchronize_with_docking_manager
								else
									-- New window!
									window_manager.create_window
									l_dev_window := window_manager.last_created_window
									l_editors_manager := l_dev_window.editors_manager
								end
							end
							l_prev_window_id := l_window_id
						end
					elseif l_line.is_whitespace or l_line.starts_with_general ("{") then
						i := l_line.last_index_of ('}', l_line.count)
						if i > 0 then
							l_id := l_line.substring (2, l_line.count - 1)
							l_zone_id := string_to_zone_id (l_id)
							if l_prev_zone_id /= 0 and then l_prev_zone_id /= l_zone_id then
									-- New zone									
								l_split_direction := {SD_ENUMERATION}.right
								check l_split_direction > 0 end
							else
								l_split_direction := 0
							end
							l_prev_zone_id := l_zone_id
						end
					else
						l_is_active := False
						if l_line.starts_with_general ("*") then
							l_is_active := True
							l_line.remove_head (1)
						end
						i := l_line.index_of ('=', 1)
						if i > 0 then
							l_name := l_line.head (i - 1)
							l_id := l_line.substring (i + 1, l_line.count)
						else
							l_name := l_line
							l_id := l_line.substring (1, l_line.count)
						end
						if
							l_id.is_valid_as_string_8 and then
							attached exported_class_id_to_class_i (l_id.to_string_8) as l_class_i
						then
							create l_stone.make (l_class_i)
							if l_stone /= Void then
								if l_prev_sd_content /= Void then
									l_editors_manager.create_editor_beside_content (l_stone, l_prev_sd_content, True)
								else
									l_editors_manager.create_editor
								end
								if attached l_editors_manager.last_created_editor as l_editor then
									if l_is_active then
										l_next_active_editors.force ([l_dev_window, l_editor, l_stone])
									end
									if l_prev_sd_content /= Void then
										if l_split_direction /= 0 then
											l_editor.docking_content.set_relative (l_prev_sd_content, l_split_direction)
											l_split_direction := 0
										end
									end
									l_prev_sd_content := l_editor.docking_content

									l_editor.set_stone (l_stone)
									l_editors_manager.select_editor (l_editor, False)
									l_editor.reload
								end
							end
						end
					end
				end

--				l_editors_manager.synchronize_with_docking_manager
				from
					l_next_active_editors.finish
				until
					l_next_active_editors.off
				loop
					if attached l_next_active_editors.item as l_data then
						if l_next_active_editors.isfirst then
							l_data.window.editors_manager.select_editor (l_data.editor, True)
							l_data.window.set_stone (l_data.stone)
						else
							l_data.window.editors_manager.select_editor (l_data.editor, False)
						end
					end
					l_next_active_editors.back
				end
			end
			dialog.set_focus
			veto_close
		end

	exported_class_id_to_class_i (a_id: READABLE_STRING_8): detachable CLASS_I
		do
			if attached class_of_id (a_id) as l_conf_class then
				if attached {CLASS_I} l_conf_class as l_class_i then
					Result := l_class_i
				end
			elseif attached universe.classes_with_name (a_id) as lst and then not lst.is_empty then
				Result := lst.first
			end
		end

--	restore_editors (a_dev_window: EB_DEVELOPMENT_WINDOW; a_open_classes: HASH_TABLE [STRING, STRING]): BOOLEAN
--		local
--			l_editors_manager: EB_EDITORS_MANAGER
--			l_has_editor_restored: BOOLEAN
--			l_open_clusters: HASH_TABLE [STRING, STRING]
--			l_cleaner: SD_WIDGET_CLEANER
--		do
--			l_editors_manager := a_dev_window.editors_manager
--			create l_open_clusters.make (0)
--			l_has_editor_restored := l_editors_manager.restore_editors (a_open_classes, l_open_clusters)
--			-- restore layout

--			l_editors_manager.synchronize_with_docking_manager
--			a_dev_window.docking_manager.command.recover_normal_state
--			a_dev_window.docking_manager.command.resize (True)
--			a_dev_window.docking_manager.command.lock_update (Void, True)
--			create l_cleaner.make (a_dev_window.docking_manager)
--			l_cleaner.clean_up_all_editors
--			across
--				a_open_classes as ic
--			loop
--				l_editors_manager.create_named_editor_beside_content (ic.key, Void, False)
----						if attached l_editors_manager.last_created_editor as l_editor then
----							l_editor.docking_content.set_unique_title (ic.key)
----						end
--			end

--			a_dev_window.docking_manager.command.resize (True)
--			a_dev_window.docking_manager.command.unlock_update

--			l_editors_manager.show_editors_possible
--		end

	string_to_window_id (s: READABLE_STRING_GENERAL): NATURAL_32
		local
			i: INTEGER
			num: READABLE_STRING_GENERAL
		do
			from
				i := 1
			until
				i > s.count or s[i].is_digit
			loop
				i := i + 1
			end
			if i <= s.count then
				num := s.substring (i, s.count)
				Result := num.to_natural_32
			end
		end

	string_to_zone_id (s: READABLE_STRING_GENERAL): NATURAL_32
		local
			i: INTEGER
			num: READABLE_STRING_GENERAL
		do
			from
				i := 1
			until
				i > s.count or s[i].is_digit
			loop
				i := i + 1
			end
			if i <= s.count then
				num := s.substring (i, s.count)
				Result := num.to_natural_32
			end
		end

	on_close
			-- Action to do when "Close" button is activated
		do
		end

	set_wrapping_mode
			-- update wrapping mode for exception message
		do
			if wrapping_button.is_selected then
				tabs_text.enable_word_wrapping
			else
				tabs_text.disable_word_wrapping
			end
				--			message_text.disable_edit
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		do
			Result := stock_pixmaps.general_dialog_icon_buffer
		end

	title: STRING_32
			-- The dialog's title
		do
			Result := "Export/Import open editor tabs"
		end

	buttons: DS_HASH_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		once
			create Result.make (1)
			Result.put_last (dialog_buttons.close_button)
		end

	default_button: INTEGER
			-- The dialog's default action button
		do
			Result := dialog_buttons.close_button
		end

	default_cancel_button: INTEGER
			-- The dialog's default cancel button
		do
			Result := dialog_buttons.close_button
		end

	default_confirm_button: INTEGER
			-- The dialog's default confirm button
		do
			Result := dialog_buttons.close_button
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
