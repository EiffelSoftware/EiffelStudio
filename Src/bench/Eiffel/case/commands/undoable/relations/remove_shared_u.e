indexing

	description: 
		"Undoable command which remove the shared%
		%specification of 'link'";
	date: "$Date$";
	revision: "$Revision $"

class REMOVE_SHARED_U 

inherit

	SHARED_U

creation

	make

feature -- Initialization

	make (a_link : like link; a_value : like value; reverse_capability : BOOLEAN) is
			-- Remove shared specification of 'link'
		require
			has_link : a_link /= Void
		do
			set_watch_cursor;
			link := a_link;
			value := a_value;
			reverse := reverse_capability;
			history.record (Current);
			redo;
			restore_cursor;
		ensure
			link_correctly_set : link = a_link;
			value_correctly_set : value = a_value;
			reverse_correctly_set : reverse = reverse_capability
		end -- make

feature -- Properties

	name: STRING is 
		do
			if reverse then
				Result := "Remove reverse shared specification of link"
			else
				Result := "Remove shared specification of link"
			end
		end -- name

feature -- Update

	redo is
			-- Re-execute command (after it was undone)
		do
			unshared;
			update
		end; -- redo

	undo is
			-- Cancel effect of executing the command
		do
			shared;
			link.set_shared_value (value, reverse);
			if link.reverse_multiplicity /= 0 or else
				link.multiplicity /= 0
			then
				workareas.change_multiplicity (link, reverse);
			end;
			update
		end -- undo

feature {NONE}

	value: INTEGER
			-- Number of shared features

end -- class REMOVE_SHARED_U
