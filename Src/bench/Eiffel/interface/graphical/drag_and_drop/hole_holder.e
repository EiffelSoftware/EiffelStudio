indexing 

	description:
		"Class to hold a hole plus its associated visual representations.";
	date: "$Date$";
	revision: "$Revision$"

class HOLE_HOLDER

inherit
	TWO_STATE_CMD_HOLDER
		redefine
			associated_button,
			associated_command
		end;

create
	make, make_plain

feature -- Properties

	associated_command: HOLE_COMMAND
			-- Command to execute.

	associated_button: EB_BUTTON_HOLE
			-- Button for on the toolbars.

end -- class HOLE_HOLDER
