class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_left_button_down,
			on_right_button_down,
			closeable
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Make the main window.
		do
			make_top ("My application")
			!! dc.make (Current)
		end

feature -- Access

	dc: WEL_CLIENT_DC
			-- Device context associated to the current
			-- client window

feature {NONE} -- Implementation

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Write `x_pos' and `y_pos' when the user presses
			-- the left mouse button.
		local
			position: STRING
		do
			position := "("
			position.append_integer (x_pos)
			position.append (", ")
			position.append_integer (y_pos)
			position.extend (')')
			dc.get
			dc.text_out (x_pos, y_pos, position)
			dc.release
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Invalidate window.
		do
			invalidate
		end

	closeable: BOOLEAN is
			-- Does the user want to quit?
		local
			msg_box: WEL_MSG_BOX
		do
			!!msg_box.make
			msg_box.question_message_box (Current, "Do you want to quit?",
				"Quit")
			Result := msg_box.message_box_result = Idyes
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
