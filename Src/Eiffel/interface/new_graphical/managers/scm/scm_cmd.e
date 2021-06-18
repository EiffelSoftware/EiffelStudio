note
	description: "Command to open the SCM tool panel."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_sd_toolbar_item,
			initialize_sd_toolbar_item,
			initialize_menu_item,
			tooltext
		end

	EB_SHARED_WINDOW_MANAGER
		export {NONE} all end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	SCM_SHARED_RESOURCES

	SHARED_SCM_NAMES

	SHARED_SOURCE_CONTROL_MANAGEMENT_SERVICE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize default_values.
		do
			init_accelerator
			enable_sensitive
		end

	init_accelerator
		local
			l_shortcut: SHORTCUT_PREFERENCE
		do
			l_shortcut := preferences.misc_shortcut_data.shortcuts.item ("show_source_control_tool")
			if l_shortcut /= Void then
				create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
				set_referred_shortcut (l_shortcut)
				accelerator.actions.extend (agent execute_from_accelerator)
			end
		end

feature -- Status

	is_supported: BOOLEAN
		do
			Result := attached scm_s.service
		end

feature -- Access

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Redefine
		do
			create Result.make (Current)
			initialize_sd_toolbar_item (Result, display_text)
			Result.select_actions.extend (agent execute)
		end

	initialize_sd_toolbar_item (a_item: EB_SD_COMMAND_TOOL_BAR_BUTTON; display_text: BOOLEAN)
		do
			Precursor (a_item, display_text)
			if attached {EB_SD_COMMAND_TOOL_BAR_DUAL_POPUP_BUTTON} a_item as but then
				but.set_menu_function (agent updated_drop_down_menu)
--				b.set_menu (drop_down_menu)
			end
		end

	initialize_menu_item (a_menu_item: EV_MENU_ITEM)
		do
			Precursor (a_menu_item)
		end

feature -- Basic operations

	execute_from_accelerator
			-- Execute from accelerator
		do
			execute
		end

	execute
			-- Open the SCM account tool.
		do
			if is_sensitive then
				if
					attached window_manager.last_focused_development_window as win and then
					attached win.tools.scm_tool as l_tool
				then
					if l_tool.is_shown then
						updated_drop_down_menu.show
					else
						l_tool.show (True)
					end
				end
			end
		end

	go_to_the_tool
		do
			if is_sensitive then
				if
					attached window_manager.last_focused_development_window as win and then
					attached win.tools.scm_tool as l_tool
				then
					l_tool.show (True)
				end
			end
		end

	refresh
		do
			refresh_items
		end

	refresh_items
		local
			l_sd_lst: like internal_managed_sd_toolbar_items
			l_sd_item: like new_sd_toolbar_item
			l_menu_lst: like internal_managed_menu_items
			l_menu_item: like new_menu_item
		do
			l_sd_lst := internal_managed_sd_toolbar_items
			if l_sd_lst /= Void then
				from
					l_sd_lst.start
				until
					l_sd_lst.after
				loop
					l_sd_item := l_sd_lst.item
					if l_sd_item /= Void then
						initialize_sd_toolbar_item (l_sd_item, not attached l_sd_item.text as txt or else not txt.is_empty)
					end
					l_sd_lst.forth
				end
			end
			l_menu_lst := internal_managed_menu_items
			if l_menu_lst /= Void then
				from
					l_menu_lst.start
				until
					l_menu_lst.after
				loop
					l_menu_item := l_menu_lst.item
					if l_menu_item /= Void then
						initialize_menu_item (l_menu_item)
					end
					l_menu_lst.forth
				end
			end
		end

	update_sensitive
		do
			enable_sensitive
		end

feature -- Access

	name: STRING = "SCM_tool"
			-- <Precursor>

feature {NONE} -- Implementation

	pixmap: EV_PIXMAP
			-- Pixmap representing command.
		do
			Result := pixmaps.icon_pixmaps.source_version_control_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.source_version_control_icon_buffer
		end

	description: STRING_GENERAL
			-- Description for command
		do
			Result := scm_names.desc_scm_tool
		end

	tooltip: STRING_GENERAL
			-- Tooltip for toolbar button
		do
			Result := scm_names.desc_scm_tool
		end

	tooltext: STRING_GENERAL
			-- Tooltip for toolbar button
		do
			Result := scm_names.button_scm
		end

	menu_name: STRING_GENERAL
		do
			Result := scm_names.menu_scm
		end

feature -- Drop down menu

	updated_drop_down_menu: EV_MENU
		do
			Result := drop_down_menu
		end

	drop_down_menu: EV_MENU
			-- Drop down menu for `new_sd_toolbar_item'.
		local
			l_item: EV_MENU_ITEM
			l_menu_status_item,
			l_menu_revert_item,
			l_menu_diff_item: EV_MENU_ITEM
			l_menu_add_to_item: EV_MENU
			mi: EV_MENU_ITEM
			l_status: SCM_STATUS
		do
			create Result
			if attached scm_s.service as scm then
				if scm.is_available then
					create l_menu_status_item
					l_menu_status_item.set_text (scm_names.menu_editor_status (Void, Void))
					l_menu_status_item.disable_sensitive
					l_menu_status_item.select_actions.extend (agent on_editor_change_selected)
					Result.extend (l_menu_status_item)

					Result.extend (create {EV_MENU_SEPARATOR})

					create l_menu_diff_item
					l_menu_diff_item.set_text (scm_names.menu_diff)
					l_menu_diff_item.disable_sensitive
					l_menu_diff_item.select_actions.extend (agent on_editor_diff_selected)
					Result.extend (l_menu_diff_item)

					create l_menu_add_to_item
					l_menu_add_to_item.set_text (scm_names.menu_add_to_changelist (Void, 0))
					l_menu_add_to_item.disable_sensitive
					Result.extend (l_menu_add_to_item)

					create l_menu_revert_item
					l_menu_revert_item.set_text (scm_names.menu_revert)
					l_menu_revert_item.disable_sensitive
					l_menu_revert_item.select_actions.extend (agent on_editor_revert_selected)
					Result.extend (l_menu_revert_item)

					Result.extend (create {EV_MENU_SEPARATOR})
					create l_item
					l_item.set_text (scm_names.menu_status)
					l_item.enable_sensitive
					l_item.select_actions.extend (agent scm.update_statuses)
					Result.extend (l_item)


					create l_item
					l_item.set_text (scm_names.menu_go_to_tool)
					l_item.enable_sensitive
					l_item.select_actions.extend (agent go_to_the_tool)
					Result.extend (l_item)

					if attached {FILED_STONE} editor_stone as st then
						l_status := scm.file_status (create {PATH}.make_from_string (st.file_name))
						if
							l_status /= Void
						then
							l_menu_status_item.set_data (l_status)
							l_menu_status_item.set_pixmap (status_pixmap (l_status))
							l_menu_status_item.set_text (scm_names.menu_editor_status (st.stone_name, l_status.status_as_string))
							if
								attached {SCM_STATUS_MODIFIED} l_status
								or attached {SCM_STATUS_CONFLICTED} l_status
							then
								l_menu_diff_item.enable_sensitive
								l_menu_revert_item.enable_sensitive
							end
						else
							l_menu_status_item.set_text (scm_names.menu_editor_status (st.stone_name, Void))
						end
						l_menu_add_to_item.enable_sensitive
						across
							scm.changelists as ic
						loop
							create mi.make_with_text (scm_names.menu_add_to_changelist (ic.key, ic.item.count))
							mi.select_actions.extend (agent on_editor_add_selected (ic.key, st.file_name))
							l_menu_add_to_item.extend (mi)
						end
					end

				else
						-- Check availability
					create l_item.make_with_text (scm_names.menu_check)
					l_item.select_actions.extend (agent scm.check_scm_availability)
					Result.extend (l_item)
				end
			end
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	on_editor_change_selected
		do
		end

	on_editor_diff_selected
		local
			dlg: SCM_DIFF_DIALOG
		do
			if attached {FILED_STONE} editor_stone as l_file_stone then
				if
					attached scm_s.service as scm and then
					scm.is_available
				then
					if attached scm.diff_at_location (create {PATH}.make_from_string (l_file_stone.file_name)) as l_diff then
						create dlg.make (scm, l_diff)
						dlg.set_is_modal (False)
						if attached Window_manager.last_focused_development_window as devwin then
							dlg.set_size (devwin.dpi_scaler.scaled_size (700).min (devwin.window.width), devwin.dpi_scaler.scaled_size (500).min (devwin.window.height))
						end
						dlg.show_on_active_window
					end
				end
			end
		end

	on_editor_add_selected (a_name: READABLE_STRING_GENERAL; a_location: READABLE_STRING_GENERAL)
		local
			p: PATH
		do
			if
				attached scm_s.service as scm and then
				scm.is_available
			then
				if attached scm.changelists [a_name] as ch then
					create p.make_from_string (a_location)
					ch.extend_path (scm.scm_root_location (p), p)
					scm.on_changelist_updated (ch)
				end
			end
		end

	on_editor_revert_selected
		local
			ch: SCM_CHANGELIST
			p: PATH
			s: READABLE_STRING_GENERAL
		do
			if
				attached scm_s.service as scm and then
				scm.is_available
			then
				if attached {FILED_STONE} editor_stone as l_file_stone then
					create p.make_from_string (l_file_stone.file_name)
					if attached	scm.scm_root_location (p) as rt then
						create ch.make_with_location (rt)
						ch.extend_path (p)
						s := scm.revert (ch) -- FIXME report output
					end
				end
			end
		end

	editor_stone: STONE
			-- Currently selected editor stone if any.
			-- (export status {NONE})
		do
			if attached Window_manager.last_focused_development_window as w and then attached w.stone as stone then
				Result := stone
			end
		end

note
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
