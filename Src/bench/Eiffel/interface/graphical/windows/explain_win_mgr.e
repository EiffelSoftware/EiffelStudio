indexing

	description:	
		"Window manager for explanation windows.";
	date: "$Date$";
	revision: "$Revision$"

class EXPLAIN_WIN_MGR 

inherit

	EDITOR_MGR
		redefine
			editor_type
		end

creation

	make

feature {NONE} -- Properties

	editor_type: EXPLAIN_W;
	
end -- class EXPLAIN_WIN_MGR
