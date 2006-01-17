indexing
	description: "Command to comment selected lines"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne AMODEO"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_COMMENT_COMMAND


inherit

	EB_CONSTANTS

	EB_ON_SELECTION_COMMAND
		redefine
			new_toolbar_item,
			new_menu_item			
		end

create
	make

feature -- Execution

	execute is
			-- comment selected lines
		do
			target.editor_tool.text_area.comment_selection
		end


feature -- Basic operations

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
			do
					-- Add it to the managed toolbar items
				if managed_toolbar_items = Void then
					create managed_toolbar_items.make (1)
				end
					-- Create the button
				create Result.make (Current)
				if display_text and pixmap.count >= 4 then
					Result.set_pixmap (pixmap @ 3)
					if use_gray_icons then
						Result.set_gray_pixmap (pixmap @ 4)
					end
				else
					Result.set_pixmap (pixmap @ 1)
					if use_gray_icons then
						Result.set_gray_pixmap (pixmap @ 2)
					end
				end
				Result.select_actions.extend (agent execute)
				if executable then
					Result.enable_sensitive
				else
					Result.disable_sensitive
				end
			end

	new_menu_item: EB_COMMAND_MENU_ITEM is
			-- Create a new menu entry for this command.
			do
					-- Add it to the managed menu items
				if managed_menu_items = Void then
					create managed_menu_items.make (1)
				end
					-- Create the menu item
				create Result.make (Current)
				Result.set_text (menu_name)
				Result.select_actions.extend (agent execute)
				if executable then
					Result.enable_sensitive
				else
					Result.disable_sensitive
				end
			end



feature {NONE} -- Implementation

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Comment
		end

	name: STRING is "Comment selection"
			-- Name of the command. Used to store the command in the
			-- preferences.

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
--|FIXME Etienne : Wrong icon
			Result := Pixmaps.Icon_paste
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Comment
		end


	description: STRING is
			-- Description for current command
		do
			Result := Interface_names.e_Comment
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_COMMENT_COMMAND
