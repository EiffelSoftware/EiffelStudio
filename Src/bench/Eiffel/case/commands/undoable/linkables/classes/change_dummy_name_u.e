indexing

	description: 
		"Undoable command for changing dummy class names.";
	date: "$Date$";
	revision: "$Revision $"


class CHANGE_DUMMY_NAME_U 

inherit

	UNDOABLE_EFC
		redefine
			request_for_data, free_data
		end

creation

	make

feature -- Initialization

	make (entity: DATA; a_data: like data; to: STRING) is
			-- Change the name of a data_container
		require
			valid_a_data: a_data /= Void;
			valid_entity: entity /= Void;
			valid_to: to /= Void
			not_to_empty: not to.empty
		do
			if not to.empty and then a_data /= Void and then 
				not equal (a_data.name, to) 
			then
				data_container := entity;
				data := a_data;
				record;
				new_name := clone (to);
				old_name := clone (data.name);
				redo
			end
		end -- make

feature -- Property

	name: STRING is "Change name"

feature -- Update

	redo is
			-- Re-execute command (after it was undone).
		do
			data.set_name (clone (new_name));
			update;
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			data.set_name (clone (old_name));
			update
		end;

feature {NONE} -- Implementation

	update is
		do
			data_container.update_display (data);
		end;

	data: TYPE_DECLARATION;	

	data_container: DATA;  
			-- data_container modified

	new_name: STRING;
			-- New name given to the data

	old_name: STRING;
			-- Data's old name

	request_for_data is
		local
			f_data: FEATURE_DATA;
		do
			f_data ?= data_container;
			if f_data /= Void then
				f_data.class_container.request_for_information
			end
		end;

	free_data is
		local
			f_data: FEATURE_DATA;
		do
			f_data ?= data_container;
			if f_data /= Void then
				f_data.class_container.free_information
			end
		end;

end -- class CHANGE_DUMMY_NAME_U
