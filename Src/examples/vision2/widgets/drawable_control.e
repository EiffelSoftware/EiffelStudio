indexing
	description: "Controls used to modify objects of type EV_DRAWABLE"
	date: "$Date$"
	revision: "$Revision$"

class
	DRAWABLE_CONTROL


inherit
	EV_FRAME

create
	make

feature {NONE}-- Initialization

	make (box: EV_BOX; a_drawable: EV_DRAWABLE; output: EV_TEXT) is
			-- Create controls to manipulate `a_drawable', parented in `box' and
			-- displaying output in `output'.
		do
			create pixmap
			pixmap.set_with_named_file ("icon_wizard_blank_project.png")
			drawable := a_drawable
			default_create
			xvel := 7
			yvel := 13
			set_text ("EV_DRAWABLE")
			create vertical_box
			extend (vertical_box)
			create button.make_with_text ("Clear")
			button.select_actions.extend (agent drawable.clear)
			vertical_box.extend (button)
			create button.make_with_text ("Draw_point")
			button.select_actions.extend (agent draw_point)
			vertical_box.extend (button)
			create button.make_with_text ("Draw text")
			button.select_actions.extend (agent draw_text)
			vertical_box.extend (button)
			create button.make_with_text ("Draw_segment")
			button.select_actions.extend (agent draw_segment)
			vertical_box.extend (button)
			create button.make_with_text ("Draw_straight_line")
			button.select_actions.extend (agent draw_straight_line)
			vertical_box.extend (button)
			create button.make_with_text ("Draw_pixmap")
			button.select_actions.extend (agent draw_pixmap)
			vertical_box.extend (button)
			create button.make_with_text ("Draw_arc")
			button.select_actions.extend (agent draw_arc)
			vertical_box.extend (button)
			create button.make_with_text ("Draw rectangle")
			button.select_actions.extend (agent draw_rectangle)
			vertical_box.extend (button)
			create button.make_with_text ("Draw ellipse")
			button.select_actions.extend (agent draw_ellipse)
			vertical_box.extend (button)
			create button.make_with_text ("Draw_polyline")
			button.select_actions.extend (agent draw_polyline)
			vertical_box.extend (button)
			create button.make_with_text ("Draw_pie_slice")
			button.select_actions.extend (agent draw_pie_slice)
			vertical_box.extend (button)
			create button.make_with_text ("Fill rectangle")
			button.select_actions.extend (agent fill_rectangle)
			vertical_box.extend (button)
			create button.make_with_text ("Fill ellipse")
			button.select_actions.extend (agent fill_ellipse)
			vertical_box.extend (button)
			create button.make_with_text ("Fill_polygon")
			button.select_actions.extend (agent fill_polygon)
			vertical_box.extend (button)
			create button.make_with_text ("Fill_pie_slice")
			button.select_actions.extend (agent fill_pie_slice)
			vertical_box.extend (button)
			create button.make_with_text ("Enable_dashed_line_style")
			vertical_box.extend (button)
			button.select_actions.extend (agent toggle_line_style)
			create horizontal_box
			vertical_box.extend (horizontal_box)
			create label.make_with_text ("Line thickness")
			horizontal_box.extend (label)
			create range.make (1, 50)
			create spin.make_with_value_range (range)
			spin.change_actions.extend (agent set_line_width)
			spin.set_value (1)
			horizontal_box.extend (spin)
			box.extend (Current)
		end


feature {NONE} -- Implementation

	draw_text is
			-- Draw a text on `drawable'.
		do
			drawable.draw_text (x_pos, y_pos, "Text")
			move_coordinates
		end
		
	draw_point is
			-- Draw a point on `drawable'.
		do
			drawable.draw_point (x_pos, y_pos)
			move_coordinates
		end
		
	draw_segment is
			-- Draw a segment on `drawable'.
		do
			drawable.draw_segment (x_pos, y_pos, 0, 0)
			move_coordinates
		end
		
	draw_straight_line is
			-- Draw a straight line on `drawable'.
		do
			drawable.draw_straight_line (x_pos, y_pos, 0, 0)
			move_coordinates
		end
		
	draw_pixmap is
			-- Draw a pixmap on `drawable'.
		do
			drawable.draw_pixmap (x_pos, y_pos, pixmap)
			move_coordinates
		end
		
	draw_arc is
			-- Draw an arc on `drawable'.
		do
			drawable.draw_arc (x_pos, y_pos, 100, 100, 0, 4)
			move_coordinates
		end
		
	draw_rectangle is
			-- Draw a rectangle on `drawable'.
		do
			drawable.draw_rectangle (x_pos, y_pos, 80, 80)
			move_coordinates
		end
		
	draw_ellipse is
			-- Draw an ellipse on `drawable'.
		do
			drawable.draw_ellipse (x_pos, y_pos, 80, 50)
			move_coordinates
		end
		
	draw_polyline is
			-- Draw a polyline on `drawable'.
		local
			coor: EV_COORDINATE
			points: ARRAY [EV_COORDINATE]
		do
			create points.make (1, 5)
			create coor.set (10 + x_pos, 15 + y_pos)
			points.force (coor, 1)
			create coor.set (45 + x_pos, 2 + y_pos)
			points.force (coor, 2)
			create coor.set (30 + x_pos, 50 + y_pos)
			points.force (coor, 3)
			create coor.set (20 + x_pos, 25 + y_pos)
			points.force (coor, 4)
			create coor.set (70 + x_pos, 70 + y_pos)
			points.force (coor, 5)
			drawable.draw_polyline (points, True)
			move_coordinates
		end
		
	draw_pie_slice is
			-- Draw a pie slice on `drawable'.
		do
			drawable.draw_pie_slice (x_pos, y_pos, 100, 100, 0, 4)
			move_coordinates
		end	
		
	fill_rectangle is
			-- Fill a rectangle on `drawable'.
		do
			drawable.fill_rectangle (x_pos, y_pos, 80, 80)
			move_coordinates
		end
		
	fill_ellipse is
			-- Fill an ellipse on `drawable'.
		do
			drawable.fill_ellipse (x_pos, y_pos, 80, 50)
			move_coordinates
		end
		
	fill_polygon is
			-- Fill a polygon on `drawable'.
		local
			coor: EV_COORDINATE
			points: ARRAY [EV_COORDINATE]
		do
			create points.make (1, 5)
			create coor.set (10 + x_pos, 15 + y_pos)
			points.force (coor, 1)
			create coor.set (45 + x_pos, 2 + y_pos)
			points.force (coor, 2)
			create coor.set (30 + x_pos, 50 + y_pos)
			points.force (coor, 3)
			create coor.set (20 + x_pos, 25 + y_pos)
			points.force (coor, 4)
			create coor.set (70 + x_pos, 70 + y_pos)
			points.force (coor, 5)
			drawable.fill_polygon (points)
			move_coordinates
		end
		
	fill_pie_slice is
			-- Fill a pie slice on `drawable'.
		do
			drawable.fill_pie_slice (x_pos, y_pos, 100, 100, 0, 4)
			move_coordinates
		end	

	toggle_line_style is
			-- Update the line style used for drawings.
		do
			if drawable.dashed_line_style then
				button.set_text ("Enable_dashed_line_style")
				drawable.disable_dashed_line_style
			else
				button.set_text ("Disable_dashed_line_style")
				drawable.enable_dashed_line_style
			end
		end
		
	set_line_width (value: INTEGER) is
			-- Assign `value' to the line width of `drawable'.
		do
			drawable.set_line_width (value)
		end
		
	move_coordinates is
			-- Update coordinates for drawing location.
		do
			x_pos := x_pos + xvel
			y_pos := y_pos + yvel
			if x_pos > drawable.width or x_pos < 0  then
				xvel := 0 - xvel
			end
			if y_pos > drawable.height or y_pos < 0  then
				yvel := 0 - yvel
			end
		end
		
		
		-- The coordinates on velocities for the drawings.
	x_pos, y_pos, xvel, yvel: INTEGER

		-- Widgets used to create controls.
	pixmap: EV_PIXMAP
	vertical_box: EV_VERTICAL_BOX
	button: EV_BUTTON
	random1, random2, random3: RANDOM
	drawable: EV_DRAWABLE
	horizontal_box: EV_HORIZONTAL_BOX
	spin: EV_SPIN_BUTTON
	label: EV_LABEL
	range: INTEGER_INTERVAL

end -- class DRAWABLE_CONTROL

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

