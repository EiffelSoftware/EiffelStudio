indexing
	description: "Command to center the diagram on a stone"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CENTER_DIAGRAM_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			new_toolbar_item
		end
		
create
	make

feature -- Basic operations

	execute is
			-- Display information about `Current'.
		do
			create explain_dialog.make_with_text (Interface_names.e_Diagram_hole)
			explain_dialog.show_modal_to_window (tool.development_window.window)
		end

	execute_with_stone (a_stone: STONE) is
			-- Create a development window and process `a_stone'.
		do
			tool.tool.set_stone (a_stone)
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text, use_gray_icons)
			Result.select_actions.wipe_out
			Result.select_actions.extend (~execute)
			Result.drop_actions.extend (~execute_with_stone)
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_center_diagram
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.F_retarget_diagram
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.F_retarget_diagram
		end

	name: STRING is "Center_diagram"
			-- Name of the command. Used to store the command in the
			-- preferences.

	explain_dialog: EB_INFORMATION_DIALOG
			-- Dialog explaining how to use `Current'.

end -- class EB_CENTER_DIAGRAM_COMMAND
