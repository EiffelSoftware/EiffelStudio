indexing
	description	: "Command to browse through the history of undoable diagram commands."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_DIAGRAM_HISTORY_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item
		end

create
	make

feature -- Basic operations

	execute is
			-- Display history dialog.
		do
			history.show_relative_to_window (tool.development_window.window)
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text, use_gray_icons)
			Result.select_actions.extend (~execute)
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_cmd_history
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := "History tool"
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "History tool"
		end

	name: STRING is "History_tool"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_DIAGRAM_HISTORY_COMMAND
