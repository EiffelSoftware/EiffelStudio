note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_icon,
			on_paint,
			on_control_command,
			on_timer
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

	make
		do
			make_top (Title)
			resize (300, 255)
			create brush_button.make (Current, "Brushes",
				10, 30, 90, 35, -1)
			create rectangle_button.make (Current, "Rectangles",
				10, 70, 90, 35, -1)
			create demo3d_button.make (Current, "3D",
				10, 110, 90, 35, -1)
				-- Set a timer for the 3d_demo.
				-- `demo_timer_id' is the timer id and 50 is the
				-- interval length in milliseconds.
			set_timer (demo_timer_id, 50)
		end

feature -- Access

	brush_demo: ?BRUSH_DEMO

	rectangle_demo: ?RECTANGLE_DEMO

	three_d_demo: ?DEMO_3D

	brush_button: ?WEL_PUSH_BUTTON

	rectangle_button: ?WEL_PUSH_BUTTON

	demo3d_button: ?WEL_PUSH_BUTTON

feature {NONE} -- Implementation

	on_control_command (control: WEL_CONTROL)
		do
			if control = brush_button then
				create brush_demo.make
			elseif control = rectangle_button then
				create rectangle_demo.make
			elseif control = demo3d_button then
				create three_d_demo.make
			end
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Draw the ISE logo bitmap
		do
			paint_dc.draw_bitmap (ise_logo, 158, 10,
				ise_logo.width, ise_logo.height)
		end

	on_timer (timer_id: INTEGER)
			-- Wm_timer message.
			-- A Wm_timer has been received from `timer_id'
			-- We use this timer to
		do
			if
				timer_id = demo_timer_id and then
				{l_demo: like three_d_demo} three_d_demo and then
				l_demo.exists and then l_demo.ready
			then
				l_demo.go
			end
		end

	class_icon: WEL_ICON
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_application)
		end

	ise_logo: WEL_BITMAP
			-- ISE logo bitmap
		once
			create Result.make_by_id (Id_bmp_ise_logo)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING = "WEL GDI demo"
		-- Window's title

	demo_timer_id: INTEGER = unique;
		-- Unique integer for timer.

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


end -- class MAIN_WINDOW

