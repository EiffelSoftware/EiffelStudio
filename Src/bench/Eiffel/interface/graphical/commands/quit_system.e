indexing

	description:	
		"Command to quit the system tool.";
	date: "$Date$";
	revision: "$Revision$"

class QUIT_SYSTEM 

inherit
	QUIT_FILE
		redefine 
			loose_changes
		end

creation
	make
	
feature -- Callbacks

	loose_changes is
			-- The user has been warned that he will lose his stuff
		do
			text_window.clear_window;
			tool.hide;
		end;

end -- class QUIT_SYSTEM
