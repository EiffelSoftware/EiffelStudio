indexing
	description	: "Command to redo diagram commands."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_REDO_DIAGRAM_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND

create
	make

feature -- Basic operations

	execute is
			-- Perform operation.
		do
			history.redo
		end

feature {EB_DEVELOPMENT_WINDOW} -- Accelerator action

	on_ctrl_y is
			-- Redo last cancelled action if possible and if the diagram
			-- has the focus.
		do
			if tool.projector.widget.has_focus and then not history.redo_exhausted then
				execute
			end
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_redo
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := "Redo last action"
		end

	description: STRING is
			-- Description for this command.
		do
			Result := "Redo last undoable command"
		end

	name: STRING is "Redo_command"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_REDO_DIAGRAM_COMMAND
