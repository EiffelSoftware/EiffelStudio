note
	description: "Command to open cloud account tool panel."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ACCOUNT_CMD

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

	SHARED_ES_CLOUD_NAMES

	SHARED_ES_CLOUD_SERVICE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize default_values.
		do
			enable_sensitive
		end

feature -- Status

	is_supported: BOOLEAN
		do
			Result := attached es_cloud_s.service
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
			if attached {EB_SD_COMMAND_TOOL_BAR_DUAL_POPUP_BUTTON} a_item as b then
				b.set_menu (drop_down_menu)
			end
		end

	initialize_menu_item (a_menu_item: EV_MENU_ITEM)
		do
			Precursor (a_menu_item)
		end

feature -- Basic operations

	execute
			-- Open the cloud account tool.
		do
			if
				attached window_manager.last_focused_development_window as win and then
				attached win.tools.cloud_account_tool as l_tool
			then
				l_tool.show (True)
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

feature -- Access

	name: STRING = "Cloud_account"
			-- <Precursor>

feature {NONE} -- Implementation

	pixmap: EV_PIXMAP
			-- Pixmap representing command.
		do
			Result := pixmaps.icon_pixmaps.general_information_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.general_information_icon_buffer
		end

	description: STRING_GENERAL
			-- Description for command
		do
			Result := cloud_names.desc_cloud_account_tool
		end

	tooltip: STRING_GENERAL
			-- Tooltip for toolbar button
		do
			Result := cloud_names.desc_cloud_account_tool
		end

	tooltext: STRING_GENERAL
			-- Tooltip for toolbar button
		do
			Result := cloud_names.button_account
		end

	menu_name: STRING_GENERAL
		do
			Result := cloud_names.menu_account
		end

	drop_down_menu: EV_MENU
			-- Drop down menu for `new_sd_toolbar_item'.
		local
			l_item: EV_MENU_ITEM
			acc: detachable ES_ACCOUNT
			t: EV_TIMEOUT
		do
			create Result
			if attached es_cloud_s.service as cld then
				if cld.is_available then
					acc := cld.active_account
					if acc /= Void then
							-- Show profile
						create l_item
						l_item.set_text (cloud_names.menu_my_account (acc.username))
						l_item.enable_sensitive
						Result.extend (l_item)

						create l_item
						Result.extend (l_item)
						l_item.set_text ("Sign out ...")
						l_item.select_actions.extend (agent cld.sign_out)
					elseif cld.is_guest then
							-- Show profile
						create l_item
						Result.extend (l_item)
						l_item.set_text (cloud_names.menu_guest_account)
						l_item.enable_sensitive
					else
							-- Show profile
						create l_item
						Result.extend (l_item)
						l_item.set_text (cloud_names.menu_sign_in)
						l_item.enable_sensitive
					end
				else
					-- Try again	 ?
					create t
					t.actions.extend (agent cld.check_cloud_availability)
--					t.actions.extend (agent update)
					t.actions.extend (agent t.destroy)
					t.set_interval (60 * 1_000) -- 60 * 1000 ms

						-- Check availability
					create l_item.make_with_text (cloud_names.menu_check)
					l_item.select_actions.extend (agent t.destroy)
					l_item.select_actions.extend (agent cld.check_cloud_availability)
					Result.extend (l_item)
				end
			end
		ensure
			not_void: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
