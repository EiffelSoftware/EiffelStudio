indexing
	description: "Command that super melts a class or a routine and add a breakpoint at%
			%the first instruction oc each routine.";
	date: "$Date$";
	revision: "$Revision$"

class
	BREAKPOINT_INSERTER

inherit
	SUPER_MELT
		redefine
			insert_breakpoint
		end

creation
	make, do_nothing

feature

	insert_breakpoint: BOOLEAN is True
			-- To force a breakpoint at the first line.

end -- class BREAKPOINT_INSERTER
