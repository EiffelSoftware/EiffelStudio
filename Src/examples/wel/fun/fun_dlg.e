class
	FUN_DIALOG

inherit
	WEL_MODAL_DIALOG
		redefine
			on_ok,
			setup_dialog,
			on_mouse_move
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Make a funny dialog
		do
			make_by_id (a_parent, Id_dialog)
			create ok_button.make_by_id (Current, Idok)
			direction_x := Inc_x
			direction_y := Inc_y
		end

	setup_dialog is
		do
			set_cursor_position_absolute (window_rect.x + ok_button.x -
				sensibility, window_rect.y + ok_button.y)
		end

feature

	movement_x (x_pos, xb: INTEGER): BOOLEAN is
			-- Do we still need to move the button
			-- on the horizontal axis?
		local
			temp: INTEGER
		do
			temp := x_pos - xb
			if temp < ok_button.width + Sensibility
				 and then temp > -Sensibility then
				Result := True
			end
		end

	movement_y (y_pos, yb: INTEGER): BOOLEAN is
			-- Do we still need to move the button
			-- on the vertical axis?
		local
			temp: INTEGER
		do
			temp := y_pos - yb
			if temp < ok_button.height + Sensibility
				and then temp > -Sensibility then
				Result := True
			end
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- The mouse has been moved
		local
			xb, yb, x_max, y_max: INTEGER
		do
			if not time_elapsed then
				xb := ok_button.x
				yb := ok_button.y
				x_max := width - ok_button.width - Sensibility
				y_max := height - ok_button.height - Sensibility - 10
				if movement_x (x_pos, xb) then
					from
					until
						not movement_x (x_pos, xb)
					loop
						xb := xb + direction_x
						if (xb < X_min) or (xb > x_max) then
							direction_x := - direction_x
						end
					end
					ok_button.move (xb, yb)
				end

				if movement_y (y_pos, yb) then
					from
					until
						not movement_y (y_pos, yb)
					loop
						yb := yb + direction_y
						if (yb < Y_min) or (yb > y_max) then
							direction_y := - direction_y
						end
					end
					ok_button.move (xb, yb)
				end
				move_number := move_number + 1
				if move_number > Max_move then
					time_elapsed := True
				end
			end
		end

	on_ok is
			-- The ok button is pressed
		local
			msg_box: WEL_MSG_BOX
		do
			create msg_box.make
			msg_box.information_message_box (Current, 
				"Thank you for your participation...", "ISE Example")
			terminate (Idok)
		end

feature -- Access

	time_elapsed: BOOLEAN
			-- Does the button must still move?

	move_number: INTEGER
			-- How many movements until we quit

	Max_move: INTEGER is 200
			-- Maximum moves before leaving

	Sensibility: INTEGER is 20
			-- Minimal distance from the mouse accepted
			-- before moving the button

	X_min: INTEGER is 5
			-- Minimum x coordinate for the button

	Y_min: INTEGER is 130
			-- Minimum y coordinate for the button

	Inc_x: INTEGER is 3
			-- Step of deplacement for the button on horizontal axis

	Inc_y: INTEGER is 3
			-- Step of deplacement for the button on vertical axis

	direction_x: INTEGER
			-- The step button direction when it goes right or left

	direction_y: INTEGER
			-- The step button direction when it goes up or down

	ok_button: WEL_PUSH_BUTTON

end -- class FUN_DIALOG

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

