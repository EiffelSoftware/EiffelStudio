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
				
					-- Paint under the text
				r.set_rect (text_pos, text_height, text_pos + text_width, cur_height)
				paint_dc.fill_rect (r, bk_brush)

	
				if item = Void then
					r.set_rect (1, half + 1, cur_width - 1, cur_height - 1)
					paint_dc.fill_rect (r, bk_brush)
				end
			else
				if item /= Void then
						-- If the item does not cover all of the background area then
						-- Note the 4 is due to the frame border.
					if cur_height - item.height > 4 then
						r.set_rect (1, item.height - 2, cur_width - 1, cur_height - 1)
						paint_dc.fill_rect (r, bk_brush)
					end
				else
						-- If there is no item, then we must always fill in the background.
					r.set_rect (1, half + 1, cur_width - 1, cur_height - 1)
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

