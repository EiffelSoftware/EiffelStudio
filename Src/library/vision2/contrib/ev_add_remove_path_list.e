indexing
	description: "Abstraction of a list in which you can add/modify/remove paths."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ADD_REMOVE_PATH_LIST

inherit
	EV_ADD_REMOVE_LIST
		redefine
			build_text_field
		end
		
create
	make_with_parent

feature {NONE} -- Initialization

	make_with_parent (win: like parent_window) is
			-- Create an Add/Remove list.
		require
			win_not_void: win /= Void
		do
			parent_window := win
			make
		ensure
			parent_window_set: parent_window = win
		end

feature -- Access

	parent_window: EV_WINDOW
			-- Parent window in which browsing dialogs will be modal to.
			
	path_field: EV_PATH_FIELD
			-- Entry where path will be inserted.

feature -- Settings

	set_browse_for_file (filter: STRING) is
			-- Force file browsing dialog to appear when user
			-- click on `browse_button'.
		do
			path_field.set_browse_for_file (filter)
		end

	set_browse_for_directory is
			-- Force directory browsing dialog to appear when user
			-- click on `browse_button'.
		do
			path_field.set_browse_for_directory
		end
			
feature {NONE} -- Implementation

	build_text_field (t: STRING) is
			-- Create a text field which has a browse button attached to it.
		do
			create path_field.make_with_text_and_parent (t, parent_window)
			text_field := path_field.field
			extend (path_field)
			disable_item_expand (path_field)
		end
		
end -- class EV_ADD_REMOVE_PATH_LIST
