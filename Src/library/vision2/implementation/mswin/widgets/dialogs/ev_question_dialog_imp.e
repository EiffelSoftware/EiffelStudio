indexing
	description: "EiffelVision question dialog. Mswindows implemenation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_QUESTION_DIALOG_IMP

inherit
	EV_QUESTION_DIALOG_I

	EV_MESSAGE_DIALOG_IMP
		redefine
			make, 
			make_default,
			make_with_text
		end

creation
	make,
	make_default,
	make_with_text

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a message dialog with `par' as parent.
		do
			{EV_MESSAGE_DIALOG_IMP} Precursor (par)
			dialog_style := Mb_iconquestion
		end

	make_with_text (par: EV_CONTAINER; a_title, a_msg: STRING) is
			-- Create a message box with `par' as parent, `a_title' as
			-- title and `a_msg' as message.
		do
			{EV_MESSAGE_DIALOG_IMP} Precursor (par, a_title, a_msg)
			dialog_style := Mb_iconquestion
		end

	make_default (par: EV_CONTAINER; a_title, a_msg: STRING) is
			-- Create the default message dialog with `par' as
			-- parent, `a_title' as title and `a_msg' as message
			-- and displays it.
		do
			{EV_MESSAGE_DIALOG_IMP} Precursor (par, a_title, a_msg)
			dialog_style := Mb_iconquestion + Mb_yesno
			show
		end

end -- class EV_QUESTION_DIALOG_IMP

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
