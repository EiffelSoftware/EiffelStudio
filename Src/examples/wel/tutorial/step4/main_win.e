class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_left_button_down,
			on_left_button_up,
			on_right_button_down,
			on_mouse_move,
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

	button_down: BOOLEAN
			-- Is the left mouse button down?

feature {NONE} -- Implementation

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Initiate the drawing process.
		do
			if not button_down then
				button_down := True
				dc.get
				dc.move_to (x_pos, y_pos)
			end
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Connect the points to make lines.
		do
			if button_down then
				dc.line_to (x_pos, y_pos)
			end
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Terminate the drawing process.
		do
			if button_down then
				button_down := False
				dc.release
			end
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
