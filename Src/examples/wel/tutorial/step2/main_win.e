class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_left_button_down,
			closeable
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Make the main window.
		do
			make_top ("My application")
		end

feature {NONE} -- Implementation

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Display a message box when the user presses the
			-- the left mouse button.
		do
			information_message_box ("You have pressed the left %
				%mouse button.", "Message received")
		end

	closeable: BOOLEAN is
			-- Does the user want to quit?
		do
			Result := question_message_box ("Do you want to quit?",
				"Quit")
		end

end -- class MAIN_WINDOW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
