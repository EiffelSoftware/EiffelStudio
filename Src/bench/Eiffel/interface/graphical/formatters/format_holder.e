indexing 

	description:
		"Class to hold a formatter plus its associated visual representations.";
	date: "$Date$";
	revision: "$Revision$"

class FORMAT_HOLDER

inherit
	HOLDER
		redefine
			associated_command
		end;

creation
	make

feature -- Properties

	associated_command: FORMATTER
			-- Command to execute.

end -- class FORMAT_HOLDER
