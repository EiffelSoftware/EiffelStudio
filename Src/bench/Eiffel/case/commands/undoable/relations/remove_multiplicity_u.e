indexing

	description: 
		"Undoable command  which remove the multiplicity%
		%specification of 'link'";
	date: "$Date$";
	revision: "$Revision $"

class REMOVE_MULTIPLICITY_U 

inherit

	MULTIPLICITY_U

creation

	make

feature -- Initialization

	make (a_link : like link; a_value : like value; reverse_capability : BOOLEAN) is
			-- Remove multiplicity specification of 'link'
		require
			has_link : a_link /= Void
		do
			set_watch_cursor;
			link := a_link;
			value := a_value;
			reverse := reverse_capability;
			record;
			redo;
			restore_cursor;
		ensure
			link_correctly_set : link = a_link;
			value_correctly_set : value = a_value;
			reverse_correctly_set : reverse = reverse_capability
		end -- make

feature -- Property

	name: STRING is 
		do
			if reverse then
				Result := "Remove reverse multiplicity specification of link"
			else
				Result := "Remove multiplicity specification of link"
			end
		end -- name

feature -- Update

	redo is
			-- Re-execute command (after it was undone)
		do
			unmultiplie;
			update
		end; -- redo

	undo is
			-- Cancel effect of executing the command
		do
			multiplie;
			link.set_multiplicity (value, reverse);
			workareas.change_multiplicity (link, reverse);
			update
		end -- undo

feature {NONE}

	value: INTEGER
			-- Multiplicity of 'link'

end -- class REMOVE_MULTIPLICITY_U
