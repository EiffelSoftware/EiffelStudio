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
		local
			msg_box: WEL_MSG_BOX
		do
			create msg_box.make
			msg_box.information_message_box (Current, "You have pressed the left %
				%mouse button.", "Message received")
		end

	closeable: BOOLEAN is
			-- Does the user want to quit?
		local
			msg_box: WEL_MSG_BOX
		do
			create msg_box.make
			msg_box.question_message_box (Current, "Do you want to quit?",
				"Quit")
			Result := msg_box.message_box_result = Idyes
		end

end -- class MAIN_WINDOW

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

