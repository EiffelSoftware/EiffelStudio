indexing

	description: 
		"Error when the result type of a feature has not the correct %
		%number of generic parameter.";
	date: "$Date$";
	revision: "$Revision $"

class VTUG1 

inherit

	VTUG
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 1

end -- class VTUG1
