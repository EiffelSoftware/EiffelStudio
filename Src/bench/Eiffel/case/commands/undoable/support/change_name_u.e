indexing

	description: 
		"Undoable command to change a name of entity.";
	date: "$Date$";
	revision: "$Revision $"

class CHANGE_NAME_U 

inherit

	UNDOABLE_EFC
		redefine
			request_for_data, free_data
		end

creation

	make

feature -- Initialization

	make (entity: like partition; to: STRING) is
			-- Change the name of a partition
		require
			valid_entity: entity /= Void;
			valid_to: to /= Void
		do
			if not to.empty and then not equal (entity.name, to) then
				partition := entity;
				new_name := clone (to);
				old_name := clone (entity.name);
				record;
				redo
			end
		end -- make

feature -- Properties

	name: STRING is "Change name"

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		do
			partition.set_name (clone (new_name));
			update;
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			partition.set_name (clone (old_name));
			update
		end;

feature {NONE} -- Implementation

	update is
		local
			namer_data: DATA
		do
			partition.update_name;
			if Windows.namer_window.namable /= Void then
				Windows.namer_window.resync
			end
		end;

	partition: NAME_DATA;
			-- Partition modified

	new_name: STRING;
			-- New name given to the partition

	old_name: STRING;
			-- Partition's old name

	request_for_data is
		local
			f_data: FEATURE_DATA
		do
				-- For feature data
			f_data ?= partition;
			if f_data /= Void then
				f_data.request_for_information
			end
		end;

	free_data is
		local
			f_data: FEATURE_DATA
		do
			f_data ?= partition;
			if f_data /= Void then
				f_data.free_information
			end
		end;

end -- class CHANGE_NAME_U
