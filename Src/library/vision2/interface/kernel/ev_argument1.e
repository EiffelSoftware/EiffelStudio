indexing
	description: "EiffelVision EV_ARGUMENT1. To be used when passing one argument to a command.";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class EV_ARGUMENT1 [G]
	
inherit
	EV_ARGUMENTS

creation 
	make
	
feature -- Initialization
	
	make (first_argument: G) is
		do
			first := first_argument
		end
	
feature -- Access
	
	first: G
	
end -- class EV_ARGUMENTS
