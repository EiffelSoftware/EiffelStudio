indexing 

	description:
		"Class to hold a hole plus its associated visual representations.";
	date: "$Date$";
	revision: "$Revision$"

class HOLE_HOLDER

inherit
	EB_HOLDER
		redefine
			associated_command, associated_button,
			set_selected
		end;

creation
	make, make_plain

feature -- Properties

	associated_command: HOLE_COMMAND
			-- Command to execute.

	associated_button: EB_BUTTON_HOLE
			-- Button for on the toolbars.

feature -- Status setting

	set_selected (selection: BOOLEAN) is
			-- Set both the `associated_button' and `associated_menu_entry'
			-- to be selected or not, according `selection'.
		do
			if associated_button /= Void then
				associated_button.set_selected (selection)
			end;
		end;

end -- class HOLE_HOLDER
