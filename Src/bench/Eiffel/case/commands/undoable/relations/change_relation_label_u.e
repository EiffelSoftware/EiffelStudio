indexing

	description: 
		"Undoable command that changes the relation label.";
	date: "$Date$";
	revision: "$Revision $"

class CHANGE_RELATION_LABEL_U 

inherit

	UNDOABLE_EFC

creation

	make

feature -- Initialization

	make (figure: like relation; to: like new_label; reverse_capability : BOOLEAN) is
			-- Change the name of a partition
		require
			has_relation: figure /= void;
			has_new_label: to /= void
		local
			l: LABEL_DATA
		do
			set_watch_cursor;
			relation := figure;
				-- Need to parse it to make it legal
			!! l.make (0)
			l.update_from (to.text)
			l.parse
			new_label := l
			reverse := reverse_capability
			if reverse then
				old_label := clone (figure.reverse_label)
			else
				old_label := clone (figure.label)
			end
			record
			redo
			restore_cursor
		ensure
			relation_correctly_set: relation = figure;
			new_label_correctly_set: new_label.is_equal (to)
			reverse_correcly_set : reverse = reverse_capability
		end

feature -- Property

	name: STRING is 
		do
			if reverse then
				Result := "Change reverse relation label"
			else
				Result := "Change relation label"
			end
		end -- name

feature -- Update

	redo is
			-- Re-execute command (after it was undone)
		do
			if reverse then
				relation.set_reverse_label(clone(new_label.text)) -- (clone (new_label))
			else
				relation.set_label(clone(new_label.text)) -- (clone (new_label))
			end
			update
		end -- redo

	undo is
			-- Cancel effect of executing the command
		do
			if reverse then
				relation.set_reverse_label (clone(old_label.text)) --(clone (old_label))
			else
				relation.set_label (clone(old_label.text)) --(clone (old_label))
			end
			update
		end -- undo

feature {NONE} -- Implementation

	update is
			--
		local
			relation_window: EC_RELATION_WINDOW
		do
--			workareas.change_label (relation, reverse);
--			workareas.refresh;
--			relation_window := windows.relation_window (relation);
--			if relation_window /= Void then
--				relation_window.update_label
--			end;
--			System.set_is_modified
		end

feature {NONE} -- Implementation Properties

	relation: CLI_SUP_DATA;
			-- Relation modified created

	new_label: LABEL_DATA -- STRING
			-- New label given to the relation

	old_label: like new_label
			-- Relation's old label

	reverse: BOOLEAN

invariant

	has_relation: relation /= void;
	has_new_label: new_label /= void;
	has_old_label: old_label /= void

end -- class CHANGE_RELATION_LABEL_U
