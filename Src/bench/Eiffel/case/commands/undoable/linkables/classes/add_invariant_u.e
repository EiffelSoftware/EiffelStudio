indexing

	description: 
		"Undoable command for adding invariant data.";
	date: "$Date$";
	revision: "$Revision $"


class ADD_INVARIANT_U 

inherit

	ADD_CLASS_ELEMENT
		redefine
			data
		end

creation

	make, make_with

feature -- Property

	name: STRING is 
		once
			Result := "Add invariant"
		end;

feature -- Update

	redo is
			-- Execute command.
		do
			data_container.add_invariant (data);
			update
		end;

	undo is
			-- Cancel effect of executing the command.
		do
			data_container.invariants.start;
			data_container.invariants.prune (data);
			update
		end

feature -- Element change

	create_data is
		do
			!! data.make ("tag", "true=true");
		end

feature {NONE} -- Update

	data: INVARIANT_DATA;

end -- class ADD_INVARIANT_U
