indexing

	description: 
		"Root class for eiffelcase using the MOTIF toolkit%
		%and NO license manager.";
	date: "$Date$";
	revision: "$Revision $"

class ECASE_WINDOWS

inherit

	ECASE
		redefine
			init_toolkit
		end

creation 

	make

feature -- Properties

	init_toolkit: MS_WINDOWS is
			-- Initalize the toolkit using MOTIF
		once
			!! Result.make ("")
		end

end -- class ECASE_WINDOWS
