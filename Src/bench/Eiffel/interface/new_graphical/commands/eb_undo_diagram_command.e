indexing
	description	: "Command to undo diagram commands."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_UNDO_DIAGRAM_COMMAND

inherit
	EB_CONTEXT_DIAGRAM_COMMAND
		redefine
			initialize
		end

create
	make
	
feature {NONE} -- Initialization
		
	initialize is
			-- Initialize default values.
		do
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (key_constants.key_z),
				True, False, False)
			accelerator.actions.extend (agent execute)
		end

feature -- Basic operations

	execute is
			-- Perform operation.
		do
			if is_sensitive then
				history.undo
			end
		end

feature {EB_DEVELOPMENT_WINDOW} -- Accelerator action

	on_ctrl_z is
			-- Undo last action if possible and if the diagram
			-- has the focus.
		do
			if is_sensitive and then tool.projector.widget.has_focus and then not history.undo_exhausted then
				execute
			end
		end

feature {NONE} -- Implementation

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- gray version, one for the color version).
		do
			Result := Pixmaps.Icon_undo
		end

	tooltip: STRING is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_diagram_undo
		end

	name: STRING is "Undo_command"
			-- Name of the command. Used to store the command in the
			-- preferences.

end -- class EB_UNDO_DIAGRAM_COMMAND
