indexing
	description: 
		"Abstract class for undoable command that moves a label.";
	date: "$Date$";
	revision: "$Revision $"

deferred class LABEL_MOVING_U

inherit

	UNDOABLE_EFC

feature -- Setting

	undo is
		do
			redo
		end 

feature -- Properties

	label_hidden: BOOLEAN is
			-- Are labels currently hidden ?
		do
			Result := system.is_label_hidden
		end

feature {NONE} -- Updating

	update is
			-- Update the relation window corresponding to 'link'.
		local 
			relation_window: EC_RELATION_WINDOW 
		do
--			relation_window := windows.relation_window (link); 
--			if relation_window /= Void then
--				relation_window.update_label_position
--			end;
--
--			workareas.change_label_position (link, reverse);
--			workareas.refresh;
--			System.set_is_modified
		end -- update

feature {NONE} -- Implementation properties

	link: CLI_SUP_DATA;
			-- Link whose label moves

	left_side: BOOLEAN;
			-- Is the label moving on the left side of 'link' ?

	reverse: BOOLEAN
			-- Is the label on the reverse link?

end -- class MOVE_LABEL_U

