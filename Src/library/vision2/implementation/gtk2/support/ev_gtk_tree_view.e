indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GTK_TREE_VIEW

feature
	
	on_tree_path_toggle (a_tree_path_str: POINTER) is
			-- A tree path has been checked or unchecked
		deferred
		end

	is_destroyed: BOOLEAN is
			-- Is `Current' destroyed?
		deferred
		end

end -- class EV_GTK_TREE_VIEW
