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
		rename
			style as frame_style,
			set_style as set_frame_style
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
			enable_sensitive,
			disable_sensitive
		end

	EV_TEXTABLE_IMP
		undefine
			set_default_minimum_size
		redefine
			interface,
			set_text,
			remove_text,
			align_text_center,
			align_text_right,
			align_text_left
		end

	EV_SYSTEM_PEN_IMP

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make
		redefine
			on_paint,
			top_level_window_imp,
			on_erase_background
		end

	WEL_DRAWING_ROUTINES

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with the default options.
			-- Assign `Ev_frame_etched_in' to `frame_style'.
		do
			base_make (an_interface)
			ev_wel_control_container_make
			frame_style := Ev_frame_etched_in
			wel_font := (create {WEL_SHARED_FONTS}).gui_font
		end

feature -- Access

	frame_style: INTEGER
			-- Visual appearance. See: EV_FRAME_CONSTANTS.

	client_x: INTEGER is
			-- Left of the client area.
		do
			Result := Border_width
		end

	client_y: INTEGER is
			-- Top of the client area.
		do
			Result := text_height.max (Border_width)
		end

	client_width: INTEGER is
			-- Width of the client area.
		do
			Result := (ev_width - client_x - Border_width).max (0)
		end
	
	client_height: INTEGER is
			-- Height of the client area.
		do
			Result := (height - client_y - Border_width).max (0)
		end

feature -- Element change

	enable_sensitive is
			-- Set `item' sensitive to user actions.
		do
			Precursor {EV_SINGLE_CHILD_CONTAINER_IMP}
			invalidate
		end

	disable_sensitive is
			-- Set `item' insensitive to user actions.
		do
			Precursor {EV_SINGLE_CHILD_CONTAINER_IMP}
			invalidate
		end

	set_frame_style (a_style: INTEGER) is
			-- Assign `a_style' to `frame_style'.
		do
			frame_style := a_style
			invalidate
		end

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		local
			t: TUPLE [INTEGER, INTEGER]
		do
			t := wel_font.string_size (" " + a_text + " ")
			text_width := t.integer_item (1)
			text_height := t.integer_item (2)
			Precursor {EV_TEXTABLE_IMP} (a_text)
			notify_change (2 + 1, Current)
			invalidate
		end

	remove_text is
			-- Make `text' `Void'.
		do
			text_width := 0
			text_height := 0
			Precursor {EV_TEXTABLE_IMP}
			invalidate
		end

feature -- Status setting

	set_default_minimum_size is
			-- Initialize the size of `Current'.
		do
			ev_set_minimum_size (2 * Text_padding, 2 * Border_width)
		end

	align_text_center is
			-- Display `text' centered.
		do
			Precursor {EV_TEXTABLE_IMP}
			invalidate
		end

	align_text_left is
			-- Display `text' left aligned.
		do
			Precursor {EV_TEXTABLE_IMP}
			invalidate
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			Precursor {EV_TEXTABLE_IMP}
			invalidate
		end

feature -- Element change

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		do
			top_level_window_imp := a_window
			if item_imp /= Void then
				item_imp.set_top_level_window_imp (a_window)
			end
		end

feature {NONE} -- Implementation for automatic size compute.

	compute_minimum_width is
			-- Recompute the minimum_width of `Current'.
		local
			minwidth: INTEGER
		do
			if item_imp /= Void and item_imp.is_show_requested then
				minwidth := item_imp.minimum_width
			end
			minwidth := minwidth + client_x + Border_width
			minwidth := minwidth.max (text_width + 2 * Text_padding)
			ev_set_minimum_width (minwidth)
		end

	compute_minimum_height is
			-- Recompute the minimum_height of `Current'.
		local
			minheight: INTEGER
		do
			if item_imp /= Void and item_imp.is_show_requested then
				minheight := item_imp.minimum_height
			end
			minheight := minheight + client_y + Border_width
			ev_set_minimum_height (minheight)
		end

	compute_minimum_size is
			-- Recompute both the minimum_width and then
			-- minimum_height of `Current'.
		local
			minheight, minwidth: INTEGER
		do
			if item_imp /= Void and then item_imp.is_show_requested then
				minwidth := item_imp.minimum_width
				minheight := item_imp.minimum_height
			end
			minwidth := minwidth + client_x + Border_width
			minheight := minheight + client_y + Border_width
			minwidth := minwidth.max (text_width + 2 * Text_padding)
			ev_set_minimum_size (minwidth, minheight)
		end

feature {NONE} -- WEL Implementation

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	border_width: INTEGER is
			-- Number of pixels taken up by border.
		do
			inspect frame_style
				when Ev_frame_lowered then Result := 1
				when Ev_frame_raised then Result := 1
				when Ev_frame_etched_in then Result := 2
				when Ev_frame_etched_out then Result := 2
			end
		end

	Text_padding: INTEGER is 4
			-- Number of pixels left and right of `text'.

	text_height: INTEGER
			-- Height of `text' displayed at top.

	text_width: INTEGER
			-- Width of `text' displayed at top.

	wel_font: WEL_FONT
			-- Appearance of `text'.

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
			disable_default_processing
			set_message_return_value (1)
			paint_dc.fill_rect (invalid_rect, background_brush)
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Redraw `Current' with `frame_style'.
		local
			wel_style: INTEGER
			text_pos: INTEGER
			half: INTEGER
			cur_width: INTEGER
			cur_height: INTEGER
			r: WEL_RECT
			bk_brush: WEL_BRUSH
			pen: WEL_PEN
		do
			
				-- Cache value of `ev_width' and `ev_height' for
				-- faster access
			cur_width := ev_width
			cur_height := ev_height

				-- Determine the Edge style of the frame
			inspect frame_style
				when Ev_frame_lowered then wel_style := Bdr_sunkenouter
				when Ev_frame_raised then wel_style := Bdr_raisedouter
				when Ev_frame_etched_in then wel_style := Edge_etched
				when Ev_frame_etched_out then wel_style := Edge_bump
			else
				check
					valid_value: False
				end
			end

			create r.make (0,0,0,0)
			bk_brush := background_brush

				-- Fill empty space
			if text /= Void then
				if alignment.is_left_aligned then
					text_pos := Text_padding
				elseif alignment.is_center_aligned then
					text_pos := (cur_width - text_width) // 2
				elseif alignment.is_right_aligned then
					text_pos := cur_width - text_width - Text_padding
				end

				half := text_height // 2

					-- Paint left part of text
				create r.make (0, 0, text_pos, half)
				paint_dc.fill_rect (r, bk_brush)
				r.set_rect (0, half, text_pos, cur_height)
				paint_dc.fill_rect (r, bk_brush)

					-- Paint right part of text
				r.set_rect (text_pos + text_width, 0, cur_width, half)
				paint_dc.fill_rect (r, bk_brush)
				r.set_rect (text_pos + text_width, half, cur_width, cur_height)
				paint_dc.fill_rect (r, bk_brush)

	
				if item = Void then
					r.set_rect (1, half + 1, cur_width - 1, cur_height - 1)
					paint_dc.fill_rect (r, bk_brush)
				end
			else
				if item = Void then
					r.set_rect (1, 1, cur_width - 1, cur_height - 1)
					paint_dc.fill_rect (r, bk_brush)
				end
			end

			r.set_rect (0, text_height // 2, cur_width, cur_height)

			draw_edge (
				paint_dc, 
				r,
				wel_style, 
				Bf_rect
				)

			if text /= Void and then not is_sensitive then
				r.set_rect (text_pos, 0, text_pos + text_width, text_height)
				paint_dc.fill_rect (r, bk_brush)
			end

			bk_brush.delete

			if wel_style.bit_and (Bdr_raisedouter) = Bdr_raisedouter then
					--| This is to work around a bug where the 3D highlight
					--| does not seem to appear.
				pen := highlight_pen
				paint_dc.select_pen (pen)
				paint_dc.line (
					0,         text_height // 2, 
					cur_width, text_height // 2
					)
				paint_dc.line (
					0, text_height // 2, 
					0, cur_height - 1
					)
				pen.delete
			end

			if text /= Void then
				paint_dc.select_font (wel_font)
				paint_dc.set_text_color (wel_foreground_color)
				paint_dc.set_background_color (wel_background_color)
				if is_sensitive then
					paint_dc.text_out (text_pos, 0, " " + wel_text + " ")
				else
					draw_insensitive_text (
						paint_dc,
						" " + wel_text + " ", 
						text_pos, 
						0
						)
				end
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_FRAME

end -- class EV_FRAME_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.40  2001/06/29 19:00:35  rogers
--| `on_erase_background' now fills in the `invalid_rect' with the background
--| color. Previously, we just disabled the default processing. This fixes a
--| bug where you have an item inside `Current' that does not resize to fill
--| all of `Current', the background was not updated correctly.
--|
--| Revision 1.39  2001/06/07 23:08:15  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.20.8.24  2001/01/26 23:34:25  rogers
--| Removed undefinition of on_sys_key_down as this is already done in the
--| ancestor EV_WEL_CONTROL_CONTAINER_IMP.
--|
--| Revision 1.20.8.23  2000/11/06 18:02:52  rogers
--| Undefined on_sys_key_down from wel. Version from EV_WIDGET_IMP is now used.
--|
--| Revision 1.20.8.22  2000/11/03 00:47:16  manus
--| Fixed a problem when drawing a frame in insenstive mode.
--| Fixed enable_sensitive and disable sensitive so that they trigger an invalidate message
--| so that the title is updated.
--|
--| Revision 1.20.8.21  2000/11/02 05:02:11  manus
--| Updated comment on EV_SYSTEM_PEN_IMP to show that after using one of these WEL_PEN
--| object the Vision2 implementor needs to call `delete' on them to free the allocated
--| GDI object. Updated code of classes which was not doing it.
--|
--| Revision 1.20.8.20  2000/10/31 00:31:38  rogers
--| Removed unreferenced variable from on_paint.
--|
--| Revision 1.20.8.19  2000/10/28 01:07:49  manus
--| Use `wel_font: WEL_FONT' instead of an EV_FONT object. This reduces the number of GDI objects
--| since it is not EV_FONTABLE, we can use the shared `wel_font' object from WEL_SHARED_FONTS. This
--| was not possible before because `string_size' was not defined in WEL_FONT, now it is.
--|
--| Revision 1.20.8.18  2000/10/27 02:32:23  manus
--| Use `wel_background_color' and `wel_foreground_color' to draw frame.
--|
--| Revision 1.20.8.17  2000/10/18 16:22:11  rogers
--| Compute_minimum_width, compute_minimum_size and compute_minimum_height
--| now all take into account whether the child is visible or not.
--|
--| Revision 1.20.8.16  2000/10/16 14:35:34  pichery
--| replaced `dispose' with `delete'.
--|
--| Revision 1.20.8.15  2000/10/12 15:50:25  pichery
--| Added reference tracking for GDI objects to decrease
--| the number of GDI objects alive.
--|
--| Revision 1.20.8.14  2000/09/13 16:58:50  rogers
--| Changed fixme to a comment as it is working correctly.
--|
--| Revision 1.20.8.13  2000/08/24 21:54:34  rogers
--| set_left_alignment, set_right_alignment, set_center alignment now all call
--| precursor. Added alignment.
--|
--| Revision 1.20.8.12  2000/08/11 18:56:53  rogers
--| Fixed copyright clauses. Now use ! instead of |.
--|
--| Revision 1.20.8.11  2000/08/08 03:17:18  manus
--| New resizing policy by calling `ev_' instead of `internal_', see
--|   `vision2/implementation/mswin/doc/sizing_how_to.txt'.
--| Implemented `on_erase_background' to delete the content of frame if it is empty.
--|
--| Revision 1.20.8.10  2000/07/05 01:44:18  brendel
--| Added invalidate after set_text.
--|
--| Revision 1.20.8.9  2000/06/25 18:02:51  brendel
--| Optimized to use `string_size'.
--|
--| Revision 1.20.8.8  2000/06/22 02:07:19  oconnor
--| Removed in line creations that may have caused 4.5 to choke.
--|
--| Revision 1.20.8.7  2000/06/05 21:08:04  manus
--| Updated call to `notify_parent' because it requires now an extra parameter which is
--| tells the parent which children did request the change. Usefull in case of NOTEBOOK
--| for performance reasons (See EV_NOTEBOOK_IMP log for more details)
--|
--| Revision 1.20.8.6  2000/06/02 16:19:14  rogers
--| FIxed bug in computation of minimum sizes for `Current'. The length of the
--| text was previously being used as a minimum height for `Current' where it
--| should have affected the minimam width.
--|
--| Revision 1.20.8.5  2000/05/30 22:02:26  rogers
--| Minor comment change.
--|
--| Revision 1.20.8.4  2000/05/24 23:12:22  rogers
--| Set_text now calls notify_change (2 + 1) instead of invalidate. This
--| fixes the bug that was visible in EV_TEST, with the scroll bar seemingly
--| unable to scroll to the bottom of the widgets page. Basically setting a
--| text, did not cause the frame to recompute it's dimensions previously.
--|
--| Revision 1.20.8.3  2000/05/04 18:49:11  brendel
--| Corrected misake due to overenthusiastic copying and pasting.
--|
--| Revision 1.20.8.2  2000/05/03 22:15:38  pichery
--| - Cosmetics / Optimization with local variables
--| - Replaced calls to `width' to calls to `wel_width'
--|   and same for `height'.
--|
--| Revision 1.20.8.1  2000/05/03 19:09:29  oconnor
--| mergred from HEAD
--|
--| Revision 1.35  2000/05/03 16:18:16  rogers
--| Comments, formatting.
--|
--| Revision 1.34  2000/04/28 21:03:38  brendel
--| Changed border to be of width 1 when lowered or raised.
--|
--| Revision 1.33  2000/04/28 16:32:03  brendel
--| Changed Text_padding and Border_width to nice value.
--|
--| Revision 1.32  2000/04/28 00:40:23  brendel
--| Fixed text label drawing.
--|
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
