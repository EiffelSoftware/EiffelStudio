indexing

	description: 
		"Undoable command to set effective flag for class data.";
	date: "$Date$";
	revision: "$Revision $"

class SET_EFFECTIVE_U

inherit

	SET_CLASS_BOOLS
		redefine
			require_page_update
		end

creation
	make

feature -- Property

	name: STRING is
		do
			!! Result.make (0);
			Result.append ("Set effective ");
			if on then
				Result.append ("on")
			else
				Result.append ("off")
			end
		end

	require_page_update: BOOLEAN is True;

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		do
			if class_changed /= Void then
				class_changed.set_is_effective (on);
				update
			end
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			class_changed.set_is_effective (not on);
			update
		end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			if toggle /= Void then
				on := toggle.state
				class_changed ?= class_window.entity
				if class_changed /= Void then
					if on /= class_changed.is_effective then
						record
						redo
					end
				end
			end
		end


end -- class SET_EFFECTIVE_U
