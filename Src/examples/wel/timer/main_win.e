class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			on_size,
			on_paint,
			on_timer,
			on_control_command,
			class_icon
		end

	WEL_STANDARD_COLORS
		export
			{NONE} all
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_HS_CONSTANTS
		export
			{NONE} all
		end

	WEL_ROP2_CONSTANTS
		export
			{NONE} all
		end

	WEL_SIZE_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is 
		local
			button: WEL_PUSH_BUTTON
			rect: WEL_RECT
			i: INTEGER
		do
			make_top (Title)
			from 
				create buttons.make (1, 4)
				create flash_rects.make (1, 4)
				i := buttons.lower
			until 
				i > buttons.upper
			loop 
				create button.make (Current, Start_timer, 0, 0, 0, 0, i)
				buttons.put (button, i)
				create rect.make (0, 0, 0, 0)
				flash_rects.put (rect, i)
				i := i + 1
			end
			create dc.make (Current)
			create blue_brush.make_hatch (Hs_horizontal, Blue)
			create green_brush.make_hatch (Hs_vertical, Green)
			create yellow_brush.make_hatch (Hs_fdiagonal, Yellow)
			create red_brush.make_hatch (Hs_bdiagonal, Red)
		end

feature -- Access

	buttons: ARRAY [WEL_PUSH_BUTTON]

	flash_rects: ARRAY [WEL_RECT]

	dc: WEL_CLIENT_DC

	blue_brush, green_brush, yellow_brush, red_brush: WEL_BRUSH

feature

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Resize buttons and rectangles.
		do
			if size_type /= Size_minimized then
				set_buttons_positions (a_width, a_height)
				set_flash_rect_positions (a_width, a_height)
			end
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Paint window.
		local
			rect: WEL_RECT
		do
			-- Draw crossing lines
			rect := client_rect
			paint_dc.move_to (rect.right // 2, 0)
			paint_dc.line_to (rect.right // 2, rect.bottom)
			paint_dc.move_to (0,rect.bottom // 2)
			paint_dc.line_to (rect.right, rect.bottom // 2)

			-- Draw "Timer #" headers
			paint_dc.text_out (Button_border,
				Text_height, "Timer 1")
			paint_dc.text_out (rect.right // 2 + Button_border,
				Text_height, "Timer 2")
			paint_dc.text_out (Button_border,
				rect.bottom //2 + Text_height, "Timer 3")
			paint_dc.text_out (rect.right // 2 + Button_border,
				rect.bottom // 2 + Text_height, "Timer 4")

			-- Draw rectangles
			paint_dc.select_brush (blue_brush)
			paint_dc.rectangle (flash_rects.item (1).left,
				flash_rects.item (1).top,
				flash_rects.item (1).right,
				flash_rects.item (1).bottom)
			paint_dc.select_brush (green_brush)
			paint_dc.rectangle (flash_rects.item (2).left,
				flash_rects.item (2).top,
				flash_rects.item (2).right,
				flash_rects.item (2).bottom)
			paint_dc.select_brush (yellow_brush)
			paint_dc.rectangle (flash_rects.item (3).left,
				flash_rects.item (3).top,
				flash_rects.item (3).right,
				flash_rects.item (3).bottom)
			paint_dc.select_brush (red_brush)
			paint_dc.rectangle (flash_rects.item (4).left,
				flash_rects.item (4).top,
				flash_rects.item (4).right,
				flash_rects.item (4).bottom)
		end

	on_timer (timer_id: INTEGER) is
			-- Flash rectangle corresponding to `timer_id'.
		require else
			valid_timer: timer_id >= Timer1 and timer_id <= Timer4
		do
			dc.get
			dc.set_rop2 (R2_not)
			dc.rectangle (flash_rects.item (timer_id).left,
				flash_rects.item (timer_id).top,
				flash_rects.item (timer_id).right,
				flash_rects.item (timer_id).bottom)
			dc.release
		end

	on_control_command (a_control: WEL_CONTROL) is
			-- Start or stop a timer.
		do
			if a_control.text.is_equal (Start_timer) then
				a_control.set_text (Stop_timer)
				set_timer (a_control.id, Timer_interval * a_control.id)
			else
				a_control.set_text (Start_timer)
				kill_timer (a_control.id)
			end
		end

	set_buttons_positions (new_x, new_y: INTEGER) is
			-- Resize buttons.
		require
			buttons_exist: buttons/= Void
			positives: new_x >= 0 and new_y >= 0
		local
			button: WEL_PUSH_BUTTON
		do
			-- Upper left button
			button := buttons.item (1)
			button.set_x (Button_border)
			button.set_y (new_y // 2 - Button_border - Button_height)
			button.set_width (new_x // 2 - 2 * Button_border)
			button.set_height (Button_height)

			-- Upper right button
			button := buttons.item (2)
			button.set_x (new_x // 2 + Button_border)
			button.set_y (new_y // 2 - Button_border - Button_height)
			button.set_width (new_x // 2 - 2 * Button_border)
			button.set_height (Button_height)

			-- Lower left button
			button := buttons.item (3)
			button.set_x (Button_border)
			button.set_y (new_y - Button_border - Button_height)
			button.set_width (new_x // 2 - 2 * Button_border)
			button.set_height (Button_height)

			-- Lower right button
			button := buttons.item (4)
			button.set_x (new_x // 2 + Button_border)
			button.set_y (new_y - Button_border - Button_height)
			button.set_width (new_x // 2 - 2 * Button_border)
			button.set_height (Button_height)
		end

	set_flash_rect_positions (new_x, new_y: INTEGER) is
			-- Resize rectangles.
		do
			flash_rects.item (1).set_rect (Button_border,
				3 * Text_height + Button_border,
				new_x // 2 - Button_border,
				new_y // 2 - Button_height - 2 * Button_border)
			flash_rects.item (2).set_rect (new_x // 2 + Button_border,
				3 * Text_height + Button_border,
				new_x - Button_border,
				new_y // 2 - Button_height - 2 * Button_border)
			flash_rects.item (3).set_rect (Button_border,
				new_y // 2 + 3 * Text_height + Button_border,
				new_x // 2 - Button_border,
				new_y - Button_height - 2 * Button_border)
			flash_rects.item (4).set_rect (new_x // 2 + Button_border,
				new_y // 2 + 3 * Text_height + Button_border,
				new_x - Button_border,
				new_y - Button_height - 2 * Button_border)
		end

	class_icon: WEL_ICON is
			-- Window's title
		once
			create Result.make_by_id (Id_ico_application)
		end

	Timer1: INTEGER is 1
	Timer2: INTEGER is 2
	Timer3: INTEGER is 3
	Timer4: INTEGER is 4

	Button_border: INTEGER is 5
	Button_height: INTEGER is 25
	Text_height: INTEGER is 8

	Timer_interval: INTEGER is 400

	Start_timer: STRING is "Start Timer"
			-- Push button text to start the timer

	Stop_timer: STRING is "Stop Timer"
			-- Push button text to stop the timer

	Title: STRING is "WEL Timer"
			-- Window's title

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

