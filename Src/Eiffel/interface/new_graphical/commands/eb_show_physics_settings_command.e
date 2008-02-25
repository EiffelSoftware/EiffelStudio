indexing
	description: "Command to show the settings dialog for physics."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHOW_PHYSICS_SETTINGS_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_sd_toolbar_item,
			description,
			initialize,
			menu_name
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize default values.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_p),
				True, False, True)
			accelerator.actions.extend (agent execute)
		end

feature -- Basic operations

	execute is
			-- Perform operation.
		local
			dialog: EB_FORCE_SETTINGS_DIALOG
		do
			if is_sensitive then
				create dialog.make (tool.force_directed_layout, tool)
				dialog.show_modal_to_window (tool.develop_window.window)
			end
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			create Result.make (Current)
			initialize_sd_toolbar_item (Result, display_text)
			Result.select_actions.extend (agent execute)
		end

feature -- Access

	tooltip: STRING_GENERAL is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_force_settings
		end

feature {NONE} -- Implementation

	pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.diagram_physics_settings_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.diagram_physics_settings_icon_buffer
		end

	description: STRING_GENERAL is
			-- Description for this command.
		do
			Result := Interface_names.f_diagram_force_settings
		end

	menu_name: STRING_GENERAL is
			-- Name on corresponding menu items
		do
			Result := Interface_names.f_diagram_force_settings
		end

	name: STRING is "Force_settings";
			-- Name of the command. Used to store the command in the
			-- preferences.

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

end -- class EB_SHOW_PHYSICS_SETTINGS_COMMAND
