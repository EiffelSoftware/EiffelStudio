indexing

	description: 
		"Undoable command for adding a client-supplier link.";
	date: "$Date$";
	revision: "$Revision $"

class ADD_CLIENT_U 

inherit

	UNDOABLE_EFC

creation

	make

feature -- Initialization

	make (a_link: CLI_SUP_DATA) is
			-- Create a new cluster
		do
			if not a_link.already_in_system then
				set_watch_cursor;
				record;
				link := a_link;
				redo;
				restore_cursor;
			end
		end; 

feature -- Property

	name: STRING is "New client supplier link"

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		do
			link.put_in_system;
			workareas.new_client (link);
			update;
		end; -- redo

	undo is
			-- Cancel effect of executing the command.
		do
			link.remove_from_system;
			workareas.destroy_client (link);
			update;
		end; -- undo

feature {NONE} -- Implementation

	update is
		local
			class_d: CLASS_DATA
		do
			class_d ?= link.client
			if class_d /= Void then
				class_d.update_display (link.supplier)
			end;
			class_d ?= link.supplier
			if class_d /= Void then
				class_d.update_display (link.client)
			end
			workareas.refresh;
			System.set_is_modified
		end; -- update

	
feature {NONE,CANCEL_COM}

	link: CLI_SUP_DATA;
			-- New link

end -- class ADD_CLIENT_U
