indexing
	description: "EiffelVision EV_ARGUMENTS, gtk implementation.";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class EV_ARGUMENTS [G, H, I]

creation 
	make
	
feature -- Initialization
	
	make (first_argument: G; second_argument: H; third_argument: I) is
		do
			first := first_argument
			second := second_argument
			third := third_argument
		end
	
feature -- Access
	
	first: G
	second: H
	third: I
	
	
end -- class EV_ARGUMENTS
