indexing
	description: "This class represents a MS_WINDOWS drawing area";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	DRAWING_AREA_WINDOWS

inherit
	PRIMITIVE_WINDOWS
		redefine
			resize
		end

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			show as wel_show,
			hide as wel_hide,
			destroy as wel_destroy,
			x as wel_x,
			y as wel_y,
			width as wel_width,
			height as wel_height,
			set_x as wel_set_x,
			set_y as wel_set_y,
			set_width as wel_set_width,
			set_height as wel_set_height,
			shown as wel_shown,
			parent as wel_parent,
			text as wel_text,
			text_length as wel_text_length,
			set_text as wel_set_text,
			move as wel_move,
			set_focus as wel_set_focus,
			set_capture as wel_set_capture,
			release_capture as wel_release_capture,
			item as wel_item
		undefine
			on_right_button_up, on_left_button_down,
			on_left_button_up, on_right_button_down,
			on_mouse_move, on_destroy, on_set_cursor,
			on_key_up,
			on_size,
			on_move,
			on_key_down
		redefine
			class_name,
			on_paint,
			resize
		end

	D_AREA_I

	DRAWABLE_DEVICE_WINDOWS
		rename
			clear as dd_clear,
			copy_bitmap as dd_copy_bitmap,
			draw_arc as dd_draw_arc,
			draw_image_text as dd_draw_image_text,
			draw_inf_line as dd_draw_inf_line,
			draw_point as dd_draw_point,
			draw_polyline as dd_draw_polyline,
			draw_rectangle as dd_draw_rectangle,
			draw_segment as dd_draw_segment,
			draw_text as dd_draw_text,
			fill_arc as dd_fill_arc,
			fill_polygon as dd_fill_polygon,
			fill_rectangle as dd_fill_rectangle,
			update_brush as dd_update_brush,
			update_dc as dd_update_dc,
			update_pen as dd_update_pen,
			update_font as dd_update_font
		redefine
			set_drawing_dc,
			unset_drawing_dc,
			is_drawable
		end

	DRAWABLE_DEVICE_WINDOWS
		redefine
			clear,
			copy_bitmap,
			draw_arc,
			draw_image_text,
			draw_inf_line,
			draw_point,
			draw_polyline,
			draw_rectangle,
			draw_segment,
			draw_text,
			fill_arc,
			fill_polygon,
			fill_rectangle, 
			is_drawable,
			set_drawing_dc,
			unset_drawing_dc,
			update_brush,
			update_dc,
			update_font,
			update_pen
		select
			clear,
			copy_bitmap,
			draw_arc,
			draw_image_text,
			draw_inf_line,
			draw_point,
			draw_polyline,
			draw_rectangle,
			draw_segment,
			draw_text,
			fill_arc,
			fill_polygon,
			fill_rectangle,
			update_brush,
			update_dc,
			update_font,
			update_pen
		end

	WEL_MM_CONSTANTS

	WEL_CAPABILITIES_CONSTANTS

creation
	make

feature -- Initialization

	make (a_drawing_area: DRAWING_AREA; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a drawing area
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			managed := man
			set_line_width (1);
			!! gc_fg_color.make_system (Color_windowtext)
			!! gc_bg_color.make_system (Color_window)
			line_style := ps_solid
		end

	realize is
			-- Display a drawing area
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			if not realized then
				wc ?= parent
				make_with_coordinates (wc, "", x, y, width, height)
				!WEL_CLIENT_DC! drawing_dc.make (Current)
--				clear
			end
		end

feature -- Status report

	painting: BOOLEAN
			-- Are we currently executing a WM_PAINT message?

	is_drawable: BOOLEAN is
			-- Is the device drawable?
		do
			Result := drawing_dc /= Void
		end

	is_valid: BOOLEAN is
			-- Is drawing area vaild?
		do
			Result := true
		end

feature -- Status setting

	resize (a_width, a_height: INTEGER) is
			-- Resize the window with `a_width', `a_height'.
		require else
			exists: exists
			not_minimized: not minimized
		do
			cwin_set_window_pos (wel_item, default_pointer,
				0, 0, a_width, a_height,
				Swp_nomove + Swp_nozorder + Swp_noactivate)
		end

	
feature -- Output

	clear is
			-- Clear the entire area.
		do
			if is_drawable then
				set_drawing_dc (drawing_dc)
				dd_clear
				unset_drawing_dc
			end
		end

	copy_bitmap (a_point: COORD_XY; a_bitmap : PIXMAP) is
			-- Copy `a_bitmap' to the drawing at `a_point'.
		require else
			a_point_exists: a_point /= Void
			a_bitmap_exists: a_bitmap /= Void
			a_bitmap_valid: a_bitmap.is_valid
			drawing_dc_not_void: drawing_dc /= Void
		do
			set_drawing_dc (drawing_dc)
			dd_copy_bitmap (a_point, a_bitmap)
			unset_drawing_dc
		end

	draw_arc (center: COORD_XY; radius1, radius2: INTEGER; angle1, angle2, orientation: REAL; arc_style: INTEGER) is
			-- Draw an arc centered in (`x', `y') with a great radius of
			-- `radius1' and a small radius of `radius2'
			-- beginnning at `angle1' and finishing at `angle1'+`angle2'
			-- and with an orientation of `orientation'.
		do
			set_drawing_dc (drawing_dc)
			dd_draw_arc (center, radius1, radius2, angle1, angle2, orientation, arc_style)
			unset_drawing_dc
		end

	draw_image_text (base: COORD_XY; text: STRING) is
			-- Draw text
		do
			set_drawing_dc (drawing_dc)
			dd_draw_image_text (base, text)
			unset_drawing_dc
		end

	draw_inf_line (point1, point2: COORD_XY) is
			-- Draw an infinite line traversing `point1' and `point2'.
		do
			set_drawing_dc (drawing_dc)
			dd_draw_inf_line (point1, point2)
			unset_drawing_dc
		end

	draw_point (a_point: COORD_XY) is
			-- Draw `a_point'.
		do
			set_drawing_dc (drawing_dc)
			dd_draw_point (a_point)
			unset_drawing_dc
		end

	draw_polyline (points: LIST [COORD_XY]; is_closed: BOOLEAN) is
			-- Draw a polyline, close it automatically if `is_closed'.
		do
			set_drawing_dc (drawing_dc)
			dd_draw_polyline (points, is_closed)
			unset_drawing_dc
		end

	draw_rectangle (center: COORD_XY; rwidth, rheight: INTEGER; an_orientation: REAL) is
			-- Draw a rectangle whose center is `center' and
			-- whose size is `rwidth' and `rheight'.
		do
			set_drawing_dc (drawing_dc)
			dd_draw_rectangle (center, rwidth, rheight, an_orientation)
			unset_drawing_dc
		end

	draw_segment (point1, point2: COORD_XY) is
			-- Draw a segment between `point1' and `point2'.
		do
			set_drawing_dc (drawing_dc)
			dd_draw_segment (point1, point2)
			unset_drawing_dc
		end

	draw_text (base: COORD_XY; text: STRING) is
			-- Draw text
		do
			set_drawing_dc (drawing_dc)
			dd_draw_text (base, text)
			unset_drawing_dc
		end

	fill_arc (center: COORD_XY; radius1, radius2 : INTEGER; angle1, angle2, orientation: REAL; arc_style: INTEGER) is
			-- Fill an arc centered in (`x', `y') with a great radius of
			-- `radius1' and a small radius of `radius2'
			-- beginnning at `angle1' and finishing at `angle1'+`angle2'
			-- and with an orientation of `orientation'.
		do
			set_drawing_dc (drawing_dc)
			dd_fill_arc (center, radius1, radius2, angle1, angle2, orientation, arc_style)
			unset_drawing_dc
		end

	fill_polygon (points: LIST [COORD_XY]) is
			 -- Fill a polygon.
		do
			set_drawing_dc (drawing_dc)
			dd_fill_polygon (points)
			unset_drawing_dc
		end

	fill_rectangle (center: COORD_XY; rwidth, rheight : INTEGER; an_orientation: REAL) is
			-- Fill a rectangle whose center is `center' and
			-- whose size is `rwidth' and `rheight'.
		do
			set_drawing_dc (drawing_dc)
			dd_fill_rectangle (center, rwidth, rheight, an_orientation)
			unset_drawing_dc
		end 

	output_to_printer (a_name: STRING) is
		require
			a_name_valid: a_name /= Void and not a_name.empty
		local
			old_dc: WEL_DC
			print_dc: WEL_DEFAULT_PRINTER_DC
			t: INTEGER
			expose_data: EXPOSE_DATA
			coord: COORD_XY
			clip: CLIP
		do
			!! print_dc.make
			if print_dc.exists then
				print_dc.start_document (a_name)
				print_dc.set_map_mode (mm_anisotropic)
				print_dc.set_window_extent (width, height)
				print_dc.set_viewport_extent (print_dc.device_caps (horizontal_resolution), print_dc.device_caps (vertical_resolution))
				painting := true
				old_dc := drawing_dc
				set_drawing_dc (print_dc)
				!! coord
				coord.set (0, 0)
				!! clip
				clip.set (coord, width, height)
				!! expose_data.make (owner, clip, 0)
				expose_actions.execute (Current, expose_data)
				unset_drawing_dc
				print_dc.new_frame
				print_dc.end_document
				drawing_dc := old_dc
				painting := false
			else
				t := message_box ("No default printer set.  Printing unavailable.", 
					"Printer Not Set", mb_iconstop + mb_ok)
			end
		end

feature -- Element change

	add_input_action (command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to be executed when
			-- a key is pressed or when a mouse button is pressed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		do
			left_button_press_actions.add (Current, command, arg)
			right_button_press_actions.add (Current, command, arg)
			middle_button_press_actions.add (Current, command, arg)
			character_actions.add (Current, command, arg)
		end

feature -- Removal

	remove_input_action (command: COMMAND; arg: ANY) is
			-- Remove `a_command' with `argument' from the list of action
			-- to be executed when a key is pressed or when a mouse button
			-- is pressed.
		do
			left_button_press_actions.remove (Current, command, arg)
			right_button_press_actions.remove (Current, command, arg)
			middle_button_press_actions.remove (Current, command, arg)
			character_actions.remove (Current, command, arg)
		end


feature {NONE} -- Implementation

	set_drawing_dc (dc: WEL_DC) is
			-- Set `drawing_dc' as necessary
		require else
			painting: painting
		local
			a_client_dc: WEL_CLIENT_DC
		do
			drawing_dc := dc
			if not painting then
				a_client_dc ?= drawing_dc
				check
					client_dc_not_void: a_client_dc /= Void
				end
				a_client_dc.get
			end
			update_brush
			if drawing_font /= Void then
				update_font
			end
			dd_update_dc
			update_pen
		end

	unset_drawing_dc is
			-- Reset the dc to the original contents
		local
			a_client_dc: WEL_CLIENT_DC
		do
			drawing_dc.unselect_all
			if not painting then
				a_client_dc ?= drawing_dc
				check
					client_dc_not_void: a_client_dc /= Void
				end
				a_client_dc.release
			end
		end

	update_dc is
			-- Update the `drawing_dc' due to dc details changing
		require else
			drawing_dc: drawing_dc /= Void
		do
			if drawing_dc.exists then
				dd_update_dc
			end
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EVisionDrawingArea"
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Redraw area.
		local
			old_dc: WEL_DC
			expose_data: EXPOSE_DATA
			coord: COORD_XY
			clip: CLIP
		do
			painting := true
			old_dc := drawing_dc
			set_drawing_dc (paint_dc)
			!! coord
			coord.set (invalid_rect.x, invalid_rect.y)
			!! clip
			clip.set (coord, invalid_rect.width, invalid_rect.height)
			!! expose_data.make (owner, clip, 0)
			expose_actions.execute (Current, expose_data)
			unset_drawing_dc
			drawing_dc := old_dc
			painting := false
		end

	update_brush is
			-- Update the `drawing_dc' due to brush details changing
		require else
			drawing_dc: drawing_dc /= Void
		do
			if drawing_dc.exists then
				dd_update_brush
			end
		end

	update_font is
			-- Update the `drawing_dc' due to font details changing
		require else
			drawing_dc: drawing_dc /= Void
		do
			if drawing_dc.exists then
				dd_update_font
			end
		end

	update_pen is
			-- Update the `drawing_dc' due to pen details changing
		require else
			drawing_dc: drawing_dc /= Void
		do
			if drawing_dc.exists then
				dd_update_pen
			end
		end

	wel_font: WEL_FONT

	wel_set_font (f:WEL_FONT) is
		do
		end

end -- class DRAWING_AREA_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
