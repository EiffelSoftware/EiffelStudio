indexing
	description:
		"Eiffel Vision frame. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FRAME_IMP

inherit
	EV_FRAME_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_SINGLE_CHILD_CONTAINER_IMP
		redefine
			client_x,
			client_y,
			client_width,
			client_height,
			set_default_minimum_size,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size,
			interface,
			initialize
		end

	EV_TEXTABLE_IMP
		undefine
			set_default_minimum_size
		redefine
			interface
		end

	EV_SYSTEM_PEN_IMP

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make,
			style as window_style,
			set_style as set_window_style
		redefine
			on_paint,
			top_level_window_imp,
			wel_move_and_resize,
			wel_set_text
		end

	WEL_DRAWING_ROUTINES

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the frame with the default options.
		do
			base_make (an_interface)
			ev_wel_control_container_make
			style := Ev_frame_etched_in
		end

	initialize is
			-- Set default font.
		do
			{EV_SINGLE_CHILD_CONTAINER_IMP} Precursor
			wel_set_font (create {WEL_ANSI_VARIABLE_FONT}.make)
		end

feature -- Access

	style: INTEGER
			-- Visual appearance. See: EV_FRAME_CONSTANTS.

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
			Result := (client_rect.height - box_text_height -
				2 * box_width).max (0)
		end

feature -- Element change

	set_style (a_style: INTEGER) is
			-- Assign `a_style' to `style'.
		do
			style := a_style
			invalidate
		end

feature -- Status setting

	set_default_minimum_size is
			-- Initialize the size of the widget.
		local
			dc: WEL_CLIENT_DC
		do
			!! dc.make (Current)
			dc.get
			internal_set_minimum_size (dc.string_width (wel_text) +
				2 * box_width + 10, box_text_height + 2 * box_width)
			dc.release
		end

	align_text_center is
			-- Display `text' centered.
		do
			check
				to_be_implemented: False
			end
		end

	align_text_left is
			-- Display `text' left aligned.
		do
			check
				to_be_implemented: False
			end
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			check
				to_be_implemented: False
			end
		end

feature -- Element change

	wel_set_text (txt: STRING) is
			-- Set the window text
		do
			{EV_WEL_CONTROL_CONTAINER_IMP} Precursor (txt)
			invalidate
		end

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		do
			top_level_window_imp := a_window
			if item_imp /= Void then
				item_imp.set_top_level_window_imp (a_window)
			end
		end

feature {NONE} -- Implementation for automatic size compute.

	compute_minimum_width is
			-- Recompute the minimum_width of the object.
		do
			if item_imp /= Void then
				internal_set_minimum_width (item_imp.minimum_width +
					2 * box_width)
			end
		end

	compute_minimum_height is
			-- Recompute the minimum_width of the object.
		do
			if item_imp /= Void then
				internal_set_minimum_height (item_imp.minimum_height +
					box_text_height + 2 * box_width)
			end
		end

	compute_minimum_size is
			-- Recompute both the minimum_width and then
			-- minimum_height of the object.
		do
			if item_imp /= Void then
				internal_set_minimum_size (item_imp.minimum_width + 2 * box_width,
					item_imp.minimum_height + box_text_height + 2 * box_width)
			end
		end

feature {NONE} -- WEL Implementation

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains the current widget.

	wel_move_and_resize (a_x, a_y, a_width, a_height: INTEGER;
		repaint: BOOLEAN) is
			-- Make `x' and `y' the new position of the current object and
			-- `w' and `h' the new width and height of it.
			-- If there is any child, it also adapt them to fit to the given
			-- value.
		do
			{EV_WEL_CONTROL_CONTAINER_IMP} Precursor (a_x, a_y, a_width,
				a_height, repaint)
			if item_imp /= Void then
				item_imp.set_move_and_size (box_width, box_text_height +
					box_width, client_width, client_height)
			end
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Redraw frame with `style'.
		local
			wel_style: INTEGER
		do
			inspect style
				when Ev_frame_lowered then wel_style := Edge_sunken
				when Ev_frame_raised then wel_style := Edge_raised
				when Ev_frame_etched_in then wel_style := Edge_etched
				when Ev_frame_etched_out then wel_style := Edge_bump
			else
				check
					valid_value: False
				end
			end
			paint_dc.select_font (wel_font)
			paint_dc.set_text_color (foreground_color_imp)
			paint_dc.set_background_color (background_color_imp)
			draw_edge (paint_dc, invalid_rect, wel_style, Bf_rect)
			if is_sensitive then
				paint_dc.text_out (10, 0, wel_text)
			else
				draw_insensitive_text (paint_dc, wel_text, 10, 0)
			end
		end

	paint_etched_in_frame (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Paint frame that looks like a groove.
		local
			top: INTEGER
		do
			paint_dc.select_font (wel_font)
			paint_dc.set_text_color (foreground_color_imp)
			paint_dc.set_background_color (background_color_imp)
			paint_dc.text_out (10, 0, wel_text)
			if wel_text.empty then
				top := 0
			else
				top := wel_font.log_font.height // 2
			end
			paint_dc.select_pen (shadow_pen)
			paint_dc.line (0, top, 0, height - 1)
			paint_dc.line (0, height - 2, width - 2, height - 2)
			paint_dc.line (width - 2, height - 2, width - 2, top)
			if wel_text.empty then
				paint_dc.line (0, top, width - 2, top)
			else
				paint_dc.line (0, top, 7, top)
				paint_dc.line (width - 2, top,
					paint_dc.string_size (wel_text).width + 13 , top)
			end

			paint_dc.select_pen (highlight_pen)
			paint_dc.line (1, top + 1, 1, height - 2)
			paint_dc.line (0,  height - 1, width - 1, height - 1)
			paint_dc.line (width - 1, height - 1, width - 1, top)
			if wel_text.empty then
				paint_dc.line (1, 1, width - 3, 1)
			else
				paint_dc.line (1, top + 1, 7, top +1)
				paint_dc.line (width - 3, top + 1,
					paint_dc.string_size (wel_text).width + 13, top + 1)
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
			if item_imp /= Void then
				internal_set_minimum_size (dc.string_width (wel_text) +
					2 * box_width + 10 + item_imp.minimum_width,
					box_text_height + 2 * box_width + item_imp.minimum_height)
			else
				internal_set_minimum_size (dc.string_width (wel_text) +
					2 * box_width + 10,
					box_text_height + 2 * box_width)
			end
			dc.release
		end

	box_width: INTEGER is 4
			-- Width of the border

	box_text_height: INTEGER is
			-- Height of the label of the frame
		do
			if wel_text.empty then
				Result := 0
			else
						--|FIXME Fonts are currently changing.
						--|Needs to be changed to the new implementation
						--|Of the old code listed below
				Result := 10 --|wel_font.log_font.height
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_FRAME

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.30  2000/04/27 18:30:22  brendel
--| Corrected order of arguments.
--|
--| Revision 1.29  2000/04/27 18:13:08  brendel
--| Improved `on_paint'.
--|
--| Revision 1.27  2000/04/27 17:15:19  brendel
--| Started revising.
--|
--| Revision 1.26  2000/04/26 21:01:29  brendel
--| child -> item or item_imp.
--|
--| Revision 1.25  2000/03/28 00:17:00  brendel
--| Revised `text' related features as specified by new EV_TEXTABLE_IMP.
--|
--| Revision 1.24  2000/03/21 23:39:00  brendel
--| Modified inheritance clause in compliance with EV_SIZEABLE_IMP.
--|
--| Revision 1.23  2000/02/22 01:16:24  rogers
--| Renamed text inherited from EV_WEL_CONTROL_CONTAINER_IMP to wel_text.
--| Implemented text to return Void if wel_text is empty, wel text otherwise.
--| All references to text, where apprpriate have been changed to wel_text.
--| Added a FIXME to box_text_height, this change is only temporary.
--|
--| Revision 1.22  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.21  2000/02/14 11:40:43  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.20.10.4  2000/02/08 07:21:03  brendel
--| Minor changes to run through compiler.
--| Still needs major revision.
--|
--| Revision 1.20.10.3  2000/01/27 19:30:20  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.20.10.2  1999/12/17 00:53:26  rogers
--| Altered to fit in with the review branch. Redefinitions required, make now
--| requires an interface.
--|
--| Revision 1.20.10.1  1999/11/24 17:30:26  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.20.6.3  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
