indexing

	description: 
		"Error when an attribute name appears more than once %
		%in the attribute name list of a strip expression.";
	date: "$Date$";
	revision: "$Revision $"

class VWST2 

inherit

	VWST1
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 2;

end -- class VWST
