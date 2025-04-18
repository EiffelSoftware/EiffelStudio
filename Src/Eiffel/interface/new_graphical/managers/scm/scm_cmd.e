﻿note
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

	SHARED_EXECUTION_ENVIRONMENT

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
			l_shortcut := preferences.misc_shortcut_data.shortcuts.item ("show_scm_tool") -- See {ES_TOOL}.shortcut_preference_name
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
			if is_sensitive then
				if
					attached window_manager.last_focused_development_window as win and then
					attached win.tools.scm_tool as l_tool and then
					l_tool.is_interface_usable
				then
					l_tool.show (True)
				end
			end
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
					elseif l_tool.is_interface_usable then
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

	request_update_statuses
		do
			if
				attached scm_s.service as scm and then
				scm.is_available
			then
				scm.update_statuses
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
			l_menu_revert_item, l_menu_add_item, l_menu_delete_item,
			l_menu_update_item,
			l_menu_diff_item: EV_MENU_ITEM
			l_menu_add_to_item: EV_MENU
			mi: EV_MENU_ITEM
			l_status: SCM_STATUS
			l_file_location: PATH
			l_scm_root: SCM_LOCATION
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
					Result.extend (l_menu_diff_item)

					create l_menu_revert_item
					l_menu_revert_item.set_text (scm_names.menu_revert)
					l_menu_revert_item.disable_sensitive
					Result.extend (l_menu_revert_item)

					create l_menu_add_item
					l_menu_add_item.set_text (scm_names.menu_add)
					l_menu_add_item.disable_sensitive
					Result.extend (l_menu_add_item)

					create l_menu_delete_item
					l_menu_delete_item.set_text (scm_names.menu_delete)
					l_menu_delete_item.disable_sensitive
					Result.extend (l_menu_delete_item)

					create l_menu_update_item
					l_menu_update_item.set_text (scm_names.menu_update)
					l_menu_update_item.disable_sensitive
					Result.extend (l_menu_update_item)

					create l_menu_add_to_item
					l_menu_add_to_item.set_text (scm_names.menu_add_to_changelist (Void, 0))
					l_menu_add_to_item.disable_sensitive
					Result.extend (l_menu_add_to_item)

					Result.extend (create {EV_MENU_SEPARATOR})
					create l_item
					l_item.set_text (scm_names.menu_status)
					l_item.enable_sensitive
					l_item.select_actions.extend (agent request_update_statuses)
					Result.extend (l_item)

					create l_item
					l_item.set_text (scm_names.menu_go_to_tool)
					l_item.enable_sensitive
					l_item.select_actions.extend (agent go_to_the_tool)
					Result.extend (l_item)

					if attached {FILED_STONE} editor_stone as st then
						create l_file_location.make_from_string (st.file_name)
						l_scm_root := scm.scm_root_location (l_file_location)

						if l_scm_root = Void then
							l_menu_status_item.set_text (scm_names.menu_file_outside_any_repository)
						else
							l_status := scm.file_status (l_file_location)
							if
								l_status /= Void
							then
								l_menu_diff_item.enable_sensitive
								l_menu_diff_item.select_actions.extend (agent on_editor_diff_selected (l_status.location))

								l_menu_status_item.set_data (l_status)
								l_menu_status_item.set_pixmap (status_pixmap (l_status))
								l_menu_status_item.set_text (scm_names.menu_editor_status (st.stone_name, l_status.status_as_string))
								if
									attached {SCM_STATUS_MODIFIED} l_status
									or attached {SCM_STATUS_CONFLICTED} l_status
								then

									l_menu_revert_item.enable_sensitive
									l_menu_revert_item.select_actions.extend (agent on_editor_revert_selected (l_status))
									l_menu_delete_item.enable_sensitive
									l_menu_delete_item.select_actions.extend (agent on_editor_delete_selected (l_status))
								elseif attached {SCM_STATUS_UNVERSIONED} l_status then
									l_menu_add_item.enable_sensitive
									l_menu_add_item.select_actions.extend (agent on_editor_add_selected (l_status))
								end
								if not attached {SCM_GIT_LOCATION} l_scm_root then
										-- Not yet available for git
									l_menu_update_item.enable_sensitive
									l_menu_update_item.select_actions.extend (agent on_editor_update_selected (l_status))
								end
							else
								l_menu_status_item.set_text (scm_names.menu_editor_status (st.stone_name, Void))
								l_menu_diff_item.enable_sensitive
								l_menu_diff_item.select_actions.extend (agent on_editor_diff_selected (l_file_location))
							end
							l_menu_add_to_item.enable_sensitive
							across
								scm.changelists as ic
							loop
								create mi.make_with_text (scm_names.menu_add_to_changelist (ic.key, ic.item.count))
								if l_status /= Void then
									mi.select_actions.extend (agent on_editor_add_to_changelist_selected (ic.key, l_status))
								else
									mi.select_actions.extend (agent on_editor_add_to_changelist_selected (ic.key, create {SCM_STATUS_UNKNOWN}.make_with_name (st.file_name))) -- FIXME: check this code.
								end
								l_menu_add_to_item.extend (mi)
							end
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

	on_editor_diff_selected (a_file_location: PATH)
		local
			dlg: SCM_DIFF_DIALOG
			l_ext_cmd: READABLE_STRING_GENERAL
			ch_list: SCM_CHANGELIST
			l_location: PATH
			l_fake_diff_status: SCM_STATUS_MODIFIED
		do
			if
				attached scm_s.service as scm and then
				scm.is_available
			then
				l_location := a_file_location
				if attached scm.scm_root_location (l_location) as l_scm_root then
					if
						attached {SCM_GIT_LOCATION} l_scm_root and then
						scm.config.use_external_git_diff_command
					then
						l_ext_cmd := scm.config.external_git_diff_command (l_location)
					elseif
						attached {SCM_SVN_LOCATION} l_scm_root and then
						scm.config.use_external_svn_diff_command
					then
						l_ext_cmd := scm.config.external_svn_diff_command (l_location)
					else
						l_ext_cmd := Void
					end
					if l_ext_cmd /= Void then
						execution_environment.launch (l_ext_cmd)
					else
						create ch_list.make_with_location (l_scm_root)
						create l_fake_diff_status.make (a_file_location)
						ch_list.extend_status (l_fake_diff_status)
						if attached scm.diff (ch_list) as l_diff then
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
		end

	on_editor_add_to_changelist_selected (a_name: READABLE_STRING_GENERAL; a_status: SCM_STATUS)
		do
			if
				attached scm_s.service as scm and then
				scm.is_available
			then
				if attached scm.changelists [a_name] as ch then
					ch.extend_status (scm.scm_root_location (a_status.location), a_status)
					scm.on_changelist_updated (ch)
				end
			end
		end

	on_editor_revert_selected (a_status: SCM_STATUS)
		local
			ch: SCM_CHANGELIST
			s: READABLE_STRING_GENERAL
		do
			if
				attached scm_s.service as scm and then
				scm.is_available
			then
				if attached	scm.scm_root_location (a_status.location) as rt then
					create ch.make_with_location (rt)
					ch.extend_status (a_status)
					s := scm.revert (ch)
					show_command_execution ("Revert", s)
				end
			end
		end

	on_editor_add_selected (a_status: SCM_STATUS)
		local
			ch: SCM_CHANGELIST
			s: READABLE_STRING_GENERAL
		do
			if
				attached scm_s.service as scm and then
				scm.is_available
			then
				if attached	scm.scm_root_location (a_status.location) as rt then
					create ch.make_with_location (rt)
					ch.extend_status (a_status)
					s := scm.add (ch)
					show_command_execution ("Add", s)
				end
			end
		end

	on_editor_delete_selected (a_status: SCM_STATUS)
		local
			ch: SCM_CHANGELIST
			s: READABLE_STRING_GENERAL
		do
			if
				attached scm_s.service as scm and then
				scm.is_available
			then
				if attached	scm.scm_root_location (a_status.location) as rt then
					create ch.make_with_location (rt)
					ch.extend_status (a_status)
					s := scm.delete (ch)
					show_command_execution ("Delete", s)
				end
			end
		end

	on_editor_update_selected (a_status: SCM_STATUS)
		local
			ch: SCM_CHANGELIST
			s: READABLE_STRING_GENERAL
		do
			if
				attached scm_s.service as scm and then
				scm.is_available
			then
				if attached	scm.scm_root_location (a_status.location) as rt then
					create ch.make_with_location (rt)
					ch.extend_status (a_status)
					s := scm.update (ch)
					show_command_execution ("Update", s)
				end
			end
		end

	show_command_execution (a_op: READABLE_STRING_GENERAL; a_output: READABLE_STRING_GENERAL)
		local
			d: SCM_COMMAND_EXECUTION_DIALOG
		do
			if
				attached scm_s.service as scm and then
				scm.is_available
			then
				create d.make (scm, a_op, a_output)
				d.set_is_modal (False)
				if attached window_manager.last_focused_development_window as devwin then
					d.set_size (devwin.dpi_scaler.scaled_size (700).min (devwin.window.width), devwin.dpi_scaler.scaled_size (500).min (devwin.window.height))
				end
				d.show_on_active_window
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
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
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
