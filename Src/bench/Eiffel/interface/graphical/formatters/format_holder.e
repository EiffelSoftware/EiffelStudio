indexing 

	description:
		"Class to hold a formatter plus its associated visual representations.";
	date: "$Date$";
	revision: "$Revision$"

class FORMAT_HOLDER

inherit
	HOLDER
		redefine
			associated_command, associated_menu_entry,
			set_selected
		end;

creation
	make, make_plain

feature -- Properties

	associated_command: FORMATTER
			-- Command to execute.

	associated_menu_entry: EB_TICKABLE_MENU_ENTRY
			-- Menu entry with a tick.

feature -- Status setting

	set_selected (selection: BOOLEAN) is
			-- Set both the `associated_button' and `associated_menu_entry'
			-- to be selected or not, according `selection'.
		do
			if associated_button /= Void then
				associated_button.set_selected (selection)
			end;
			if associated_menu_entry /= Void then
				associated_menu_entry.set_selected (selection);
			end;
		end;

end -- class FORMAT_HOLDER
