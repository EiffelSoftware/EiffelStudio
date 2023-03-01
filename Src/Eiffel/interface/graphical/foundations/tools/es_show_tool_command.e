note
	description: "[
		A command used to show a tool through a tool shim {ES_TOOL} descendants.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_SHOW_TOOL_COMMAND

inherit
	EB_DEVELOPMENT_WINDOW_COMMAND
		rename
			make as target_make
		redefine
			internal_detach_entities
		end

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_sd_toolbar_item,
			tooltext,
			is_tooltext_important,
			mini_pixmap,
			mini_pixel_buffer
		end

	ES_STONABLE

	SHARED_LOCALE

create
	make

feature {NONE} -- Initialization

	make (a_tool: like tool)
			-- Creation method.
		require
			a_tool_attached: a_tool /= Void
			a_tool_window_set: a_tool.window /= Void
		do
			target_make (a_tool.window)
			tool := a_tool
			is_sensitive := True
		end

feature -- Clean up

	internal_detach_entities
			-- Detaches objects from their container
		do
			tool := Void

			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND}
		ensure then
			tool_detached: tool = Void
		end

feature -- Access

	tool: ES_TOOL [EB_TOOL]
			-- Tool managed.

	tooltip: STRING_GENERAL
			-- Tooltip for Current
		do
			Result := interface_names.f_show_tool (tool.title)
		end

	tooltext: STRING_GENERAL
			-- Text for toolbar button.
		do
			Result := tool.title
		end

	is_tooltext_important: BOOLEAN
			-- Is the tooltext important shown when view is 'Selective Text'
		do
			Result := True
		end

	description: STRING_GENERAL
			-- Description for current command.
		do
			Result := interface_names.f_show_tool (tool.title)
		end

	menu_name: STRING_GENERAL
			-- Name as it appears in menus.
		do
			Result := tool.title
		end

	name: STRING_GENERAL
			-- Name to be displayed.
		do
			Result := (create {INTERNAL}).type_name_32 (tool)
			if tool.edition > 1 then
				Result.append (":" + tool.edition.out)
			end
		end

	pixmap: EV_PIXMAP
			-- Pixmap representing the item (for buttons)
		do
			Result := tool.icon_pixmap
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := tool.icon
		end

	mini_pixmap: EV_PIXMAP
			-- Mini pixmap		

	mini_pixel_buffer: EV_PIXEL_BUFFER
			-- Mini pixel buffer

feature {NONE} -- Status report

	is_stone_usable_internal (a_stone: attached like stone): BOOLEAN
			-- <Precursor>
		do
			if attached {ES_STONABLE_I} tool as l_stonable then
				Result := l_stonable.is_stone_usable (a_stone)
			end
		end

feature -- Execution

	execute
			-- Execute command (toggle between show and hide).
		local
			l_shared: SD_SHARED
			l_x, l_y: INTEGER
			l_window: EV_WINDOW
			l_content: SD_CONTENT
		do
			-- We have to check whether docking manager has Current tool's SD_CONTENT since debugger related tools not exist in normal mode.
			-- They only exist in debug mode. See bug#13826.
			l_content := tool.docking_content
			if l_content /= Void and then l_content.is_docking_manager_attached  then
				if attached {ES_STONABLE_I} tool as l_stonable and then stone /= Void and then not equal (stone, l_stonable.stone) then
						-- We check if the stone is attached to prevent the existing stone from being wiped out.
					check is_stone_usable: l_stonable.is_stone_usable (stone) end
					l_stonable.set_stone_with_query (stone)
				end

				if not tool.is_shown then
					create l_shared
					l_window := tool.window.window
					l_x := l_window.screen_x + l_window.width // 2 - l_shared.default_floating_window_width // 2
					l_y := l_window.screen_y + l_window.height // 2 - l_shared.default_floating_window_height // 2

					l_shared.set_default_screen_x (l_x)
					l_shared.set_default_screen_y (l_y)

					tool.show (True)
				else
					l_content.set_focus
				end
			end
		end

feature -- Basic operations

	new_sd_toolbar_item (a_display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON
			-- Create a new toolbar button for this command.
		do
			create Result.make (Current)
			initialize_sd_toolbar_item (Result, a_display_text)
			Result.select_actions.extend (agent execute)
			Result.select_actions.extend (agent update_sd_tooltip (Result))
		end

feature -- Synchronization

	synchronize
			-- <Precursor>
		do
		end

feature -- Element change

	set_accelerator (a_accel: EV_ACCELERATOR)
			-- Set `accelerator' with `a_accel'.
		require
			a_accel_attached: a_accel /= Void
		do
			accelerator := a_accel
		ensure
			accelerator_not_void: accelerator = a_accel
		end

	set_mini_pixmap (a_mini_pixmap: EV_PIXMAP)
			-- Set `mini_pixmap' with `a_mini_pixmap'.
		do
			mini_pixmap := a_mini_pixmap
		ensure
			mini_pixmap_set: mini_pixmap = a_mini_pixmap
		end

	set_mini_pixel_buffer (a_mini_pixel_buffer: EV_PIXEL_BUFFER)
			-- Set `mini_pixel_buffer' with `a_mini_pixel_buffer'.
		do
			mini_pixel_buffer := a_mini_pixel_buffer
		ensure
			mini_pixmap_set: mini_pixel_buffer = a_mini_pixel_buffer
		end

feature {NONE} -- Action handler

	on_stone_changed (a_old_stone: detachable like stone)
			-- <Precursor>
		do
		end

feature {NONE} -- Implementation

	update_sd_tooltip (a_toogle: EB_SD_COMMAND_TOOL_BAR_BUTTON)
			-- Update tooltip of `a_toggle'.
		local
			l_tt: like tooltip
		do
			l_tt := tooltip.twin
			if shortcut_available then
				l_tt.append (opening_parenthesis)
				l_tt.append (shortcut_string)
				l_tt.append (closing_parenthesis)
			end
			a_toogle.set_tooltip (l_tt)
		end

invariant
	tool_attached: not is_recycled implies tool /= Void

;note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
