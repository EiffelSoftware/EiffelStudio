indexing

	description: 
		"Undoable command to set persistence flag for class data.";
	date: "$Date$";
	revision: "$Revision $"

class SET_PERSISTENT_U 

inherit

	SET_CLASS_BOOLS

creation
	make

feature -- Property

	name: STRING is
		do
			!! Result.make (0);
			Result.append ("Set persistent ");
			if on then
				Result.append ("on")
			else
				Result.append ("off")
			end
		end

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		do
			if class_changed /= Void then
				class_changed.set_persistent (on);
				update
			end
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			class_changed.set_persistent (not on);
			update
		end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			if toggle /= Void then
				on := toggle.state
				class_changed ?= class_window.entity
				if class_changed /= Void then
					if on /= class_changed.is_persistent then
						record
						redo
					end
				end
			end
		end


end -- class SET_PERSISTENT_U
