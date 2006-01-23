indexing
	description: "[
		Objects that permit graphical drawing operations to be performed which respect the
		theming state of Windows XP.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_XP_THEME_DRAWER_IMP
	
inherit
	EV_THEME_DRAWER_IMP
	
	WEL_THEME_PART_CONSTANTS
		export
			{NONE} all
		end

feature -- Basic operations

	open_theme_data (item: POINTER; a_class_name: STRING): POINTER is
			-- Open theme data for WEL_WINDOW represented by `item'
			-- with type of theme `class_name'. See "Parts and States" of MSDN
			-- for a list of valid class names.
		do
			Result := cwin_open_theme_data (item, unicode_string (a_class_name).item)
		end
		
	close_theme_data (item: POINTER) is
			-- Close theme data for WEL_WINDOW represented by `item'.
		do
			cwin_close_theme_data (item)
		end

	get_window_theme (item: POINTER): POINTER is
			-- Retrieve a theme handle for WEL_WINDOW `item'.
		do
			Result := cwin_get_window_theme (item)
		end

	draw_theme_background (theme: POINTER; a_hdc: WEL_DC; a_part_id, a_state_id: INTEGER; a_rect, a_clip_rect: WEL_RECT; background_brush: WEL_BRUSH) is
			-- Draw a background theme using `theme' into `a_hdc'. `a_part_id' represents the part type to draw and `a_state_id' represents
			-- the item state. Drawing is performed into `a_rect' and clipped to `a_clip_rect'. `background_brush' is not used for this themed version.
		require else
			theme_exists: theme /= default_pointer
		do
			if a_clip_rect /= Void then
				cwin_draw_theme_background (theme, a_hdc.item, a_part_id, a_state_id, a_rect.item, a_clip_rect.item)
			else
				cwin_draw_theme_background (theme, a_hdc.item, a_part_id, a_state_id, a_rect.item, default_pointer)
			end
		end
		
	get_notebook_parent (a_widget: EV_WIDGET_IMP): EV_NOTEBOOK_IMP is
			-- Return the first notebook parent of `Current' in the widget structure
			-- unless a widget with a background color or a container with a background pixmap
			-- is found.
		require
			a_widget_not_void: a_widget /= Void
		local
			l_parent: EV_CONTAINER_IMP
			colored_container_found: BOOLEAN
		do
			if a_widget.background_color_imp = Void then
				l_parent ?= a_widget
				if l_parent = Void or l_parent /= Void and then l_parent.background_pixmap_imp = Void then
					from
						l_parent := a_widget.parent_imp
					until
						l_parent = Void or Result /= Void or colored_container_found
					loop
						Result ?= l_parent
						if Result = Void and (l_parent.background_color_imp /= Void or l_parent.background_pixmap_imp /= Void) then
							colored_container_found := True
						end
						l_parent := l_parent.parent_imp
					end
				end
			end
		end
		
	draw_widget_background (a_widget: EV_WIDGET_IMP; a_hdc: WEL_DC; a_rect: WEL_RECT; background_brush: WEL_BRUSH) is
			-- Draw the background for `a_widget' onto `a_hdc' restricted to `a_rect'. If `a_widget' is contained at some level within
			-- a notebook then apply the theming of the notebook background to `a_widget', otherwise draw the background using `background_brush'.
			-- The theming is ignored if `a_widget' has had a background color specifically set or if one of the containers `a_widget' is contained in
			-- between itself and the notebook have a background color specifically set.
		local
			notebook_parent: EV_NOTEBOOK_IMP
			l_rect: WEL_RECT
			container_widget: EV_CONTAINER_IMP
		do
			notebook_parent ?= get_notebook_parent (a_widget)
			if notebook_parent = Void then
				container_widget ?= a_widget
				if container_widget /= Void and then container_widget.background_pixmap_imp /= Void then
					a_hdc.fill_rect (a_rect, background_brush)
				else
					a_hdc.fill_rect (a_rect, background_brush)
				end
			else
					-- The rect is made with the correct offset from `a_widget' to `notebook_parent' so that the
					-- texture of the theming can be applied correctly. This ensures that the background is seamless with the notebook.
				create l_rect.make (
					notebook_parent.absolute_x - a_widget.absolute_x,
					notebook_parent.absolute_y - a_widget.absolute_y,
					notebook_parent.width + notebook_parent.absolute_x - a_widget.absolute_x ,
					notebook_parent.height + notebook_parent.absolute_y - a_widget.absolute_y)
				draw_theme_background (notebook_parent.open_theme, a_hdc, tabp_body, 0, l_rect, a_rect, background_brush)			
			end
		end
		
	draw_notebook_background (notebook: EV_NOTEBOOK_IMP; a_hdc: WEL_DC; a_rect: WEL_RECT; background_brush: WEL_BRUSH) is
			-- Draw the background of `notebook'. Does nothing as on XP, the background is drawn automatically.
		do
			-- Does nothing on Windows XP as with styles enabled it appears that the background of a notebook is
			-- automatically drawn correctly. This does not happen with the classic look and feel.
		end
		
	draw_theme_parent_background (wel_item: POINTER; a_hdc: WEL_DC; a_rect: WEL_RECT; background_brush: WEL_BRUSH) is
			-- For the  WEL_WINDOW represented by `wel_item', copy the background of it's parent into `a_hdc' bounded by
			-- `a_rect'. `background_brush' is not used. Warning. If this is used recursively in nested widget structures,
			-- it appears to slow things down a great deal.
		do
				-- Need to first clear the area to the background color of `parent_imp'
			cwin_draw_theme_parent_background (wel_item, a_hdc.item, a_rect.item)
		end
		
	draw_button_edge (memory_dc: WEL_DC; a_state_id: INTEGER; a_rect: WEL_RECT) is
			-- Draw the edge of a button into `memory_dc' using `a_state_id' to give the current
			-- button state. `a_rect' gives the boundaries of the drawing.
		do
			-- Nothing to do here as themed buttons automatically draw their frame as part of the background.
		end
		
	update_button_text_rect_for_state (wel_item: pointer; a_state_is: INTEGER; a_rect: WEL_RECT) is
			-- Update `a_rect' to reflect new position for text drawn on a button with state `a_state'.
		do
			-- Nothing to do here as themed buttons do not offset their text when pressed as per classic buttons.
		end
		
	update_button_pixmap_coordinates_for_state (open_theme: POINTER; a_state: INTEGER; coordinate: EV_COORDINATE) is
			-- Update `coordinate' to reflect new coordinates for a pixmap drawn on a button with state `a_state'.
		do
			-- Nothing to do here as themed buttons do not offset their text when pressed as per classic buttons.
		end
		
	draw_text (theme: POINTER; a_hdc: WEL_DC; a_part_id, a_state_id: INTEGER; text: STRING; dw_text_flags: INTEGER; is_sensitive: BOOLEAN; a_content_rect: WEL_RECT; foreground_color: EV_COLOR_IMP) is
			-- Draw `text' using theme `theme' on `a_hdc' within `a_content_rect' corresponding to part `a_part_id', `a_state_id'. Respect state of `is_sensitive'
		local
			wel_string: WEL_STRING
		do
			wel_string := unicode_string (text)
				-- We must check that a color has not been set. If one has, then the classic drawing routine must
				-- be called to override the theme drawing color.
			if foreground_color.interface.is_equal ((create {EV_STOCK_COLORS}).default_foreground_color) then
				if is_sensitive then
					cwin_draw_theme_text (theme, a_hdc.item, a_part_id, a_state_id, wel_string.item, text.count, dw_text_flags, 0, a_content_rect.item)
				else
					cwin_draw_theme_text (theme, a_hdc.item, a_part_id, a_state_id, wel_string.item, text.count, dw_text_flags, cwin_dtt_grayed, a_content_rect.item)
				end
			else
				classic_drawer.draw_text (theme, a_hdc, a_part_id, a_state_id, text, dw_text_flags, is_sensitive, a_content_rect, foreground_color)
			end
		end

feature {NONE} -- Implementation

	classic_drawer: EV_CLASSIC_THEME_DRAWER_IMP is
			-- Once access to the classic drawer for use in situations where
			-- `Current' determines that it must use the classic implementation
			-- as a property is set which overrides the theme drawer.
		once
			create Result
		end
	
	unicode_string (string: STRING): WEL_STRING is
			-- Convert `string' into a unicode string,
		require
			string_not_void: string /= Void
		local
			l_string: STRING
			counter: INTEGER
		do
			create l_string.make_empty
			from
				counter := 1
			until
				counter > string.count
			loop
				l_string.append_character (string.item (counter))
				l_string.append_character ('%U')
				counter := counter + 1
			end
			l_string.append_character ('%U')
			create Result.make (l_string)
		ensure
			result_not_void: Result /= Void
		end

	cwin_open_theme_data (a_item, a_class_name: POINTER): POINTER is
			-- SDK's OpenThemeData
		external
			"dllwin %"uxtheme.dll%" signature (HWND, LPCWSTR): EIF_POINTER use <windows.h>"
		alias
			"OpenThemeData"
		end
		
	cwin_close_theme_data (a_item: POINTER) is
			-- SDK's CloseThemeData
		external
			"dllwin %"uxtheme.dll%" signature (HWND) use <windows.h>"
		alias
			"CloseThemeData"
		end
		
	cwin_draw_theme_parent_background (hwnd, a_hdc: POINTER; a_content_rect: POINTER) is
			-- SDK's DrawThemeText
		external
			"dllwin %"uxtheme.dll%" signature (HWND, HDC, RECT *) use <windows.h>"
		alias
			"DrawThemeParentBackground"
		end	

	cwin_draw_theme_background (a_theme, a_hdc: POINTER; a_part_id, a_state_id: INTEGER; a_rect, a_clip_rect: POINTER) is
			-- SDK's DrawThemeBackground
		external
			"dllwin %"uxtheme.dll%" signature (EIF_POINTER, HDC, int, int, RECT *, RECT *) use <windows.h>"
		alias
			"DrawThemeBackground"
		end
		
	cwin_draw_theme_text (a_theme, a_hdc: POINTER; a_part_id, a_state_id: INTEGER; psz_text: POINTER; i_char_count, dw_text_flags, dw_text_flags2: INTEGER; a_content_rect: POINTER) is
			-- SDK's DrawThemeText
		external
			"dllwin %"uxtheme.dll%" signature (EIF_POINTER, HDC, int, int, LPCWSTR, int, DWORD, DWORD, RECT *) use <windows.h>"
		alias
			"DrawThemeText"
		end

	cwin_draw_theme_edge (a_theme, a_hdc: POINTER; a_part_id, a_state_id: INTEGER; a_rect: POINTER; a_edge, a_flags: INTEGER; a_content_rect: POINTER) is
			-- SDK's DrawThemeBackground
		external
			"dllwin %"uxtheme.dll%" signature (EIF_POINTER, HDC, int, int, RECT *, UINT, UINT, RECT *) use <windows.h>"
		alias
			"DrawThemeEdge"
		end

	cwin_get_window_theme (hwnd: POINTER): POINTER is
			-- SDK's GetWindowTheme
		external
			"dllwin %"uxtheme.dll%" signature (EIF_POINTER): EIF_POINTER use <windows.h>"
		alias
			"GetWindowTheme"
		end

	cwin_dtt_grayed: INTEGER is 1;
			-- SDK's DTT_GRAYED

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




end

