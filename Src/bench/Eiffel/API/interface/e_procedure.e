indexing

	description: 
		"Representation of an eiffel procedure.";
	date: "$Date$";
	revision: "$Revision $"

class E_PROCEDURE

inherit

	E_ROUTINE
		redefine
			is_procedure
		end

create

	make

feature -- Properties

	is_procedure: BOOLEAN is True;

end -- class E_PROCEDURE
