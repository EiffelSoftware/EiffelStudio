indexing
	description: "EiffelVision EV_ARGUMENT2. To be used when passing two arguments to a command.";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class 
	EV_ARGUMENT2 [G, H]
	
inherit
	EV_ARGUMENT1 [G]

creation 
	make_2
	
feature -- Initialization
	
	make_2 (first_argument: G; second_argument: H) is
		do
			make (first_argument)
			second := second_argument
		end
	
feature -- Access
	
	second: H
	
	
end -- class EV_ARGUMENTS
