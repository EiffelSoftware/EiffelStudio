indexing
	description:
		"EiffelVision frame, Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	EV_FRAME_IMP

inherit
	EV_FRAME_I

	EV_SINGLE_CHILD_CONTAINER_IMP
		redefine
			client_x,
			client_y,
			client_width,
			client_height,
			set_default_minimum_size,
			compute_minimum_width,
			compute_minimum_height,
			resize_from_minimum,
			resize_proportionnaly
		end

	EV_FONTABLE_IMP

	EV_SYSTEM_PEN_IMP

	EV_WEL_CONTROL_CONTAINER_IMP
		redefine
			make,
			on_paint,
			top_level_window_imp,
			set_text
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
		do
			{EV_WEL_CONTROL_CONTAINER_IMP} Precursor
			!WEL_ANSI_VARIABLE_FONT! wel_font.make
			wel_set_font (wel_font)
		end

	make_with_text (txt: STRING) is
		do
			make
			set_text (txt)
		end

feature -- Access

	client_x: INTEGER is
			-- Left of the client area.
		do
			Result := box_width
		end

	client_y: INTEGER is
			-- Top of the client area.
		do
			Result := box_text_height + box_width
		end

	client_width: INTEGER is
			-- Width of the client area of container
		do
			Result := (client_rect.width - 2 * box_width).max (0)
		end
	
	client_height: INTEGER is
			-- Height of the client area of container
		do
			Result := (client_rect.height - box_text_height - 2 * box_width).max (0)
		end

	top_level_window_imp: EV_UNTITLED_WINDOW_IMP
			-- Top level window that contains the current widget.

feature -- Status setting

	set_default_minimum_size is
			-- Initialize the size of the widget.
		local
			dc: WEL_CLIENT_DC
		do
			!! dc.make (Current)
			dc.get
			internal_set_minimum_height (box_text_height + 2 * box_width)
			internal_set_minimum_width (dc.string_width (text) + 2 * box_width + 10)
			if parent_imp /= Void then
				notify_change (1 + 2)
			end
			dc.release
		end

feature -- Element change

	set_text (txt: STRING) is
			-- Set the window text
		do
			{EV_WEL_CONTROL_CONTAINER_IMP} Precursor (txt)
			invalidate
		end

	set_top_level_window_imp (a_window: EV_UNTITLED_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		do
			top_level_window_imp := a_window
			if child /= Void then
				child.set_top_level_window_imp (a_window)
			end
		end

feature {NONE} -- Implementation for automatic size compute.

	compute_minimum_width is
			-- Recompute the minimum_width of the object.
		do
			if child /= Void then
				internal_set_minimum_width (child.minimum_width + 2 * box_width)
			end
		end

	compute_minimum_height is
			-- Recompute the minimum_width of the object.
		do
			if child /= Void then
				internal_set_minimum_height (child.minimum_height + box_text_height + 2 * box_width)
			end
		end

	resize_from_minimum (a_x, a_y, a_width, a_height: INTEGER) is
			-- Resize from the minimum size of the children
		do
			move_and_resize (a_x, a_y, a_width, a_height, True)
			if child /= Void then
				child.set_move_and_size (box_width, box_text_height + box_width, 
					client_width, client_height)
			end
		end

	resize_proportionnaly (a_x, a_y, a_width, a_height: INTEGER) is
			-- Resize everything by difference with the current size.
		do
			move_and_resize (a_x, a_y, a_width, a_height, True)
			if child /= Void then
				child.set_move_and_size (box_width, box_text_height + box_width, 
					client_width, client_height)
			end
		end

feature {NONE} -- WEL Implementation

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
		local
			top: INTEGER
		do
			paint_dc.select_font (wel_font)
			paint_dc.set_text_color (foreground_color_imp)
			paint_dc.set_background_color (background_color_imp)
			paint_dc.text_out (10, 0, text)
			if text.empty then
				top := 0
			else
				top := wel_font.log_font.height // 2
			end
			paint_dc.select_pen (shadow_pen)
			paint_dc.line (0, top, 0, height - 1)
			paint_dc.line (0, height - 2, width - 2, height - 2)
			paint_dc.line (width - 2, height - 2, width - 2, top)
			if text.empty then
				paint_dc.line (0, top, width - 2, top)
			else
				paint_dc.line (0, top, 7, top)
				paint_dc.line (width - 2, top, paint_dc.string_size (text).width + 13 , top)
			end

			paint_dc.select_pen (highlight_pen)
			paint_dc.line (1, top + 1, 1, height - 2)
			paint_dc.line (0,  height - 1, width - 1, height - 1)
			paint_dc.line (width - 1, height - 1, width - 1, top)
			if text.empty then
				paint_dc.line (1, 1, width - 3, 1)
			else
				paint_dc.line (1, top + 1, 7, top +1)
				paint_dc.line (width - 3, top + 1, paint_dc.string_size (text).width + 13, top + 1)
			end
		end

	wel_font: WEL_FONT
			-- Font used for the label of the frame

	wel_set_font (a_font: WEL_FONT) is
			-- Make `a_font' the new font of the widget.
		local
			dc: WEL_CLIENT_DC
		do
			wel_font := a_font
			!! dc.make (Current)
			dc.get
			dc.select_font (a_font)
			if child /= Void then
				internal_set_minimum_height (box_text_height + 2 * box_width + child.minimum_height)
				internal_set_minimum_width (dc.string_width (text) + 2 * box_width + 10 + child.minimum_width)
			else
				internal_set_minimum_height (box_text_height + 2 * box_width)
				internal_set_minimum_width (dc.string_width (text) + 2 * box_width + 10)
			end
			dc.release
		end

	box_width: INTEGER is 4
			-- Width of the border

	box_text_height: INTEGER is
			-- Height of the label of the frame
		do
			if text.empty then
				Result := 0
			else
				Result := wel_font.log_font.height
			end
		end

end -- class EV_FRAME_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
