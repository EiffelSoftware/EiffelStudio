indexing
	description: "Command to crop displayed diagram"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CROP_DIAGRAM_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			menu_name
		end

create 
	make

feature -- Basic operations

	execute is
			-- Display history dialog.
		do
			tool.crop_diagram
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := pixmaps.icon_crop
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.F_diagram_crop
		end

	Name: STRING is "Crop_diagram"
			-- Name of the command. Used to store the command in the
			-- preferences.

	menu_name: STRING is
		do
			Result := Interface_names.M_diagram_crop
		end

end -- class EB_DIAGRAM_HISTORY_COMMAND