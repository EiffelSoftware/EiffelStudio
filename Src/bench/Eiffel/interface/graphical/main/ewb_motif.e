indexing

	description: 
		"Root cluster for eiffelbench under motif.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_MOTIF

inherit
	EWB_UNIX
		redefine
			init_toolkit
		end

creation
	make

feature {NONE}

	init_toolkit: MOTIF is once !!Result.make ("ebench") end;

end -- class EWB_MOTIF
