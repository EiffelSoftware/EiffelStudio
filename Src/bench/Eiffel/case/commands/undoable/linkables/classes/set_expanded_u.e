indexing

	description: 
		"Undoable command to set deferred flag for class data.";
	date: "$Date$";
	revision: "$Revision $"

class SET_EXPANDED_U 

inherit

	SET_CLASS_BOOLS
		redefine
			require_page_update
		end

feature -- Property

	name: STRING is
		do
			!! Result.make (0);
			Result.append ("Set expanded ");
			if on then
				Result.append ("on")
			else
				Result.append ("off")
			end
		end

feature -- Update

	require_page_update: BOOLEAN is True;

	redo is
			-- Re-execute command (after it was undone).
		do
			class_changed.set_expanded (on);
			update
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			class_changed.set_expanded (not on);
			update
		end

feature -- Execution

	execute (class_window: CLASS_WINDOW) is
		do
			on := class_window.annotations_page.expanded_b.state;
			record;
			class_changed := class_window.entity;
			redo
		end

end -- class SET_DEFERRED_U
