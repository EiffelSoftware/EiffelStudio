indexing
	description: "[
		Objects that permit graphical drawing operations to be performed which respect the "classic"
		style of Windows used on versions before XP. Note that the body of a number of features within this
		class are empty as there is nothing to perform for the XP specific features inherited from
		EV_THEME_DRAWER_IMP.	
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CLASSIC_THEME_DRAWER_IMP
	
inherit
	EV_THEME_DRAWER_IMP
	
	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end
		
	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

feature -- Basic operations

	open_theme_data (item: POINTER; class_name: STRING): POINTER is
			-- Open theme data for WEL_WINDOW represented by `item'
			-- with type of theme `class_name'. See "Parts and States" of MSDN
			-- for a list of valid class names.
		do
			-- Nothing to perform here as there is no theme data for the classic version.
		end
		
	close_theme_data (item: POINTER) is
			-- Close theme data for WEL_WINDOW represented by `item'.
		do
			-- Nothing to perform here as there is no theme data for the classic version.
		end
		
	get_window_theme (item: POINTER): POINTER is
			-- Retrieve a theme handle for WEL_WINDOW `item'.
		do
			-- Nothing to perform here as there is no theme data for the classic version.
		end

	draw_theme_background (theme: POINTER; a_hdc: WEL_DC; a_part_id, a_state_id: INTEGER; a_rect, a_clip_rect: WEL_RECT; background_brush: WEL_BRUSH) is
			-- Draw a background theme into `a_hdc' using `background_brush'. As this is the classic version, `theme',
			-- `a_part_id', `a_state_id' and  `a_clip_rect' are not required.
		do
			a_hdc.fill_rect (a_rect, background_brush)
		end
		
	draw_widget_background (a_widget: EV_WIDGET_IMP; a_hdc: WEL_DC; a_rect: WEL_RECT; background_brush: WEL_BRUSH) is
			-- Draw the background for `a_widget' onto `a_hdc' restricted to `a_rect' using `background_brush'.
		do
			a_hdc.fill_rect (a_rect, background_brush)
		end
		
	draw_notebook_background (notebook: EV_NOTEBOOK_IMP; a_hdc: WEL_DC; a_rect: WEL_RECT; background_brush: WEL_BRUSH) is
			-- Draw the background for `notebook' onto `a_hdc' restricted to `a_rect' using `background_brush'.
		do
			a_hdc.fill_region (notebook.background_region (a_rect), background_brush)
		end
	
	draw_theme_parent_background (wel_item: POINTER; a_hdc: WEL_DC; a_rect: WEL_RECT; background_brush: WEL_BRUSH) is
			-- For the  WEL_WINDOW represented by `wel_item', draw it's background into `a_hdc' using `a_rect' in the format
			-- supplied by `background_brush'.
		do
			if background_brush /= Void then
				a_hdc.fill_rect (a_rect, background_brush)
			end
		end
		
	draw_button_edge (memory_dc: WEL_DC; a_state_id: INTEGER; a_rect: WEL_RECT) is
			-- Draw the edge of a button into `memory_dc' using `a_state_id' to give the current
			-- button state. `a_rect' gives the boundaries of the drawing.
		do
			draw_frame (memory_dc, a_rect, a_state_id)
		end
		
	update_button_text_rect_for_state (wel_item: pointer; a_state: INTEGER; a_rect: WEL_RECT) is
			-- Update `a_rect' to reflect new position for text drawn on a button with state `a_state'.
		do
			if flag_set (a_state, feature {WEL_ODS_CONSTANTS}.Ods_selected) then
				a_rect.offset (1, 1)
			end
		end
		
	update_button_pixmap_coordinates_for_state (open_theme: POINTER; a_state: INTEGER; coordinate: EV_COORDINATE) is
			-- Update `coordinate' to reflect new coordinates for a pixmap drawn on a button with state `a_state'.
		do
			if flag_set (a_state, feature {WEL_ODS_CONSTANTS}.Ods_selected) then
				coordinate.set (coordinate.x + 1, coordinate.y + 1)
			end
		end

	draw_text (wel_item: POINTER; a_hdc: WEL_DC; a_part_id, a_state_id: INTEGER; text: STRING; dw_text_flags: INTEGER; is_sensitive: BOOLEAN; a_content_rect: WEL_RECT; foreground_color: EV_COLOR) is
			-- Draw `text' on `a_hdc' within `a_content_rect' corresponding to part `a_part_id', `a_state_id'. Respect state of `is_sensitive' and use `foreground_color'
			-- if set. Font used is that already selected into `a_hdc'.
		do
			internal_draw_text (wel_item, a_hdc, text, a_content_rect, dw_text_flags, is_sensitive, foreground_color)
		end

feature {NONE} -- implementation

	draw_frame (dc: WEL_DC; r: WEL_RECT; state: INTEGER) is
			-- Draw frame around `Current', using `r' which represents the size of `Current',
			-- into `dc'. Take `state' into acount, and draw it in, out or bolded
			-- accordingly.
		local
			color: WEL_COLOR_REF
		do
				-- If `current' is a default puch button, then it must have a bold rectangle.
				-- default push buttons are only used in dialogs.
			if flag_set (state, feature {WEL_ODS_CONSTANTS}.ods_default) then
				create color.make_rgb (0, 0, 0)
				draw_line (dc, r.left,  r.top, r.right, r.top, color)
				draw_line (dc, r.left, r.top, r.left, r.bottom, color)
				draw_line (dc, r.left, r.bottom - 1, r.right, r.bottom - 1, color)
				draw_line (dc, r.right - 1, r.top, r.right - 1, r.bottom, color)
				r.inflate (-1, -1)
			end
				-- If the button is out then display it accordingly. The further check
				-- is used for handling toggle buttons.
			if flag_set (state, feature {WEL_ODS_CONSTANTS}.Ods_grayed) or not flag_set (state, feature {WEL_ODS_CONSTANTS}.Ods_selected) then
				color := Rhighlight
				draw_line (dc, r.left, r.top, r.right, r.top, color)
				draw_line (dc, r.left, r.top,r.left,  r.bottom, color)
				color := rdark_shadow
				draw_line (dc, r.left, r.bottom - 1, r.right, r.bottom - 1, color)
				draw_line (dc, r.right - 1, r.top, r.right - 1, r.bottom, color)
				r.Inflate(-1, -1)
				color := rlight
				draw_line (dc, r.left, r.top, r.right, r.top, color)
				draw_line (dc, r.left, r.top, r.left, r.bottom, color)
				color := rshadow
				draw_line (dc, r.left, r.bottom - 1, r.right, r.bottom - 1, color)
				draw_line (dc, r.right - 1, r.top, r.right - 1, r.bottom, color)
			end
			
				-- If the button is in, then draw the appropriate border.
	  		if flag_set (state, feature {WEL_ODS_CONSTANTS}.Ods_selected) then
	  			color := rdark_shadow
				draw_line (dc, r.left, r.top, r.right, r.top, color)
				draw_line (dc, r.left, r.top, r.left, r.bottom, color)
				color := Rhighlight
				draw_line (dc, r.left, r.bottom - 1, r.right, r.bottom - 1, color)
				draw_line (dc, r.right - 1, r.top, r.right - 1, r.bottom, color)
				r.Inflate(-1, -1)
				color := rshadow;
				draw_line (dc, r.left,  r.top, r.right - 1, r.top, color)
				draw_line (dc, r.left,  r.top, r.left,  r.bottom - 1, color)
			end
		end
		
	draw_line (dc: WEL_DC; sx, sy, ex, ey: INTEGER; color_ref: WEL_COLOR_REF) is
			-- Draw a line on `dc' in color `color_ref', from `sx', `sy' to
			-- `ex', `ey'.
		local
			pen: WEL_PEN
		do
			create pen.make_solid (1, color_ref)
			dc.select_pen (pen)
			dc.line (sx, sy, ex, ey)
			dc.unselect_pen
			pen.dispose
		end

end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
