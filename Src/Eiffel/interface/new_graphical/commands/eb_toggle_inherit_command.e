note
	description	: "Command to change visibility of inheritance layer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_TOGGLE_INHERIT_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		undefine
			menu_name
		redefine
			new_sd_toolbar_item,
			description,
			initialize
		end

	EB_CONTEXT_DIAGRAM_TOGGLE_COMMAND

create
	make

feature {NONE} -- Initialization

	initialize
			-- Initialize default values.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_i),
				True, False, False)
			accelerator.actions.extend (agent execute)
		end

feature -- Basic operations

	execute
			-- Perform operation.
		do
			if is_sensitive then
				if tool.world.is_inheritance_links_shown then
					tool.world.hide_inheritance_links
				else
					tool.world.show_inheritance_links
				end
				if tool.world.is_inheritance_links_shown then
					enable_select
				else
					disable_select
				end
				tool.projector.project
			end
		end

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_TOGGLE_BUTTON
			-- Create a new toolbar button for this command.
			--
			-- Call `recycle' on the result when you don't need it anymore otherwise
			-- it will never be garbage collected.
		do
			create Result.make (Current)
			current_button := Result
			if tool.world.is_inheritance_links_shown then
				Result.enable_select
			end
			initialize_sd_toolbar_item (Result, display_text)
			Result.select_actions.extend (agent execute)
		end

feature -- Access

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			if current_button.is_selected then
				Result := Interface_names.f_diagram_hide_inheritance
			else
				Result := Interface_names.f_diagram_show_inheritance
			end
		end

feature {NONE} -- Implementation

	pixmap: EV_PIXMAP
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.diagram_inheritance_link_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.diagram_inheritance_link_icon_buffer
		end

	description: STRING_GENERAL
			-- Description for this command.
		do
			Result := Interface_names.l_diagram_inheritance_visibility
		end

	name: STRING = "Inherit_visibility"
			-- Name of the command. Used to store the command in the
			-- preferences.

feature {ES_DIAGRAM_TOOL_PANEL} -- Implementation

	current_button: EB_SD_COMMAND_TOOL_BAR_TOGGLE_BUTTON;
			-- Current toggle button.

note
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

end -- class EB_TOGGLE_INHERIT_COMMAND

