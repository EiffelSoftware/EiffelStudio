indexing

	description: 
		"Error when an old expression is found somewhere else %
		%that in a postcondition";
	date: "$Date$";
	revision: "$Revision $"

class VAOL1 

inherit

	FEATURE_ERROR
		redefine
			subcode
		end;

feature -- Properties

	code: STRING is "VAOL";
			-- Error code

	subcode: INTEGER is
		do
			Result := 1
		end;

end -- class VAOL1
