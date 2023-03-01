note
	description: "[
		A command used to show a tool through a tool shim {ES_TOOL} descendants.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_NEW_TOOL_COMMAND

inherit
	EB_DEVELOPMENT_WINDOW_COMMAND
		rename
			make as target_make
		end

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_sd_toolbar_item,
			mini_pixmap,
			mini_pixel_buffer
		end

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_tool: like new_tool)
			-- Creation method.
		require
			a_tool_attached: a_tool /= Void
			a_tool_window_set: a_tool.window /= Void
		local
			l_pixmaps: EB_SHARED_PIXMAPS
			l_tool: like new_tool
		do
			target_make (a_tool.window)
			tool_type := a_tool.generating_type
			tooltip := locale_formatter.translation (f_create_new_tool)
			description := tooltip
			name := tool_type.name_32

			create l_pixmaps
			mini_pixmap := l_pixmaps.mini_pixmaps.new_tool_edition_icon
			mini_pixel_buffer := l_pixmaps.mini_pixmaps.new_tool_edition_icon_buffer

			l_tool := new_tool

			menu_name := l_tool.title
			pixmap := l_pixmaps.icon_pixmaps.icon_with_overlay (l_tool.icon_pixmap, l_pixmaps.icon_pixmaps.overlay_new_icon_buffer, 0, 0)
			pixel_buffer := l_pixmaps.icon_pixmaps.icon_buffer_with_overlay (l_tool.icon, l_pixmaps.icon_pixmaps.overlay_new_icon_buffer, 0, 0)

			is_sensitive := True
		end

feature -- Access

	tooltip: STRING_GENERAL
			-- Tooltip for Current

	description: STRING_GENERAL
			-- Description for current command.

	menu_name: STRING_GENERAL
			-- Name as it appears in menus.

	name: STRING_32
			-- Name to be displayed.

	pixmap: EV_PIXMAP
			-- Pixmap representing the item (for buttons)

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.

	mini_pixmap: EV_PIXMAP
			-- Mini pixmap

	mini_pixel_buffer: EV_PIXEL_BUFFER
			-- Mini pixel buffer

feature {NONE} -- Access

	tool_type: TYPE [ES_TOOL [EB_TOOL]]
			-- Tool managed.

feature {NONE} -- Helpers

	frozen stock_pixmaps: ES_ICONS
			-- Access to stock dpi based EiffelStudio pixmaps.
		do
				-- TODO review
				-- updated once feature to load icon_pixmap based on the Monitor DPI.
				-- using object-less call
				-- Date 05/24/2019	
			Result := {EB_SHARED_PIXMAPS}.icon_pixmaps
		ensure
			result_attached: Result /= Void
		end

feature -- Execution

	execute
			-- Execute command (toggle between show and hide).
		local
			l_shared: SD_SHARED
			l_x, l_y: INTEGER
			l_window: EV_WINDOW
			l_tool: like new_tool
		do
			create l_shared

			l_tool := new_tool
			l_window := l_tool.window.window
			l_x := l_window.screen_x + l_window.width // 2 - l_shared.default_floating_window_width // 2
			l_y := l_window.screen_y + l_window.height // 2 - l_shared.default_floating_window_height // 2

			l_shared.set_default_screen_x (l_x)
			l_shared.set_default_screen_y (l_y)

			l_tool.show (True)
		end

feature -- Factory

	new_sd_toolbar_item (a_display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Create a new toolbar button for this command.
		do
			create Result.make (Current)
			initialize_sd_toolbar_item (Result, a_display_text)
			Result.select_actions.extend (agent execute)
			auto_recycle (Result)
		end

feature {NONE} -- Factory

	new_tool: ES_TOOL [EB_TOOL]
			-- New tool instance
		require
			not_is_recycled: not is_recycled
		do
			Result := target.shell_tools.tool_next_available_edition (tool_type, True)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Internationalization

	f_create_new_tool: STRING = "Create another new edition of the tool"

invariant
	tool_type_attached: not is_recycled implies tool_type /= Void

;note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
