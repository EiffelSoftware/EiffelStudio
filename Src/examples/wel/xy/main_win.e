class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_background,
			on_control_command,
			on_left_button_down
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Make the main window and a button
		do
			make_top ("WEL xy")
			create clear_button.make (Current, "Clear",
				1, 1, 70, 40, 1)
		end

feature {NONE} -- Behaviors

	on_control_command (control: WEL_CONTROL) is
			-- Clear the window
		do
			if control = clear_button then
				invalidate
			end
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Write `x_pos' and `y_pos'
		local
			dc: WEL_CLIENT_DC
			position: STRING
		do
			create position.make (20)
			position.extend ('(')
			position.append_integer (x_pos)
			position.append (", ")
			position.append_integer (y_pos)
			position.extend (')')
			create dc.make (Current)
			dc.get
			dc.text_out (x_pos, y_pos, position)
			dc.release
		end

feature {NONE} -- Implementation

	clear_button: WEL_PUSH_BUTTON
			-- Clear button

	class_background: WEL_WHITE_BRUSH is
			-- White background
		once
			create Result.make
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

