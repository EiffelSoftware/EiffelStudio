indexing 

	description:
		"Class to hold a command plus its associated visual representations.";
	date: "$Date$";
	revision: "$Revision$"

class COMMAND_HOLDER

inherit
	EB_HOLDER
		redefine
			set_selected
		end

creation
	make, make_plain

feature -- Status setting

	set_selected (selection: BOOLEAN) is
			-- Set both the `associated_button' and `associated_menu_entry'
			-- to be selected or not, according `selection'.
		do
			if associated_button /= Void then
				associated_button.set_selected (selection)
			end;
		end;

end -- class COMMAND_HOLDER
