indexing
	description: "EiffelVision EV_ARGUMENTS. To be used when passing three arguments to a command.";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class 
	EV_ARGUMENT3 [G, H, I]
	
inherit
	EV_ARGUMENT2 [G, H]

creation 
	make_3
	
feature -- Initialization
	
	make_3 (first_argument: G; second_argument: H; third_argument: I) is
		do
			make_2 (first_argument, second_argument)
			third := third_argument
		end
	
feature -- Access
	
	third: I
	
	
end -- class EV_ARGUMENTS
