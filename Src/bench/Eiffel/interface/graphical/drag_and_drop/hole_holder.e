indexing 

	description:
		"Class to hold a hole plus its associated visual representations.";
	date: "$Date$";
	revision: "$Revision$"

class HOLE_HOLDER

inherit
	HOLDER
		redefine
			associated_command, associated_button
		end;

creation
	make

feature -- Properties

	associated_command: HOLE_COMMAND
			-- Command to execute.

	associated_button: EB_BUTTON_HOLE
			-- Button for on the toolbars.

end -- class HOLE_HOLDER
