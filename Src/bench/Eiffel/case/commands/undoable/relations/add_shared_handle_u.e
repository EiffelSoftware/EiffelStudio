indexing

	description: 
		"Undoable command that adds a shared handle.";
	date: "$Date$";
	revision: "$Revision $"

class ADD_SHARED_HANDLE_U 

inherit

	UNDOABLE_EFC

creation

	make

feature -- Initialization

	make (to_share: like shared_handle; a_link: like link; a_position: like position) is
			-- Create a new cluster
		require
			to_share /= void;
			a_link /= void;
			a_position >= 0;
			a_position <= a_link.break_points.count
		do
			set_watch_cursor;
			record;
			shared_handle := to_share;
			link := a_link;
			position := a_position;
			redo;
			restore_cursor;
		end

feature -- Property

	name: STRING is "New shared handle"

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		do
			shared_handle.set_shared (shared_handle.shared+1);
			link.break_points.go_i_th (position);
			link.break_points.put_right (shared_handle);
			workareas.change_data (link);
			workareas.refresh;
			System.set_is_modified
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			shared_handle.set_shared (shared_handle.shared-1);
			link.break_points.go_i_th (position+1);
			link.break_points.remove;
			workareas.change_data (link);
			workareas.refresh;
			System.set_is_modified
		end
	
feature {NONE}

	link: RELATION_DATA;
			-- Link who will have a new handle

	position: INTEGER;
			-- Handle after which is located the new one

	shared_handle: HANDLE_DATA;
			-- Handle destroyed

end -- class ADD_SHARED_HANDLE_U
