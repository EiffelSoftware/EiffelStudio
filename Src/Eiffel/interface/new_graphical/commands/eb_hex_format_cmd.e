note
	description: ""
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_HEX_FORMAT_CMD

	-- Replace ANY below by the name of parent class if any (adding more parents
	-- if necessary); otherwise you can remove inheritance clause altogether.
inherit
	EB_TOOLBARABLE_COMMAND
		redefine
			mini_pixmap,
			mini_pixel_buffer,
			new_mini_sd_toolbar_item
		end

create
	make

feature -- Initialization

	make (a_callback: like command_call_back)
			-- Initialize `Current' and associate it with `tool'.
		do
			command_call_back := a_callback
		end

feature -- Access

	pixmap: EV_PIXMAP
			-- Pixmap representing the command.
		do
			--| No big pixmap is required for this command.
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			--| No big pixmap is required for this command.
		end

	mini_pixmap: EV_PIXMAP
			-- Pixmap representing the command for mini toolbars.
		do
			Result := pixmaps.mini_pixmaps.debugger_show_hex_value_icon
		end

	mini_pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command for mini toolbars.
		do
			Result := pixmaps.mini_pixmaps.debugger_show_hex_value_icon_buffer
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.e_switch_num_format_to_hex
		end

feature -- Measurement

feature -- Status report

	command_call_back: PROCEDURE [BOOLEAN]
			-- Call back procedure to execute current

	name: STRING_GENERAL
			-- Name of the command.
		do
			Result := Interface_names.e_Switch_num_formating
		end

	description: STRING_GENERAL
			-- Description of the command.
		do
			Result := Interface_names.l_Switch_num_format_desc
		end

feature -- Execution

	execute
			-- Remove an object from `tool'.
		do
			if command_call_back /= Void then
				command_call_back.call ([is_button_selected])
			end
			if is_button_selected then
				change_tooltip (interface_names.e_Switch_num_format_to_dec)
			else
				change_tooltip (interface_names.e_Switch_num_format_to_hex)
			end
		end

feature -- Basic operations

	new_mini_sd_toolbar_item: EB_SD_COMMAND_TOOL_BAR_TOGGLE_BUTTON
			-- Create a new sd mini toolbar button for this command.
		do
			create Result.make (Current)
			Result.set_pixmap (mini_pixmap)
			if is_sensitive then
				Result.enable_sensitive
			else
				Result.disable_sensitive
			end
			Result.set_tooltip (tooltip)
			Result.select_actions.extend (agent execute)

			sd_toggle_button := Result
		end

feature {NONE} -- Implementation

	is_button_selected: BOOLEAN
			-- Is button selected?
		do
			if toggle_button /= Void then
				Result := toggle_button.is_selected
			else
				Result := sd_toggle_button.is_selected
			end
		end

	change_tooltip (a_tooltip: STRING_GENERAL)
			-- Change tooltip on button.
		require
			a_tooltip_not_void: a_tooltip /= Void
		do
			if toggle_button /= Void then
				toggle_button.set_tooltip (a_tooltip)
			end
			if sd_toggle_button /= Void then
				sd_toggle_button.set_tooltip (a_tooltip)
			end
		end

	toggle_button: EV_TOOL_BAR_TOGGLE_BUTTON;

	sd_toggle_button: EB_SD_COMMAND_TOOL_BAR_TOGGLE_BUTTON;

note
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

end -- class EB_HEX_FORMAT_CMD
