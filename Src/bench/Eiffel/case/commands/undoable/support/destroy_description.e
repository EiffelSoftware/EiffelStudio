indexing

	description: 
		"Undoable command to destroy a description/explanation data.";
	date: "$Date$";
	revision: "$Revision $"

class DESTROY_DESCRIPTION 

inherit

	DESTROY
		redefine
			data
		end

creation

	make

feature -- Initialization

	make (entity: like data; data_cont: DATA) is
			-- Change the name of a partition
		require
			valid_entity: entity /= Void;
			valid_data_cont: data_cont /= Void
		do
			data_container := data_cont;
			data := entity;
			old_data := clone (data);
		end

feature -- Property

	name: STRING is
		local
			expl: EXPLANATION_DATA
		do
			!!Result.make (0);
			Result.append ("Remove ")
			expl ?= data;
			if expl = Void then
				Result.append ("description")
			else
				Result.append ("explanation")
			end
		end

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		do
			data.reset;
			update;
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			data.copy (old_data);
			update
		end;

feature {NONE} -- Implementation

	update is
		do
		--	data_container.update_display (data);
		--	windows.namer_window.update;
		end;

	data: DESCRIPTION_DATA;  

	data_container: DATA;  

	old_data: like data;
			-- New name given to the partition

end -- class CHANGE_NAME_U
