indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DRAWABLE_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end
	EV_BASIC_COLORS
	PIXMAP_PATH

creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create tab and initalise it's objects.
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
				-- Commands used by tab.
			counter, xpos, ypos, txpos, typos: INTEGER
			l1: EV_LIST_ITEM
				-- List of drawing styles.

		do
			{ANY_TAB} Precursor (Void)
			create n1.make (Current)
			n1.set_tab_bottom
			set_child_position(n1, 0, 0, 2, 2)
			create t1.make (n1)
			create t2.make (n1)
			n1.append_page (t1, "Attributes")
			n1.append_page (t2, "Geometrics")
			create cmd1.make (~set_line_width)
			create cmd2.make (~get_line_width)		
			create f3.make (t1, 2, 0, "Line Width", cmd1, cmd2)
			create cmd1.make (~set_logical_mode)
			create cmd2.make (~get_logical_mode)
			create f4.make (t1, 3, 0, "Drawing Mode", cmd1, cmd2)
			create cmd2.make (~drawable)
			create f5.make (t1, 4, 0, "Drawable", Void, cmd2)
			
			-- Set up `list1'.
			create list1.make (t2)
			t2.set_child_position (list1, 0, 0, 2, 2)
			create cmd1.make (~select_drawing_item)
			list1.add_select_command (cmd1, Void)
			create i1.make_with_text (list1, "Point")
			create i1.make_with_text (list1, "Text")
			create i1.make_with_text (list1, "Segment")
			create i1.make_with_text (list1, "Line")			
			create i1.make_with_text (list1, "Polyline")
			create i1.make_with_text (list1, "Rectangle")
			create i1.make_with_text (list1, "Arc")
			create i1.make_with_text (list1, "Ellipse")
			create i1.make_with_text (list1, "Pixmap")
			create i1.make_with_text (list1, "Fill Polygon")
			create i1.make_with_text (list1, "Fill Rect")
			create i1.make_with_text (list1, "Fill Arc")
			create i1.make_with_text (list1, "Fill Ellipse")
			create i1.make_with_text (list1, "Clear Rect")

				-- Create buttons for tab.			
			create cmd1.make (~draw_item)
			create b1.make_with_text (t2, "Draw")
			b1.set_vertical_resize (False)
			b1.add_click_command (cmd1, Void)
			t2.set_child_position (b1, 2, 0, 3, 2)
			create cmd1.make (~clear)
			create b2.make_with_text (t2, "Clear Drawing")
			b2.set_vertical_resize (False)
			b2.add_click_command (cmd1, Void)
			t2.set_child_position (b2, 3, 0, 4, 2)
			create cmd1.make (~add_to_list)
			create b3.make_with_text (t2, "Add ")
			b3.set_vertical_Resize (False)
			b3.add_click_command (cmd1, Void)
			t2.set_child_position (b3, 3, 2, 4, 3)
			b3.hide
			create cmd1.make (~clear_list)
			create b4.make_with_text (t2, "Clear List")
			b4.add_click_command (cmd1, Void)
			t2.set_child_position (b4, 3, 3, 4, 4)
			b4.set_vertical_resize (False)
			b4.hide
			create list2.make (t2)
			t2.set_child_position (list2, 3, 4, 4, 6)
			list2.hide
			create points.make (1,0)
			
				-- Create `text_fields' and `text_labels'.
			create text_labels.make(0, 8)
			create text_fields.make(0, 8)
			from
				counter:=0
				ypos:=0
				xpos:=2
			until
				counter=8
			loop
				counter:= counter +1
				create label1.make (t2)
				create text1.make (t2)
					xpos := 2*(((counter-1) \\ 2)+1)
					typos:= ypos + ((counter-1) // 2)
					t2.set_child_position (clone(label1), typos, xpos, typos + 1, xpos+1)
					label1.set_center_alignment
					label1.set_vertical_resize (False) 
					t2.set_child_position (clone(text1), typos, xpos+1, typos + 1, xpos+2)
					text_labels.put (label1, counter)
					text_fields.put (text1, counter)
					text_fields.item (counter).add_return_command(cmd1, Void)
			end
			create current_pixmap.make_from_file (pixmap_path ("system"))
			set_parent (par)
		end

feature -- Access

	name:STRING is
			-- Returns `name'.
		do
			Result:="Drawable"

		ensure then
			result_exists: Result /= Void
		end

	current_widget: EV_DRAWING_AREA
		-- Current demo.
	f3,f4,f5: TEXT_FEATURE_MODIFIER
		-- Text feature modifiers for `action_window'.
	list1,list2: EV_LIST
		-- Drawing features and points.
	b1,b2,b3,b4: EV_BUTTON
		-- Buttons for `action window'.
	n1: EV_NOTEBOOK
		-- notebook inside `drawable_tab'.
	t1,t2: EV_TABLE
		-- Two tabs for notebook inside `drawable_tab'.
	current_pixmap: EV_PIXMAP
		-- Pixmap to display.
	text1: EV_TEXT_FIELD
	label1: EV_LABEL
	i1: EV_LIST_ITEM
	text_fields: ARRAY[EV_TEXT_FIELD]
		-- Text fields for input.
	text_labels: ARRAY[EV_LABEL]
		-- Associated labels.
	points: ARRAY[EV_COORDINATES]
		-- Array of points to be used for polyline and polyfill.
feature -- Execution Feature

	point_setup is
			-- Set up `text_labels' for a point item.
		do
			enable_text_boxes (2)
			set_comments ("X", "Y", "" , "", "", "", "", "")
		end

	text_setup is
			-- Set up `text_labels' for a text item.
		do
			enable_text_boxes (3)
			set_comments ("X", "Y", "Text", "", "", "", "", "")
		end

	segment_setup is
			-- Set up `text_labels' for a segment item.
		do
			enable_text_boxes (4)
			set_comments ("X1", "Y1", "X2", "Y2", "", "", "", "")
		end

	straight_line_setup is
			-- Set up `text_labels' for a stright line item.
		do
			segment_setup
		end

	poly_line_setup is
			-- Set up `text_labels' for a poly line.
		do
			enable_text_boxes (6)
			set_comments ("X1", "Y1", "X2", "Y2", "X3", "Y3", "", "")
			b3.show
			b4.show
			list2.show
			text_fields.item (7).hide
			text_fields.item (8).hide
			text_labels.item (7).hide
			text_labels.item (8).hide
		end

	rectangle_setup is
			-- Set up `text_labels' for a rectangle.
		do
			enable_text_boxes (5)
			set_comments ("X", "Y", "Height", "Width", "Orientation", "", "", "")
		end

	arc_setup is
			-- Set up `text_labels' for an arc.
		do
			enable_text_boxes (8)
			set_comments ("X", "Y", "Great Radius", "Small Radius", "Start Angle", "Aperture", "Orientation", "Style")
		end
	
	ellipse_setup is
			-- Set up `text_labels' for an ellipse.
		do
			enable_text_boxes (5)
			set_comments ("X", "Y", "Great Radius", "Small Radius", "Orientation", "", "", "")
		end

	pixmap_setup is
			-- Set up `text_labels' for a pixmap.
		do
			point_setup
		end

	draw_point is
			-- Validate `text_fields' and draw a point.
		local
			coor: EV_COORDINATES
		do
			if text_fields.item (1).text.is_integer and
			text_fields.item (2).text.is_integer then
				create coor.make
				coor.set (text_fields.item (1).text.to_integer, text_fields.item (2).text.to_integer)	
				current_widget.draw_point (coor)
			end
		end
	
	draw_text is
			-- Validate `text_fields' and draw a text.
		local
			coor: EV_COORDINATES
		do
			if text_fields.item (1).text.is_integer and
			text_fields.item (2).text.is_integer then
				create coor.make	
				coor.set (text_fields.item (1).text.to_integer, text_fields.item (2).text.to_integer)
				current_widget.draw_text (coor, text_fields.item (3).text)
			end
		end

	draw_segment is
			-- Validate `text_fields' and draw a segment.
		local
			coor1, coor2: EV_COORDINATES
		do
			if text_fields.item (1).text.is_integer and text_fields.item (2).text.is_integer
			and text_fields.item (3).text.is_integer and text_fields.item (4).text.is_integer then
				create coor1.make
				create coor2.make
				coor1.set (text_fields.item (1).text.to_integer, text_fields.item (2).text.to_integer)
				coor2.set (text_fields.item (3).text.to_integer, text_fields.item (4).text.to_integer)
				current_widget.draw_segment (coor1, coor2)
			end
		end

	draw_straight_line is
			-- Validate `text_fields' and draw a straight line.
		local
			coor1, coor2: EV_COORDINATES
		do
			if text_fields.item (1).text.is_integer and text_fields.item (2).text.is_integer
			and text_fields.item (3).text.is_integer and text_fields.item (4).text.is_integer then
				create coor1.make
				create coor2.make
				coor1.set (text_fields.item (1).text.to_integer, text_fields.item (2).text.to_integer)
				coor2.set (text_fields.item (3).text.to_integer, text_fields.item (4).text.to_integer)
				current_widget.draw_straight_line (coor1, coor2)
			end
		end

	draw_poly_line (filled: BOOLEAN) is
			-- Validate `text_fields' and draw a poly line.
		do
			if points.count >=1 then
				if filled then
					current_widget.fill_polygon (points)
				else
					current_widget.draw_polyline (points, True)
				end
			end
		end

	draw_rectangle (filled: BOOLEAN) is
			-- Validate `text_fields' and draw a rectangle.
		local
			coor: EV_COORDINATES
			s1, s2, s3, s4, s5: STRING
			angle: EV_ANGLE
		do
			s1 := text_fields.item (1).text
			s2 := text_fields.item (2).text
			s3 := text_fields.item (3).text
			s4 := text_fields.item (4).text
			s5 := text_fields.item (5).text
			if s1.is_integer and s2.is_integer and s3.is_integer and
			s4.is_integer and s5.is_real then
				create coor.make
				coor.set (s1.to_integer, s2.to_integer)
				create angle.make_in_degrees (s5.to_real)
				if filled then
					current_widget.fill_rectangle (coor, s3.to_integer, s4.to_integer, angle)
				else
					current_widget.draw_rectangle (coor, s3.to_integer, s4.to_integer, angle)
				end
			end
		end

	clear_rectangle is
			-- Validate `text_fields' and clear a rectangle.
		local
			s1, s2, s3, s4, s5: STRING
		do
			s1 := text_fields.item (1).text
			s2 := text_fields.item (2).text
			s3 := text_fields.item (3).text
			s4 := text_fields.item (4).text
			if s1.is_integer and s2.is_integer and s3.is_integer and
			s4.is_integer then
				current_widget.clear_rect (s1.to_integer, s2.to_integer, s3.to_integer, s4.to_integer)
			end
		end

	draw_arc (filled: BOOLEAN) is
			-- Validate `text_fields' and draw arc.
		local
			coor: EV_COORDINATES
			s1, s2, s3, s4, s5, s6, s7, s8: STRING
			angle1,angle2,angle3: EV_ANGLE
		do
			s1 := text_fields.item (1).text
			s2 := text_fields.item (2).text
			s3 := text_fields.item (3).text
			s4 := text_fields.item (4).text
			s5 := text_fields.item (5).text
			s6 := text_fields.item (6).text
			s7 := text_fields.item (7).text
			s8 := text_fields.item (8).text
			if s1.is_integer and s2.is_integer and s3.is_integer and
			s4.is_integer and s5.is_real and s6.is_real and s7.is_real and
			s8.is_integer and s8.to_integer >= -1 and s8.to_integer <= 1 then
				create coor.make
				coor.set (s1.to_integer, s2.to_integer)
				create angle1.make_in_degrees (s5.to_real)
				create angle2.make_in_degrees (s6.to_real)
				create angle3.make_in_degrees (s7.to_real)
				if filled then
					current_widget.fill_arc (coor, s3.to_integer, s4.to_integer, angle1, angle2, angle3, s8.to_integer)
				else
					current_widget.draw_arc (coor, s3.to_integer, s4.to_integer, angle1, angle2, angle3, s8.to_integer)
				end
			end
		end

	draw_ellipse (filled: BOOLEAN)is
			-- Validate `text_fields' and draw ellipse.
		local
			coor: EV_COORDINATES
			s1, s2, s3, s4, s5: STRING
			angle: EV_ANGLE
		do
			s1 := text_fields.item (1).text
			s2 := text_fields.item (2).text
			s3 := text_fields.item (3).text
			s4 := text_fields.item (4).text
			s5 := text_fields.item (5).text
			if s1.is_integer and s2.is_integer and s3.is_integer and
			s4.is_integer and s5.is_real then
				create coor.make
				coor.set (s1.to_integer, s2.to_integer)
				create angle.make_in_degrees (s5.to_real)
				if filled then
					current_widget.fill_ellipse (coor, s3.to_integer, s4.to_integer, angle)
				else
					current_widget.draw_ellipse (coor, s3.to_integer, s4.to_integer, angle)
				end
			end
		end	

	draw_pixmap is
			-- Validate `text_fields' and draw a pixmap.
		local
			coor: EV_COORDINATES
			s1, s2: STRING
		do
			s1 := text_fields.item (1).text
			s2 := text_fields.item (2).text
			if s1.is_integer and s2.is_integer then
				create coor.make
				coor.set (s1.to_integer, s2.to_integer)
				current_widget.draw_pixmap (coor, current_pixmap)
			end
		end

	set_comments (s1, s2, s3, s4, s5, s6, s7, s8: STRING) is
			-- Set `text_labels' for each `text_field'.
		do
			text_labels.item(1).set_text(s1)
			text_labels.item(2).set_text(s2)
			text_labels.item(3).set_text(s3)
			text_labels.item(4).set_text(s4)
			text_labels.item(5).set_text(s5)
			text_labels.item(6).set_text(s6)
			text_labels.item(7).set_text(s7)
			text_labels.item(8).set_text(s8)
		end

	enable_text_boxes (count: INTEGER) is
			-- Enable `count' `text_fields'.
			-- Disable remaining.
		require
			count_exists: count /= Void
			greater_than_zero: count > 0
			valid_index: count <= 8
		local
			counter: INTEGER
		do
			from
				counter:= 1
			until
				counter=9
			loop
				if (counter <= count) then
					text_fields.item (counter).set_insensitive (False)
					if not text_fields.item (counter).text.is_integer then
						text_fields.item (counter).set_text ("")
					end
				else
					text_fields.item (counter).set_text ("")
					text_fields.item (counter).set_insensitive (True)
				end
				counter:= counter + 1
			end
		end

	extend_list (current_coordinate: EV_COORDINATES) is
			-- update `list1'.
		local
			temp_string: STRING
		do
			create temp_string.make (0)
			temp_string.append_string ("X: ")
			temp_string.append_string (current_coordinate.x.out)
			temp_string.append_string (" Y: ")
			temp_string.append_string (current_coordinate.y.out)
			create i1.make_with_text (list2, temp_string)
		end

	draw_item (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Draw selected item in `list1'.
		do
			inspect list1.selected_item.index
			when 1 then draw_point
			when 2 then draw_text
			when 3 then draw_segment
			when 4 then draw_straight_line
			when 5 then draw_poly_line (False)
			when 6 then draw_rectangle (False) 
			when 7 then draw_arc (False)
			when 8 then draw_ellipse (False)
			when 9 then draw_pixmap
			when 10 then draw_poly_line (True)
			when 11 then draw_rectangle (True)
			when 12 then draw_arc (True)
			when 13 then draw_ellipse (True)
			when 14 then clear_rectangle
			end
		end

	select_drawing_item (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Select current item from `list1'.
		do
			inspect list1.selected_item.index
				when 1 then point_setup
				when 2 then text_setup
				when 3 then segment_setup
				when 4 then straight_line_setup
				when 5, 10 then poly_line_setup
				when 6, 11 then rectangle_setup
				when 7, 12 then arc_setup
				when 8, 13 then ellipse_setup
				when 9 then pixmap_setup
				when 14 then segment_setup
			end
			if not equal (list1.selected_item.index, 5) and
			not equal (list1.selected_item.index, 10) and
			b3.shown and b4.shown then
				b3.hide
				b4.hide
				list2.hide
				text_fields.item (7).show
				text_fields.item (8).show
				text_labels.item (7).show
				text_labels.item (8).show	
			end
		end

	set_line_width (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set current line width.
		do
			if f3.get_text.is_integer and f3.get_text.to_integer >0 then
				current_widget.set_line_width (f3.get_text.to_integer)	
			end
		end

	get_line_width (arg: EV_ARGUMENT; data: EV_EVENT_DATA) IS
			-- Current line width.
		do
			f3.set_text (current_widget.line_width.out)
		end

	set_logical_mode (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set logical drawing mode.
		do
			if f4.get_text.is_integer and f4.get_text.to_integer >= 0 and
			f4.get_text.to_integer <= 15 then
				current_widget.set_logical_mode (f4.get_text.to_integer)
			end
		end

	get_logical_mode (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Logical drawing mode.
		do
			f4.set_text (current_widget.logical_mode.out)
		end

	drawable (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Is current demo drawable?
		do
			if current_widget.is_drawable then
				f5.set_text("Yes")
			else
				f5.set_text("No")
			end
		end

	clear_list (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Clear `list2' and reset `points'.
		do
			create points.make (1,0)
			list2.clear_items
		end

	clear (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Clear drawing area.
		do
			current_widget.clear
		end
	
	add_to_list (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Add displayed points to `list2'.
		local
			p1,p2,p3: EV_COORDINATES	
		do
			if points = Void then
				create points.make (1,0)
			end
			if text_fields.item (1).text.is_integer and text_fields.item (2).text.is_integer then
				create p1.make
				p1.set (text_fields.item (1).text.to_integer, text_fields.item (2).text.to_integer)
				points.force (p1, points.count)
				extend_list (p1)
			end
			if text_fields.item (3).text.is_integer and text_fields.item (4).text.is_integer then
				create p2.make
				p2.set (text_fields.item (3).text.to_integer, text_fields.item (4).text.to_integer)
				points.force (p2, points.count)	
				extend_list (p2)
			end
			if text_fields.item (5).text.is_integer and text_fields.item (6).text.is_integer then
				create p3.make
				p3.set (text_fields.item (5).text.to_integer, text_fields.item (6).text.to_integer)				
				points.force (p3, points.count)
				extend_list (p3)
			end
		end

end -- class DRAWABLE_TAB
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

