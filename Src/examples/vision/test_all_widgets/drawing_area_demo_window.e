class DRAWING_AREA_DEMO_WINDOW

inherit

	DEMO_WINDOW

create

	make

feature

	main_widget: WIDGET is
		once
			create {DRAWING_AREA} Result.make ("Drawing_area", Current)
		end

	set_widgets is
		local
			da: DRAWING_AREA
			circle1, circle2, circle3, circle4: CIRCLE
			color: COLOR
			interior: INTERIOR
			center: COORD_XY_FIG
		do
			set_size (160, 160)
			main_widget.set_x_y (30, 30)
			da ?= main_widget
			da.set_size (100, 100)
			da.add_expose_action (Current, Void)
		end

	work (arg: INTEGER_REF) is
		local
			draw_a: DRAWING_AREA
			circle1, circle2, circle3, circle4: CIRCLE
			color1, color2, color3, color4: COLOR
			interior1, interior2, interior3, interior4: INTERIOR
			center1, center2, center3, center4: COORD_XY_FIG
		do
			draw_a ?= main_widget
			create circle1.make
			create circle2.make
			create circle3.make
			create circle4.make
			circle1.set_radius (20)
			circle2.set_radius (20)
			circle3.set_radius (20)
			circle4.set_radius (20)
			create center1
			center1.set_x (30)
			center1.set_y (30)
			circle1.set_center (center1)
			create center2
			center2.set_x (30)
			center2.set_y (70)
			circle2.set_center (center2)
			create center3
			center3.set_x (70)
			center3.set_y (30)
			circle3.set_center (center3)
			create center4
			center4.set_x (70)
			center4.set_y (70)
			circle4.set_center (center4)
			create color1.make
			create color2.make
			create color3.make
			create color4.make
			create interior1.make
			create interior2.make
			create interior3.make
			create interior4.make
			interior1.set_solid_fill
			interior2.set_solid_fill
			interior3.set_solid_fill
			interior4.set_solid_fill
			color1.set_name ("red")
			interior1.set_foreground_color (color1)
			circle1.set_interior (interior1)
			color2.set_name ("blue")
			interior2.set_foreground_color (color2)
			circle2.set_interior (interior2)
			color3.set_name ("yellow")
			interior3.set_foreground_color (color3)
			circle3.set_interior (interior3)
			color4.set_name ("green")
			interior4.set_foreground_color (color4)
			circle4.set_interior (interior4)
			circle1.attach_drawing (draw_a)
			circle2.attach_drawing (draw_a)
			circle3.attach_drawing (draw_a)
			circle4.attach_drawing (draw_a)
			circle1.draw
			circle2.draw
			circle3.draw
			circle4.draw
		end

end

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

