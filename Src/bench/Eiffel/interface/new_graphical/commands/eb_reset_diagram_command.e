indexing
	description	: "Command to edit class headers."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_RESET_DIAGRAM_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND

create
	make

feature -- Basic operations

	execute is
		do
			tool.reset
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_reset_diagram
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := "Redo default placement"
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "Reset diagram"
		end

	name: STRING is "Reset_diagram"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_RESET_DIAGRAM_COMMAND



