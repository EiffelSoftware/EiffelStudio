indexing 
	description: "EiffelVision file save dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FILE_SAVE_DIALOG_IMP

inherit
	EV_FILE_SAVE_DIALOG_I
	EV_FILE_SELECTION_DIALOG_IMP

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a window with a parent.
		do
		end

feature -- Status report

	selected_filter_name: STRING is
			-- Name of the currently selected filter
		do
		end

feature -- Status setting

	select_filter_by_name (name: STRING) is
			-- Select the filter called `name'.
		do
		end

feature -- Element change

	set_file (name: STRING) is
			-- Make the file named `name' the new selected file.
		do
		end

end -- class EV_FILE_SAVE_DIALOG_IMP

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
