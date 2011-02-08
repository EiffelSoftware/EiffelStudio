note
	description: "Command to display system information in output tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_INFORMATION_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext
		end

	EB_SHARED_INTERFACE_TOOLS
		export {NONE} all end

	EB_CONSTANTS
		export {NONE} all end

	ES_SHARED_OUTPUTS
		export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize default_values.
		do
		end

feature -- Basic operations

	execute
			-- Display system information in general output tool
		local
			l_formatter: like general_formatter
			l_auto_scrolled_changed: BOOLEAN
			l_locked: BOOLEAN
			retried: BOOLEAN
		do
			if attached general_output as l_output then
				if not retried then
					l_formatter := general_formatter
					l_output.activate (True)

					if attached {ES_OUTPUT_PANE_I} l_output as l_output_pane then
						if l_output_pane.is_auto_scrolled then
							l_output_pane.is_auto_scrolled := False
							l_auto_scrolled_changed := True
						end
					end

					l_output.lock
					l_locked := True

					l_output.clear;
					(create {ES_OUTPUT_ROUTINES}).append_system_info (l_formatter)

					l_locked := False
					l_output.unlock

					if l_auto_scrolled_changed and then attached {ES_OUTPUT_PANE_I} l_output as l_output_pane then
						l_output_pane.is_auto_scrolled := True
					end
				elseif l_locked then
					l_output.unlock
				end
			else
				check False end
			end
		end

feature {NONE} -- Implementation

	name: STRING = "System_info"
			-- Name of command. Used to store command in preferences

	pixmap: EV_PIXMAP
			-- Pixmap representing command.
		do
			Result := pixmaps.icon_pixmaps.command_system_info_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.command_system_info_icon_buffer
		end

	description: STRING_GENERAL
			-- Description for command
		do
			Result := Interface_names.e_Display_system_info
		end

	tooltip: STRING_GENERAL
			-- Tooltip for toolbar button
		do
			Result := Interface_names.e_Display_system_info
		end

	tooltext: STRING_GENERAL
			-- Tooltip for toolbar button
		do
			Result := Interface_names.b_System_info
		end

	menu_name: STRING_GENERAL
		do
			Result := Interface_names.m_Display_system_info
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
