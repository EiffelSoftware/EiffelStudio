indexing

	description: 
		"Root class for eiffelcase using the MOTIF toolkit%
		%and NO license manager.";
	date: "$Date$";
	revision: "$Revision $"

class ECASE_BASIC_MOTIF

inherit

	ECASE
		rename	
			make as old_make
		redefine
			init_toolkit
		end

creation 

	make

feature -- Initialization

	make is
		do
			old_make
			after_present
		end
	

feature -- Properties

	X_resources_file_name: STRING is "ecase";
			-- X resources file name for EiffelCase
			--| Name of resource file name where the user
			--| can specify additional resources for EiffelCase.

	init_toolkit: ECASE_TOOLKIT_IMP is
			-- Initalize the toolkit using MOTIF
			--| Obsolete since was using Vision 1
		once
			!! Result.make (X_resources_file_name)
		end

end -- class ECASE_BASIC_MOTIF
