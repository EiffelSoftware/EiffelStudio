indexing 
	description: "EiffelVision file selection dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIRECTORY_DIALOG_IMP

inherit
	EV_DIRECTORY_DIALOG_I

	EV_SELECTION_DIALOG_IMP

	WEL_CHOOSE_FOLDER_DIALOG
		rename
			make as wel_make,
			set_parent as wel_set_parent
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make_with_text (par: EV_CONTAINER; txt: STRING) is
			-- Create a directory selection dialog with `txt' as
			-- title.
		do
			wel_make
			parent_imp ?= par.implementation
			set_title (txt)
		end

feature -- Status report

	directory: STRING is
			-- Path of the current selected file
		do
			Result := folder_name
		end

feature -- Element change

	set_base_directory (path: STRING) is
			-- Make `path' the base directory in detrmining files
			-- to be displayed.
		do
			check
				not_yet_implemented: False
			end
		end

feature {NONE} -- Implementation for events handling

	dispatch_events is
			-- Execute the command associated to the action of the user.
			-- As in `process_message' of WEL_WINDOW, we can't use
			-- `inspect' here.
		do
			if selected then
				execute_command (Cmd_ok, Void)
			else
				execute_command (Cmd_cancel, Void)
			end
		end

end -- class EV_DIRECTORY_DIALOG_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
