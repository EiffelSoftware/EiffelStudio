indexing

	description: 
		"Undoable command for adding inheritance.";
	date: "$Date$";
	revision: "$Revision $"

class ADD_INHERIT_U 

inherit

	UNDOABLE_EFC

creation

	make

feature -- Initialization

	make (a_link: INHERIT_DATA) is
			-- Create a new cluster
		do
			if not a_link.already_in_system and then
				a_link.is_not_reversed
			then
				set_watch_cursor;
				record;
				link := a_link;
				redo;
				restore_cursor;
			end
		end; -- Create

feature -- Property

	name: STRING is "New inheritance link"

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		do
			link.put_in_system;
			workareas.new_inherit (link);
			update
		end

	undo is
			-- Cancel effect of executing the command.
		do
			link.remove_from_system;
			workareas.destroy_inherit (link);
			update
		end; -- undo

feature {NONE} -- Implementation

	update is
		local
			class_d: CLASS_DATA
		do
			class_d ?= link.heir;
			if class_d /= Void then
				class_d.update_display (link.parent);
			end;
			class_d ?= link.parent;
			if class_d /= Void then
				class_d.update_display (link.heir);
			end;
			workareas.refresh;
			System.set_is_modified
		end; -- redo

	link: INHERIT_DATA;
			-- New link

end -- class ADD_INHERIT_U
