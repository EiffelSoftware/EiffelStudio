indexing
	description	: "Command to perform an undo operation"
	date		: "$Date$"
	revision	: "$Revision $"

class
	EB_UNDO_COMMAND

inherit
	EB_UNDO_REDO_COMMAND
		redefine
			executable
		end
			

creation
	make

feature -- Status report

	executable: BOOLEAN is
			-- Is the operation possible?
		do
			Result := editor.undo_is_possible
		end

feature -- Execution

	execute is
			-- Execute the undo/redo operation
		do
			editor.undo
		end

feature {NONE} -- Implementation

	menu_name: STRING is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Undo
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_undo
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Undo
		end

	description: STRING is
			-- Description for this command.
		do
			Result := Interface_names.e_Undo
		end

	name: STRING is "Undo"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_UNDO_COMMAND
