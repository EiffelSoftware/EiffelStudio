indexing

	description: 
		"Error when an non-deferred feature is redefined %
		%into a deferred one. This error is VDRD5 NOT VDRD7 !!!!!";
	date: "$Date$";
	revision: "$Revision $"

class VDRD7 

inherit

	VDRD5
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 5;

end -- class VDRD7
