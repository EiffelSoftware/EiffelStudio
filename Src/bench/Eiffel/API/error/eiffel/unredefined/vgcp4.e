indexing

	description: 
		"Error when an expanded class has a creation clause %
		%of several features or a feature with arguments.";
	date: "$Date$";
	revision: "$Revision $"

class VGCP4 

inherit

	VGCP21
		redefine
			subcode, build_explain
		end;

feature -- Properties

	subcode: INTEGER is 4;
	
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Nothing to be done.
		do
		end

end -- class VGCP4
