indexing

	description: 
		"Undoable command for adding an aggregate link.";
	date: "$Date$";
	revision: "$Revision $"

class ADD_AGGREG_U 

inherit

	UNDOABLE_EFC

creation

	make

feature -- Initialization

	make (a_link: CLI_SUP_DATA) is
			-- Create a new cluster
		require
			a_link /= void;
			a_link.is_aggregation
		do
			if not a_link.already_in_system then
				set_watch_cursor;
				record;
				link := a_link;
				redo;
				restore_cursor;
			end;
		end

feature -- Property

	name: STRING is "New aggregation link"

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		do
			link.put_in_system;
			workareas.new_aggreg (link);
			update
		end; -- redo

	undo is
			-- Cancel effect of executing the command.
		do
			link.remove_from_system;
			workareas.destroy_aggreg (link);
			update
		end; -- undo

feature {NONE} -- Implementation property

	link: CLI_SUP_DATA;
			-- New link

feature {NONE} -- Implementation

	update is
		local
			class_d: CLASS_DATA
		do
			class_d ?= link.client;
			if class_d /= Void then
				class_d.update_display (link.supplier);
			end
			class_d ?= link.supplier;
			if class_d /= Void then
				class_d.update_display (link.client);
			end
			workareas.refresh;
			System.set_is_modified
		end; -- update

end -- class ADD_AGGREG_U
