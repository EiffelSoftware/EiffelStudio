indexing

	description: 
		"Abstract class for commands that represent %
		%relation window formats.";
	date: "$Date$";
	revision: "$Revision $"

deferred class 
	RELATION_WINDOW_FORMAT
	
inherit
	EDITOR_WINDOW_FORMAT
		rename
			editor_window as relation_window
		redefine
			relation_window
		end

feature -- Properties

	relation_window: EC_RELATION_WINDOW

end -- class RELATION_WINDOW_FORMAT



