indexing

	description: 
		"Undoable command to set a visibility  format in a cluster window.";
	date: "$Date$";
	revision: "$Revision $"

class SET_VISIBILITY_U

inherit

	UNDOABLE_EFC

creation

	make
	
feature -- Initialization

	make (vis_com: SET_VISIBILITY; nm: STRING) is
		require
			vis_com_exists: vis_com /= Void
			valid_name: nm /= Void
		do
			name := nm 
			visibility_command := vis_com;
			record;
			redo
		ensure
			name_set: name = nm
			visibility_command_set: visibility_command = vis_com
		end;

feature -- Property

	name: STRING;
			-- Command name

feature -- Update

	redo, undo is
			-- Execute/Undo command.
		do
			visibility_command.change_visibility;
		end;

feature {NONE} -- Implementation

	visibility_command: SET_VISIBILITY;

end -- class SET_VISIBILITY_U









