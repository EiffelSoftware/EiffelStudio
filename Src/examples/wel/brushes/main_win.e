class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_icon,
			on_paint,
			on_control_command
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

	make is
		do
			make_top (Title)
			resize (300, 255)
			!! brush_button.make (Current, "Brushes",
				10, 30, 90, 35, -1)
			!! rectangle_button.make (Current, "Rectangles",
				10, 70, 90, 35, -1)
			!! demo3d_button.make (Current, "3D",
				10, 110, 90, 35, -1)
		end

feature -- Access

	brush_demo: BRUSH_DEMO

	rectangle_demo: RECTANGLE_DEMO

	three_d_demo: DEMO_3D

	brush_button: WEL_PUSH_BUTTON

	rectangle_button: WEL_PUSH_BUTTON

	demo3d_button: WEL_PUSH_BUTTON

feature {NONE} -- Implementation

	on_control_command (control: WEL_CONTROL) is
		do
			if control = brush_button then
				!! brush_demo.make
			elseif control = rectangle_button then
				!! rectangle_demo.make
			elseif control = demo3d_button then
				if is_win32 then
					!! three_d_demo.make
				else
					warning_message_box ("Sorry, 3D demonstration %
						%is not available under%NWindows 3.1 for %
						%DC limitation problems.%NRetry under %
						%Windows 95/NT.", "3D")
				end
			end
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Draw the ISE logo bitmap
		do
			paint_dc.draw_bitmap (ise_logo, 158, 10, 
				ise_logo.width, ise_logo.height)
		end

	class_icon: WEL_ICON is
			-- Window's icon
		once
			!! Result.make_by_id (Id_ico_application)
		end

	ise_logo: WEL_BITMAP is
			-- ISE logo bitmap
		once
			!! Result.make_by_id (Id_bmp_ise_logo)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING is "WEL GDI demo"
			-- Window's title

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
