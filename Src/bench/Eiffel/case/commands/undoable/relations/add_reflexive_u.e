indexing

	description: 
		"Undoable command for adding reflexive links.";
	date: "$Date$";
	revision: "$Revision $"

class ADD_REFLEXIVE_U 

inherit

	UNDOABLE_EFC

creation

	make

feature -- Initialization

	make (a_link : CLI_SUP_DATA) is
			-- Create a new cluster
		require
			has_link : a_link /= Void
		do
			set_watch_cursor;
			record;
			link := a_link;
			redo;
			restore_cursor;
		ensure
			link_correctly_set : link = a_link
		end -- Make

feature -- Property

	name: STRING is "New reflexive link"

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		do
			link.put_in_system;
			workareas.new_reflexive (link);
			workareas.refresh;
			link.client.update_display (link.client);
			System.set_is_modified
		end; -- redo

	undo is
			-- Cancel effect of executing the command.
		do
			link.remove_from_system;
			workareas.destroy_reflexive (link);
			workareas.refresh;
			link.client.update_display (link.client);
			System.set_is_modified
		end -- undo

feature {NONE} -- Implementation

	link: CLI_SUP_DATA;
			-- New link

end -- class ADD_REFLEXIVE_U
