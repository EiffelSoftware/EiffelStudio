indexing
	description: "Command to comment selected lines"
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
				Result.select_actions.extend (~execute)
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
				Result.select_actions.extend (~execute)
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

end -- class EB_COMMENT_COMMAND
