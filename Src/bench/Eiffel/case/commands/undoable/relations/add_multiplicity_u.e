indexing

	description: 
		"Undoable command which adds a multiplicity%
		%specification to 'link'.";
	date: "$Date$";
	revision: "$Revision $"

class ADD_MULTIPLICITY_U 

inherit

	MULTIPLICITY_U

creation

	make

feature -- Initialization

	make (a_link : like link; reverse_capability : BOOLEAN) is
			-- Add a multiplicity specification to 'link'
		require
			has_link : a_link /= Void
		do
			set_watch_cursor;
			link := a_link;
			reverse := reverse_capability;
			record;
			redo;
			restore_cursor;
		ensure
			link_correctly_set : link = a_link;
			reverse_correctly_set : reverse = reverse_capability
		end -- make

feature -- Property

	name: STRING is
		do
			if reverse then
				Result :=  "Add reverse multiplicity specification to link"
			else
				Result :=  "Add multiplicity specification to link"
			end
		end 

feature -- Update

	redo is
			-- Re-execute command (after it was undone)
		do
			multiplie;
			update
		end; -- redo

	undo is
			-- Cancel effect of executing the command
		do
			unmultiplie;
			update
		end -- undo

end -- class ADD_MULTIPLICITY_U
