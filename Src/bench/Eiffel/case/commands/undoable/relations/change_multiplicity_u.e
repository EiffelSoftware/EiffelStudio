indexing

	description: 
		"Undoable command which change multiplicity.";
	date: "$Date$";
	revision: "$Revision $"

class CHANGE_MULTIPLICITY_U

inherit

	UNDOABLE_EFC

creation

	make

feature -- Initialization

	make (figure : like relation; a_value : like new_value; reverse_capability : BOOLEAN) is
			-- Change the multiplicity of relation
		require
			has_relation : figure /= Void
		do
			set_watch_cursor;
			relation := figure;
			new_value := a_value;
			old_value := figure.multiplicity;
			reverse := reverse_capability;
			record;
			redo;
			restore_cursor;
		ensure
			relation_correctly_set : relation = figure;
			new_value_correctly_set : new_value = a_value;
			reverse_correctly_set : reverse = reverse_capability
		end -- make

feature -- Property

	name: STRING is
		do
			if reverse then
				Result := "Change reverse multiplicity"
			else
				Result := "Change multiplicity"
			end
		end -- name

feature -- Update

	redo is
			-- Re-execute command (after it was undone)
		do
			relation.set_multiplicity (new_value, reverse);
			update
		end; -- redo

	undo is
			-- Cancel effect of executing the command.
		do
			relation.set_multiplicity (old_value, reverse);
			update
		end -- undo

feature {NONE} -- Update

	update is
			-- Update workareas according to the change
		local
			relation_window : EC_RELATION_WINDOW
		do
--			workareas.change_multiplicity (relation, reverse);
--			relation_window := windows.relation_window (relation);
--			if relation_window /= Void then
--				relation_window.update_multiplicity (reverse)
--			end;
--			System.set_is_modified
		end -- update

feature {NONE} -- Private datas

	relation: CLI_SUP_DATA;
			-- Multiple relation

	new_value: INTEGER;
			-- New multiplicity

	old_value: like new_value;
			-- Relation's old multiplicity

	reverse: BOOLEAN

invariant

	has_relation : relation /= Void

end -- class CHANGE_MULTIPLICITY_U
