indexing

	description:	
		"Window manager for explanation windows.";
	date: "$Date$";
	revision: "$Revision$"

class EXPLAIN_WIN_MGR 

inherit

	EDITOR_MGR
		rename
			make as mgr_make
		redefine
			editor_type
		end;
	EDITOR_MGR
		redefine
			editor_type, make
		select
			make
		end;
	EB_CONSTANTS

creation

	make

feature -- Initialization

	make (a_screen: SCREEN) is
		 	-- Initialize Current.
		do
			mgr_make (a_screen);
			Explain_resources.add_user (Current)
		end

feature {NONE} -- Properties

	editor_type: EXPLAIN_W;
	
end -- class EXPLAIN_WIN_MGR
