indexing

	description: 
		"Abstract class for updating multiplity for a link.";
	date: "$Date$";
	revision: "$Revision $"

deferred class MULTIPLICITY_U 

inherit

	UNDOABLE_EFC

feature -- Update

	multiplie is
			-- Add multiplicity specification to 'link'
		do
			link.add_multiplicity (reverse);
			workareas.add_multiplicity (link, reverse)
		end; -- multiplie

	unmultiplie is
			-- Remove multiplicity specification of 'link'
		do
			link.remove_multiplicity (reverse);
			workareas.remove_multiplicity (link, reverse)
		end; -- unmultiplie

	update is
			-- Update the relation window corresponding to 'link'
		local
			relation_window : EC_RELATION_WINDOW
		do
--			relation_window := windows.relation_window (link);
--			if relation_window /= Void then
--				relation_window.update_multiplicity (reverse)
--			end;
--			workareas.refresh;
--			System.set_is_modified
		end -- update

feature {NONE} -- Implementation properties

	link: CLI_SUP_DATA;
			-- Link which became multiplie or unmultiplie

	reverse: BOOLEAN

end -- class MULTIPLICITY_U
