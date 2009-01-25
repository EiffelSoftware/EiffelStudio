note
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW)
			-- Make a funny dialog
		do
			make_by_id (a_parent, Id_dialog)
			create internal_ok_button.make_by_id (Current, Idok)
			direction_x := Inc_x
			direction_y := Inc_y
		end

	setup_dialog
		do
			set_cursor_position_absolute (window_rect.x + ok_button.x -
				sensibility, window_rect.y + ok_button.y)
		end

feature

	movement_x (x_pos, xb: INTEGER): BOOLEAN
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

	movement_y (y_pos, yb: INTEGER): BOOLEAN
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

	on_mouse_move (keys, x_pos, y_pos: INTEGER)
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

	on_ok
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

	Max_move: INTEGER = 200
			-- Maximum moves before leaving

	Sensibility: INTEGER = 20
			-- Minimal distance from the mouse accepted
			-- before moving the button

	X_min: INTEGER = 5
			-- Minimum x coordinate for the button

	Y_min: INTEGER = 130
			-- Minimum y coordinate for the button

	Inc_x: INTEGER = 3
			-- Step of deplacement for the button on horizontal axis

	Inc_y: INTEGER = 3
			-- Step of deplacement for the button on vertical axis

	direction_x: INTEGER
			-- The step button direction when it goes right or left

	direction_y: INTEGER
			-- The step button direction when it goes up or down

	ok_button: WEL_PUSH_BUTTON
		local
			l_ok_button: like internal_ok_button
		do
			l_ok_button := internal_ok_button
				-- Per invariant
			check l_ok_button_attached: l_ok_button /= Void end
			Result := l_ok_button
		end

feature {NONE} -- Access

	internal_ok_button: ?like ok_button
			-- Storage

invariant
	internal_ok_button_attached: internal_ok_button /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class FUN_DIALOG

