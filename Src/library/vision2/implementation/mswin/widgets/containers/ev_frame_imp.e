indexing
	description:
		"Eiffel Vision frame. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		undefine
			on_wm_dropfiles
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
			disable_sensitive,
			initialize,
			on_size
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			set_font
		end

	EV_TEXT_ALIGNABLE_IMP
		undefine
			set_default_minimum_size
		redefine
			interface,
			set_text,
			align_text_center,
			align_text_right,
			align_text_left
		end

	EV_SYSTEM_PEN_IMP
		export
			{NONE} all
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make,
			set_font as wel_set_font,
			font as wel_font
		redefine
			on_paint,
			top_level_window_imp,
			on_erase_background,
			on_wm_theme_changed
		end

	WEL_DRAWING_ROUTINES
		export
			{NONE} all
		end

	WEL_THEME_PART_CONSTANTS
		export
			{NONE} all
		end

	WEL_THEME_GBS_CONSTANTS
		export
			{NONE} all
		end

	WEL_SHARED_METRICS
		export
			{NONE} all
		end

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
			text_alignment := default_alignment
				-- Retrieve the theme for the frame (which is a special type of button).
			open_theme := application_imp.theme_drawer.open_theme_data (wel_item, "Button")
		end

	initialize is
			-- Initialize `Current'.
		do
			set_default_font
			Precursor {EV_SINGLE_CHILD_CONTAINER_IMP}
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

	set_font (ft: EV_FONT) is
			-- Make `ft' new font of `Current'.
		do
			Precursor {EV_FONTABLE_IMP} (ft)
			update_text_size
			notify_change (nc_minsize, Current)
			invalidate
		end

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

	set_text (a_text: STRING_GENERAL) is
			-- Assign `a_text' to `text'.
		do
			if a_text.is_empty then
				text_width := 0
				text_height := 0
				Precursor {EV_TEXT_ALIGNABLE_IMP} (a_text)
			else
				Precursor {EV_TEXT_ALIGNABLE_IMP} (a_text)
				update_text_size
			end
			notify_change (nc_minsize, Current)
			invalidate
		end

	update_text_size is
			-- Update `text_width' and `text_size' based on
			-- current font.
		local
			font_imp: EV_FONT_IMP
			t: TUPLE [INTEGER, INTEGER]
			l_text: like text
		do
			l_text := text
				-- Add a space before and after `l_text'.
				-- Adding it dynamically inline will result in a STRING_8 object being created.
			l_text.prepend (" ")
			l_text.append (" ")
				-- `l_text' is a copy of `text'.
			if private_font /= Void then
				font_imp ?= private_font.implementation
				check
					font_not_void: font_imp /= Void
				end
				t := font_imp.string_size (l_text)
			else
				t := private_wel_font.string_size (l_text)
			end
			text_width := t.integer_item (1)
			text_height := t.integer_item (2)
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
			Precursor {EV_TEXT_ALIGNABLE_IMP}
			invalidate
		end

	align_text_left is
			-- Display `text' left aligned.
		do
			Precursor {EV_TEXT_ALIGNABLE_IMP}
			invalidate
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			Precursor {EV_TEXT_ALIGNABLE_IMP}
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

	Text_padding: INTEGER is 7
			-- Number of pixels left and right of `text'.

	text_height: INTEGER
			-- Height of `text' displayed at top.

	text_width: INTEGER
			-- Width of `text' displayed at top.

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
			disable_default_processing
			set_message_return_value (to_lresult (1))
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Redraw `Current' with `frame_style'.
		local
			wel_style: INTEGER
			text_pos: INTEGER
			cur_width: INTEGER
			cur_height: INTEGER
			r: WEL_RECT
			bk_brush: WEL_BRUSH
			pen: WEL_PEN
			font_imp: EV_FONT_IMP
			theme_drawer: EV_THEME_DRAWER_IMP
			text_rect: WEL_RECT
			drawstate: INTEGER
			memory_dc: WEL_DC
			wel_bitmap: WEL_BITMAP
			color_imp: EV_COLOR_IMP
			l_is_remote: BOOLEAN
		do
			l_is_remote := metrics.is_remote_session
			theme_drawer := application_imp.theme_drawer

			if l_is_remote then
				memory_dc := paint_dc
			else
				create {WEL_MEMORY_DC} memory_dc.make_by_dc (paint_dc)
				create wel_bitmap.make_compatible (paint_dc, width, height)
				memory_dc.select_bitmap (wel_bitmap)
				wel_bitmap.dispose
			end

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

			theme_drawer.draw_widget_background (Current, memory_dc, invalid_rect, bk_brush)

			if alignment = {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left then
				text_pos := Text_padding
			elseif alignment = {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center then
				text_pos := (cur_width - text_width) // 2
			elseif alignment = {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right then
				text_pos := cur_width - text_width - Text_padding
			end

			r.set_rect (0, text_height // 2, cur_width, cur_height)

			if is_sensitive then
				drawstate := gbs_normal
			else
				drawstate := gbs_disabled
			end
				-- GBS_normal
			if wel_style = edge_etched and application_imp.themes_active then
					-- We only use the theme drawer it `edge_etched' is used which is the default.
					-- The other styles have no equivalent representation in themes and must simply be
					-- drawn as before.
				theme_drawer.draw_theme_background (open_theme, memory_dc, bp_groupbox, drawstate, r, Void, bk_brush)
			else
				draw_edge (memory_dc, r, wel_style, Bf_rect)

				if (wel_style & Bdr_raisedouter) = Bdr_raisedouter then
						--| This is to work around a bug where the 3D highlight
						--| does not seem to appear.
					pen := highlight_pen
					memory_dc.select_pen (pen)
					memory_dc.line (
						0,         text_height // 2,
						cur_width, text_height // 2
						)
					memory_dc.line (
						0, text_height // 2,
						0, cur_height - 1
						)
					memory_dc.unselect_pen
					pen.delete
				end
			end

			r.set_rect (text_pos, 0, text_pos + text_width, text_height)
			theme_drawer.draw_widget_background (Current, memory_dc, r, bk_brush)

			bk_brush.delete

			if not text.is_empty then
				if private_font /= Void then
					font_imp ?= private_font.implementation
					check
						font_not_void: font_imp /= Void
					end
					memory_dc.select_font (font_imp.wel_font)
				else
					memory_dc.select_font (private_wel_font)
				end
				memory_dc.set_text_color (wel_foreground_color)
				memory_dc.set_background_color (wel_background_color)

				create text_rect.make (text_pos, 0, text_pos + text_width, text_height)
				if foreground_color_imp /= Void then
					color_imp := foreground_color_imp
				else
					color_imp ?= (create {EV_STOCK_COLORS}).default_foreground_color.implementation
				end
				theme_drawer.draw_text (open_theme, memory_dc, bp_groupbox, gbs_disabled, text, dt_center, is_sensitive, text_rect, color_imp)
			end
			if not l_is_remote then
				paint_dc.bit_blt (invalid_rect.left, invalid_rect.top,
					invalid_rect.width, invalid_rect.height,
					memory_dc, invalid_rect.left, invalid_rect.top, {WEL_RASTER_OPERATIONS_CONSTANTS}.Srccopy)
			end
			memory_dc.unselect_all
			memory_dc.delete
			disable_default_processing
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Called when `Current' is resized.
		do
			Precursor {EV_SINGLE_CHILD_CONTAINER_IMP} (size_type, a_width, a_height)
				-- Force a redraw so that the control gets updated correctly.
			invalidate_without_background
		end

	on_wm_theme_changed is
			-- `Wm_themechanged' message received by Windows so update current theming.
		do
			application_imp.theme_drawer.close_theme_data (open_theme)
			application_imp.update_theme_drawer
			open_theme := application_imp.theme_drawer.open_theme_data (wel_item, "Button")
		end

	open_theme: POINTER
		-- Theme currently open for `Current'. May be Void while running on Windows versions that
		-- do no support theming.

feature {EV_ANY_I} -- Implementation

	interface: EV_FRAME;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_FRAME_IMP

