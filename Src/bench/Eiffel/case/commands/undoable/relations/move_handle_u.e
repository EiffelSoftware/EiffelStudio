indexing

	description: 
		"Undoable command that moves a handle.";
	date: "$Date$";
	revision: "$Revision $"

class MOVE_HANDLE_U 

inherit

	UNDOABLE_EFC;

creation

	make

feature -- Initialization

	make (a_handle: like handle; position: like new_position) is
			-- Create a new cluster
		require
			a_handle /= void;
			position /= void
		do
			set_watch_cursor;
			record;
			handle := a_handle;
			new_position := position;
			!!old_position;
			old_position.set (handle);
			redo;
			restore_cursor;
		end


feature -- Property

	name: STRING is "Move handle"

feature -- update

	redo is
			-- Re-execute command (after it was undone).
		do
			handle.set (new_position);
			workareas.move_handle (handle);
			workareas.refresh;
			System.set_is_modified
		end; -- redo

	undo is
			-- Cancel effect of executing the command.
		do
			handle.set (old_position);
			workareas.move_handle (handle);
			workareas.refresh;
			System.set_is_modified
		end; -- undo

	
feature {NONE} -- Initialization

	handle: HANDLE_DATA;
			-- Handle moved

	old_position: like new_position;
			-- Old position of handle

	new_position: COORD_XY_DATA
			-- New position of handle

end -- class MOVE_HANDLE_U
