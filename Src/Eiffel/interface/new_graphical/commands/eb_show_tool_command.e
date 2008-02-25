indexing
	description	: "Command to show/hide a tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SHOW_TOOL_COMMAND

inherit
	EB_DEVELOPMENT_WINDOW_COMMAND
		rename
			make as target_make
		redefine
			internal_recycle
		end

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_sd_toolbar_item,
			tooltext,
			is_tooltext_important,
			pixel_buffer,
			mini_pixmap,
			mini_pixel_buffer
		end

	SHARED_LOCALE

create
	make

feature {NONE} -- Initialization

	make (a_target: EB_DEVELOPMENT_WINDOW; a_tool: EB_TOOL) is
			-- Creation method.
		require
			valid_item: a_tool /= Void
			item_has_pixmap: a_tool.content.pixmap /= Void
		do
			target_make (a_target)
			tool := a_tool
			is_sensitive := True
		end

feature -- Access

	tool: EB_TOOL
			-- Tool managed.

	tooltip: STRING_GENERAL is
			-- Tooltip for Current
		do
			Result := interface_names.f_show_tool (tool.content.long_title)
		end

	tooltext: STRING_GENERAL is
			-- Text for toolbar button.
		do
			Result := tool.content.short_title
		end

	is_tooltext_important: BOOLEAN is
			-- Is the tooltext important shown when view is 'Selective Text'
		do
			Result := True
		end

	description: STRING_GENERAL is
			-- Description for current command.
		do
			Result := interface_names.f_show_tool (tool.content.short_title)
		end

	menu_name: STRING_GENERAL is
			-- Name as it appears in menus.
		do
			Result := tool.content.short_title
		end

	name: STRING is
			-- Name to be displayed.
		do
			Result := tool.title_for_pre
		end

	pixmap: EV_PIXMAP is
			-- Pixmap representing the item (for buttons)
		do
			Result := tool.content.pixmap
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := tool.content.pixel_buffer
		end

	mini_pixmap: EV_PIXMAP
			-- Mini pixmap		

	mini_pixel_buffer: EV_PIXEL_BUFFER
			-- Mini pixel buffer

feature -- Execution

	execute is
			-- Execute command (toggle between show and hide).
		local
			l_shared: SD_SHARED
			l_x, l_y: INTEGER
			l_window: EV_WINDOW
		do
			if not tool.content.is_visible then
				create l_shared
				l_window := window_manager.last_focused_development_window.window
				l_x := l_window.screen_x + l_window.width // 2 - l_shared.default_floating_window_width // 2
				l_y := l_window.screen_y + l_window.height // 2 - l_shared.default_floating_window_height // 2

				l_shared.set_default_screen_x (l_x)
				l_shared.set_default_screen_y (l_y)

				tool.content.show
			end
			tool.content.set_focus
		end

feature -- Basic operations

	new_sd_toolbar_item (a_display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			create Result.make (Current)
			initialize_sd_toolbar_item (Result, a_display_text)
			Result.select_actions.extend (agent execute)
			Result.select_actions.extend (agent update_sd_tooltip (Result))
		end

feature -- Element change

	set_accelerator (a_accel: EV_ACCELERATOR) is
			-- Set `accelerator' with `a_accel'.
		require
			a_accel_attached: a_accel /= Void
		do
			accelerator := a_accel
		ensure
			accelerator_not_void: accelerator = a_accel
		end

	set_mini_pixmap (a_mini_pixmap: EV_PIXMAP) is
			-- Set `mini_pixmap' with `a_mini_pixmap'.
		do
			mini_pixmap := a_mini_pixmap
		ensure
			mini_pixmap_set: mini_pixmap = a_mini_pixmap
		end

	set_mini_pixel_buffer (a_mini_pixel_buffer: EV_PIXEL_BUFFER) is
			-- Set `mini_pixel_buffer' with `a_mini_pixel_buffer'.
		do
			mini_pixel_buffer := a_mini_pixel_buffer
		ensure
			mini_pixmap_set: mini_pixel_buffer = a_mini_pixel_buffer
		end

feature -- Recyclable

	internal_recycle is
			-- Recycle
		do
			Precursor {EB_DEVELOPMENT_WINDOW_COMMAND}
			accelerator := Void
		end

feature {NONE} -- Implementation

	update_sd_tooltip (a_toogle: EB_SD_COMMAND_TOOL_BAR_BUTTON) is
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

feature {NONE} -- Implementation

	safety_flag: BOOLEAN;
			-- Are we changing the `is_selected' attribute? (To prevent stack overflows)

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_SHOW_TOOL_COMMAND
