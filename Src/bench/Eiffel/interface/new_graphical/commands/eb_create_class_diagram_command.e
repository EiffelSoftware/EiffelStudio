indexing
	description	: "Command to change links layout."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CREATE_CLASS_DIAGRAM_COMMAND

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
		local
			dialog: EB_CREATE_CLASS_DIALOG
		do
			create dialog.make_default (tool.development_window)
			dialog.call_default
		end

	new_toolbar_item (display_text: BOOLEAN; use_gray_icons: BOOLEAN): EB_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		local
			a_stone: CREATE_CLASS_STONE
		do
			create a_stone
			Result := Precursor (display_text, use_gray_icons)
			Result.set_pebble (a_stone)
			Result.set_accept_cursor (Cursors.cur_Class)
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_new_class
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_new_class
		end

	name: STRING is "Create_class"
			-- Name of the command. Used to store the command in the
			-- preferences.

	explain_dialog: EB_INFORMATION_DIALOG
			-- Dialog explaining how to use `Current'.

end -- class EB_CREATE_CLASS_DIAGRAM_COMMAND
