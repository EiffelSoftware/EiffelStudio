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
			interface
		end

	EV_TEXTABLE_IMP
		undefine
			set_default_minimum_size
		redefine
			interface,
			set_text,
			remove_text
		end

	EV_SYSTEM_PEN_IMP

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make
		redefine
			on_paint,
			top_level_window_imp,
			wel_move_and_resize
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
			create alignment
			create font
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
			Result := (wel_width - client_x - Border_width).max (0)
		end
	
	client_height: INTEGER is
			-- Height of the client area.
		do
			Result := (height - client_y - Border_width).max (0)
		end

feature -- Element change

	set_frame_style (a_style: INTEGER) is
			-- Assign `a_style' to `frame_style'.
		do
			frame_style := a_style
			invalidate
		end

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		local
			font_imp: EV_FONT_IMP
			t: TUPLE [INTEGER, INTEGER]
		do
			font_imp ?= font.implementation
			check
				font_imp_not_void: font_imp /= Void
			end
			t := font_imp.string_width_and_height (" " + a_text + " ")
			text_width := t.integer_item (1)
			text_height := t.integer_item (2)
			Precursor (a_text)
			notify_change (2 + 1, Current)
		end

	remove_text is
			-- Make `text' `Void'.
		do
			text_width := 0
			text_height := 0
			Precursor
			invalidate
		end

feature -- Status setting

	set_default_minimum_size is
			-- Initialize the size of `Current'.
		do
			internal_set_minimum_size (2 * Text_padding, 2 * Border_width)
		end

	align_text_center is
			-- Display `text' centered.
		do
			alignment.set_center_alignment
			invalidate
		end

	align_text_left is
			-- Display `text' left aligned.
		do
			alignment.set_left_alignment
			invalidate
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			alignment.set_right_alignment
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
			if item /= Void then
				minwidth := item_imp.minimum_width
			end
			minwidth := minwidth + client_x + Border_width
			minwidth := minwidth.max (text_width + 2 * Text_padding)
			internal_set_minimum_width (minwidth)
		end

	compute_minimum_height is
			-- Recompute the minimum_height of `Current'.
		local
			minheight: INTEGER
		do
			if item /= Void then
				minheight := item_imp.minimum_height
			end
			minheight := minheight + client_y + Border_width
			internal_set_minimum_height (minheight)
		end

	compute_minimum_size is
			-- Recompute both the minimum_width and then
			-- minimum_height of `Current'.
		local
			minheight, minwidth: INTEGER
		do
			if item /= Void then
				minwidth := item_imp.minimum_width
				minheight := item_imp.minimum_height
			end
			minwidth := minwidth + client_x + Border_width
			minheight := minheight + client_y + Border_width
			minwidth := minwidth.max (text_width + 2 * Text_padding)
			internal_set_minimum_size (minwidth, minheight)
		end

feature {NONE} -- WEL Implementation

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	wel_move_and_resize (a_x, a_y, a_width, a_height: INTEGER;
		repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		do
			{EV_WEL_CONTROL_CONTAINER_IMP} Precursor (a_x, a_y, a_width,
				a_height, repaint)
			if item_imp /= Void then
				item_imp.set_move_and_size (client_x, client_y,
					client_width, client_height)
			end
		end

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

	alignment: EV_TEXT_ALIGNMENT
			-- Placement of `text'.

	font: EV_FONT
			-- Appearance of `text'.

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Redraw `Current' with `frame_style'.
		local
			wel_style: INTEGER
			text_pos: INTEGER
			font_imp: EV_FONT_IMP
			cur_width: INTEGER
			cur_height: INTEGER
		do
				-- Cache value of `wel_width' and `wel_height' for
				-- faster access
			cur_width := wel_width
			cur_height := wel_height

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

				-- Draw the Edge
			draw_edge (
				paint_dc, 
				create {WEL_RECT}.make (
					0, 
					text_height // 2, 
					cur_width, 
					cur_height
					),
				wel_style, 
				Bf_rect
				)

			if wel_style.bit_and (Bdr_raisedouter) = Bdr_raisedouter then
				--| FIXME This is to work around a bug where the 3D highlight
				--| does not seem to appear.
				paint_dc.select_pen (highlight_pen)
				paint_dc.line (
					0,         text_height // 2, 
					cur_width, text_height // 2
					)
				paint_dc.line (
					0, text_height // 2, 
					0, cur_height - 1
					)
			end

			if text /= Void then
				if alignment.is_left_aligned then
					text_pos := Text_padding
				elseif alignment.is_center_aligned then
					text_pos := (cur_width - text_width) // 2
				elseif alignment.is_right_aligned then
					text_pos := cur_width - text_width - Text_padding
				end
				font_imp ?= font.implementation
				check
					font_imp_not_void: font_imp /= Void
				end
				paint_dc.select_font (font_imp.wel_font)
				paint_dc.set_text_color (foreground_color_imp)
				paint_dc.set_background_color (background_color_imp)
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

--|-----------------------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.38  2000/06/09 01:23:20  manus
--| Merged version 1.20.8.7 from DEVEL branch to trunc
--|
--| Revision 1.37  2000/06/08 18:46:48  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.36  2000/06/07 17:27:59  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
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
