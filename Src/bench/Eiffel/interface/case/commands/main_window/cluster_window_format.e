indexing

	description: 
		"Abstract class for commands that represent %
		%cluster window formats.";
	date: "$Date$";
	revision: "$Revision $"

deferred class 
	CLUSTER_WINDOW_FORMAT

inherit
	EDITOR_WINDOW_FORMAT
		rename
			editor_window as cluster_window
		redefine
			cluster_window
		end

feature -- Properties

	cluster_window: MAIN_WINDOW;

end -- class CLUSTER_WINDOW_FORMAT



