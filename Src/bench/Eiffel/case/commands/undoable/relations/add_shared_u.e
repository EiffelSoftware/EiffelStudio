indexing

	description: 
		"Undoable command which adds a shared specification to 'link'";
	date: "$Date$";
	revision: "$Revision $"

class ADD_SHARED_U 

inherit

	SHARED_U

creation

	make

feature -- Initialization

	make (a_link : like link; reverse_capability : BOOLEAN) is
			-- Add a shared specification to 'link'
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
				Result := "Add reverse shared specification to link"
			else
				Result := "Add shared specification to link"
			end
		end -- name

feature -- Update

	redo is
			-- Re-execute command (after it was undone)
		do
			shared;
			update
		end; -- redo

	undo is
			-- Cancel effect of executing the command
		do
			unshared;
			update
		end -- undo

end -- class ADD_SHARED_U
