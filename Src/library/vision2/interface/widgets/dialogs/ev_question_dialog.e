indexing
	description: "EiffelVision warning dialog. This dialog%
			% displays a window with a question bitmap,%
			% a text inside and a title."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_QUESTION_DIALOG

inherit
	EV_MESSAGE_DIALOG
		redefine
			implementation
		end

create
	make,
	make_default,
	make_with_text

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a message dialog with `par' as parent.
		do
			!EV_QUESTION_DIALOG_IMP! implementation.make (par)
			implementation.set_interface (Current)
--			implementation.build
		end

	make_with_text (par: EV_CONTAINER; a_title, a_msg: STRING) is
			-- Create a message box with `par' as parent, `a_title' as
			-- title and `a_msg' as message.
		do
			!EV_QUESTION_DIALOG_IMP! implementation.make_with_text (par, a_title, a_msg)
			implementation.set_interface (Current)
--			implementation.build
		end

	make_default (par: EV_CONTAINER; a_title, a_msg: STRING) is
			-- Create the default message dialog with `par' as
			-- parent, `a_title' as title and `a_msg' as message
			-- and displays it.
		do
			!EV_QUESTION_DIALOG_IMP! implementation.make_default (par, a_title, a_msg)
			implementation.set_interface (Current)
--			implementation.build
			implementation.set_default (a_msg, a_title)
		end

feature {NONE} -- Implementation

	implementation: EV_QUESTION_DIALOG_I

end -- class EV_QUESTION_DIALOG

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
