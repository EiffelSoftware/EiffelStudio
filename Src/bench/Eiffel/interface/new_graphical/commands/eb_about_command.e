indexing
	description	: "Command to display the about."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_ABOUT_COMMAND 

inherit
	EB_COMMAND

	EB_SHARED_MANAGERS
		export
			{NONE} all
		end

feature -- Execution

	execute is
			-- Popup the help window.
		local
			about_dialog: EB_ABOUT_DIALOG
			parent_window: EB_WINDOW
		do
			create about_dialog.make

			parent_window := window_manager.last_focused_window
			if parent_window /= Void then
				about_dialog.show_modal_to_window (parent_window.window)
			end
		end

end -- class EB_ABOUT_COMMAND
