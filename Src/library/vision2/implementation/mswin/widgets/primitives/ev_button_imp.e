indexing
	description: "EiffelVision push button. Mswindows implementation."
	status: "See notice at end of class"
	note: "On windows, you can only display a text or a pixmap.%N%
	%if you set both the pixmap and the text, only the%N%
	%pixmap will be displayed. On gtk, everything works%N%
	%like it is suppose to be, you have both text and%N%
	%pixmap visible."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_BUTTON_IMP

inherit
	EV_BUTTON_I
		redefine
			interface
		select
			interface
		end

	EV_PRIMITIVE_IMP
		undefine
			set_default_minimum_size
		redefine
			on_key_down,
			initialize,
			interface,
			redraw_current_push_button,
			update_current_push_button
		end
   
	EV_TEXT_ALIGNABLE_IMP
		redefine
			set_default_minimum_size,
			align_text_center,
			align_text_left,
			align_text_right,
			interface
		end

	EV_PIXMAPABLE_IMP
		redefine
			set_pixmap,
			remove_pixmap,
			interface
		end
		
	EV_FONTABLE_IMP
		rename
			interface as ev_fontable_interface
		redefine
			set_font
		end

	WEL_BS_CONSTANTS
		export
			{NONE} all
		end

	WEL_BM_CONSTANTS
		export
			{NONE} all
		end
		
	WEL_DRAWING_ROUTINES

	WEL_BITMAP_BUTTON
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			item as wel_item,
			enabled as is_sensitive,
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			text as wel_text,
			set_text as wel_set_text,
			font as wel_font,
			set_font as wel_set_font,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			has_capture as wel_has_capture
		undefine
			set_width,
			set_height,
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_set_focus,
			on_desactivate,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_char,
			on_set_cursor,
			on_size,
			show,
			hide,
			x_position,
			y_position,
			wel_background_color,
			wel_foreground_color,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message
		redefine
			default_style,
			on_bn_clicked,
			wel_set_text,
			process_message,
			on_erase_background
		end

	EV_BUTTON_ACTION_SEQUENCES_IMP
	
creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make (default_parent, "", 0, 0, 0, 0, 0)
			extra_width := 20
			text_alignment := default_alignment
		end

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_PRIMITIVE_IMP}
			set_default_font
		end

feature -- Access

	extra_width: INTEGER
			-- Extra width on the size.

	is_default_push_button: BOOLEAN
			-- Is this button currently a default push button 
			-- for a particular container?

feature -- Status setting

	set_default_minimum_size is
			-- Reset `Current' to its default minimum size.
		local
			font_imp: EV_FONT_IMP
			w,h: INTEGER
		do
			if not text.is_empty then
				if private_font /= Void then
					font_imp ?= private_font.implementation
					check
						font_not_void: font_imp /= Void
					end
					w := extra_width + font_imp.string_width (wel_text)
					h := h.max (19 * font_imp.height // 9)
				else
					w := extra_width + private_wel_font.string_width (wel_text)
					h := h.max (19 * private_wel_font.height // 9)
				end
			end
			
			
			if pixmap_imp /= Void then
				if text.is_empty then
					w := internal_pixmap.width + pixmap_border * 2
				else
					w := w + internal_pixmap.width + pixmap_border
				end
				h := h.max (internal_pixmap.height + pixmap_border * 2)
			end
			if text.is_empty and pixmap_imp = Void then
				w := w + extra_width
				h := h + internal_default_height
			end

				-- Finaly, we set the minimum values.
			ev_set_minimum_size (w, h)
		end

	align_text_left is
			-- Display `text' with alignment to left of `Current'.
		local
			new_style: INTEGER
		do
			new_style := clear_flag (style, Bs_center)
			new_style := clear_flag (new_style, Bs_right)
			new_style := set_flag (new_style, Bs_left)
			set_style (new_style)

			text_alignment := feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_Text_alignment_left
			invalidate
		end

	align_text_right is
			-- Display `text' with alignment to right of `Current'.
		local
			new_style: INTEGER
		do
			new_style := clear_flag (style, Bs_center)
			new_style := clear_flag (new_style, Bs_left)
			new_style := set_flag (new_style, Bs_right)
			set_style (new_style)

			text_alignment := feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_Text_alignment_right
			invalidate
		end

	align_text_center is
			-- -- Display `text' with alignment in center of `Current'.
		local
			new_style: INTEGER
		do
			new_style := clear_flag (style, Bs_right)
			new_style := clear_flag (new_style, Bs_left)
			new_style := set_flag (new_style, Bs_center)
			set_style (new_style)

			text_alignment := feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_Text_alignment_center
			invalidate
		end

	enable_default_push_button is
			-- Set the style "default_push_button" of `Current'.
		do
		--	put_bold_border
			is_default_push_button := True
		end

	disable_default_push_button is
			-- Remove the style "default_push_button"  of `Current'. 
		do
		--	remove_bold_border
			is_default_push_button := False
		end

	enable_can_default is
			--| Implementation only needed for GTK
		do
			--| Do nothing as this is the default on Win32.
		end

feature -- Element change

	set_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the pixmap of `Current'.
		local
			wel_icon: WEL_ICON
			a_wel_bitmap: WEL_BITMAP
			internal_pixmap_state: EV_PIXMAP_IMP_STATE
			font_imp: EV_FONT_IMP
			size_difference: INTEGER
		do
			Precursor {EV_PIXMAPABLE_IMP} (pix)
			
			internal_pixmap := clone (pix)
			if not text.is_empty then
				if private_font /= Void then

				font_imp ?= private_font.implementation
					check
						font_not_void: font_imp /= Void
					end
					size_difference := font_imp.string_width (wel_text)
				else
					size_difference := private_wel_font.string_width (wel_text)
				end
			end
			
			internal_pixmap_state ?= internal_pixmap.implementation
			wel_icon := internal_pixmap_state.icon
			if wel_icon /= Void then
				set_icon (internal_pixmap_state.icon)
			else
				a_wel_bitmap := internal_pixmap_state.get_bitmap
				set_bitmap (a_wel_bitmap)
				a_wel_bitmap.decrement_reference
			end
			set_default_minimum_size
		end
	
	set_font (ft: EV_FONT) is
			-- Make `ft' new font of `Current'.
		do
			Precursor {EV_FONTABLE_IMP} (ft)
			set_default_minimum_size
		end

	internal_pixmap: EV_PIXMAP

	remove_pixmap is
			-- Remove `pixmap' from `Current'.
		do
			Precursor {EV_PIXMAPABLE_IMP}
			unset_bitmap
			set_default_minimum_size
				-- Why was this not done before?
			internal_pixmap := Void
			invalidate
		end

	wel_set_text (txt: STRING) is
			-- Assign `txt' to `text' of `Current'.
		do
			Precursor {WEL_BITMAP_BUTTON} (txt)
			set_default_minimum_size
		end

feature {NONE} -- Implementation, focus event

	internal_default_height: INTEGER is
			-- The default minimum height of `Current' with no text.
		do
			Result := 7
		end

	update_current_push_button is
			-- Update the current push button
			--
			-- Current is a push button, so we set it to be
			-- the current push button.
		local
			top_level_dialog_imp: EV_DIALOG_I
		do
			top_level_dialog_imp ?= application_imp.window_with_focus
			if top_level_dialog_imp /= Void then
				top_level_dialog_imp.set_current_push_button (interface)
			else
				is_default_push_button := False
			end
		end
		
feature {EV_ANY_I} -- Implementation

	redraw_current_push_button (focused_button: EV_BUTTON) is
			-- Put a bold border on the default push button
		do
			if focused_button = Void or else 
				focused_button.implementation /= Current
			then
					-- Current is not the `focused_button' or there
					-- is focused button at all. In all case, we should
					-- remove our bold border.
				is_default_push_button := False
				invalidate
			else
					-- Current is the `focused_button' draw the
					-- bold border.
				is_default_push_button := True
				invalidate
			end
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- Default style used to create `Current'.
		do
			Result := ws_visible + ws_child + ws_group + ws_tabstop + Ws_clipchildren + Ws_clipsiblings + Bs_ownerdraw
		end

	on_bn_clicked is
			-- `Current' has been pressed.
		do
			if select_actions_internal /= Void then
				select_actions_internal.call ([])
			end
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed.
		local
			a_dialog_imp: EV_DIALOG_IMP
		do
				-- Process Enter and Escape Key to process Default
				-- push button and default cancel button
			if virtual_key = Vk_escape or virtual_key = Vk_return then
				a_dialog_imp ?= top_level_window_imp
				if a_dialog_imp /= Void then
					a_dialog_imp.on_dialog_key_down (virtual_key)
				end
			end
				
			process_tab_key (virtual_key)
			Precursor {EV_PRIMITIVE_IMP} (virtual_key, key_data)
		end

	process_message (hwnd: POINTER; msg: INTEGER; wparam: INTEGER; lparam: INTEGER): INTEGER is
			-- Process all message plus `WM_GETDLGCODE'.
		do
			if msg = Wm_getdlgcode then
					--| We prevent here Windows to redraw the default push button by itself
					--| as we do the redrawing by ourselves.
				Result := 0
				set_default_processing (False)
			else
				Result := Precursor (hwnd, msg, wparam, lparam)
			end
		end

feature {EV_ANY_I} -- Drawing implementation

	button_in: INTEGER is
			-- `Result' is code used to determine if button is in.
			-- Ods constants do not seem to
			-- match up well. See MSDN DRAWITEMSTRUCT for
			-- more information regarding the allowable states.
		once
			Result := feature {WEL_ODS_CONSTANTS}.Ods_selected -- 1
		end
		
	button_out: INTEGER is
			-- Result is code used to determine if button is out.
		once
			Result := feature {WEL_ODS_CONSTANTS}.Ods_grayed -- 2
		end
		
	has_pushed_appearence (state: INTEGER): BOOLEAN is
			-- Should `Current' have the appearence of being
			-- pressed?
		do
			Result := flag_set (state, feature {WEL_ODS_CONSTANTS}.Ods_selected)			
		end
		
	pixmap_border: INTEGER is 4
		-- spacing between image and edge of `Current'.
		
	focus_rect_border: INTEGER is 3
		-- Distance of focus rectangle from edge of button.

	internal_background_brush: WEL_BRUSH is
			-- `Result' is 
		local
			color_imp: EV_COLOR_IMP
		do
			color_imp ?= background_color.implementation
			create Result.make_solid (color_imp)
		end
		
	on_draw_item (draw_item: WEL_DRAW_ITEM_STRUCT) is
			-- Wm_drawitem message received. We must now draw `Current'
			-- ourselves with the information in `draw_item'.
		local
			dc: WEL_CLIENT_DC
				-- Temporary dc for quicker access to that of `draw_item'.
			text_rect: WEL_RECT
				-- Rect used to draw the text of `Current'.
			internal_pixmap_state: EV_PIXMAP_IMP_STATE
				-- Pixmap state used to retrieve information about the pixmap of `Current', Void
				-- if there is no pixmap.
			wel_bitmap: WEL_BITMAP
				-- Bitmap used to draw `internal_pixmap_state' on `Current' if it is not Void.
			rect: WEL_RECT
				-- Rect of `Current' retrieved from `draw_item'.
			focus_rect: WEL_RECT
				-- Rect used to draw focus rect. Is `rect' inflated negatively, using `focus_rect_border'.
			state: INTEGER
				-- State of `Current' as retrieved from `draw_item'.
			memory_dc: WEL_MEMORY_DC
				-- Dc used to perform all drawing on. This cuts out the flicker that would be present if
				-- we did not buffer the drawing.
			font_imp: EV_FONT_IMP
				-- Temporary font implementation used when retrieving font of `Current'.
			height_offset: INTEGER
				-- If `internal_pixmap_state' is not Void, this is used to find the number of pixels vertically from
				-- the top of `Current' to where the pixmap should be drawn.
			color_imp: EV_COLOR_IMP
				-- Temporary color implementation.
			color_ref: WEL_COLOR_REF
				-- Temorary color ref.
			image_width: INTEGER
				-- Width of current image, or 0 when `internal_pixmap_state' is Void.
			text_width: INTEGER
				-- Width of text on `Current', or 0 if there is no text.
			image_pixmap_space: INTEGER
				-- Space between image and text.
			combined_width: INTEGER
				-- Width of image + image_pixmap_space + text.
			left_position: INTEGER
				-- Horizontal position to begin drawing either the image, or text. Note that if both are set,
				-- this will be the start of the image, as the text is always to the right.
			right_spacing: INTEGER
				-- spacing required on right had side of image and text.
				-- Equal to `image_pixmap_space' when there is a text, or
				-- `pixmap_border' // 2 when there is no text.
			left_spacing: INTEGER
				-- spacing required on left had side of image and text.
				-- Equal to `image_pixmap_space' when there is a text, or
				-- `pixmap_border' // 2 when there is no text.
			mask_bitmap: WEL_BITMAP
				-- Mask bitmap of current image.
			l_background_brush: WEL_BRUSH
		do
				-- Local access to information in `draw_item'.
			dc := draw_item.dc
			rect := draw_item.rect_item
			state := draw_item.item_state

				-- Create `memory_dc' for double buffering, and select
				-- a bitmap compatible with `dc' ready for drawing.
			create memory_dc.make_by_dc (dc)
			create wel_bitmap.make_compatible (dc, dc.width, dc.height)
			memory_dc.select_bitmap (wel_bitmap)
			wel_bitmap.dispose

				-- Now set both the font and background colors of `memory_dc'.
			color_imp ?= background_color.implementation
			memory_dc.set_background_color (color_imp)
				-- We are unable to query the font directly from `dc', so we set it ourselves.
				if private_font /= Void then
					font_imp ?= private_font.implementation
					check
						font_not_void: font_imp /= Void
					end
					memory_dc.select_font (font_imp.wel_font)
				else
					memory_dc.select_font (private_wel_font)
				end

				-- We set the text color of `memory_dc' to white, so that if we are
				-- a toggle button, and must draw the checked background, it uses white combined with
				-- the current background color. We then restore the original `text_color' back into `memory_dc'.
			color_ref := memory_dc.text_color
			memory_dc.set_text_color (white)
			l_background_brush := internal_background_brush
			memory_dc.fill_rect (rect, l_background_brush)
				-- We no longer use `l_background_brush', but it is a local so that
				-- can delete it later.
			memory_dc.set_text_color (color_ref)
			
			
			create focus_rect.make (rect.left, rect.top, rect.right, rect.bottom)
			create text_rect.make (rect.left, rect.top, rect.right, rect.bottom)
			focus_rect.inflate (-focus_rect_border, -focus_rect_border)

			
				-- Draw frame around `Current'. We must handle the three states, of it
				-- being in, out or bolded in response to being a default push button.
				--| Note that we shoudl probably use `draw_edge' here, but it gives us a
				--| slightly different appearence to the old button style.
			if has_pushed_appearence (state) then
				draw_frame (memory_dc, text_rect, Button_in)
			else
				if is_default_push_button then
					draw_frame (memory_dc, text_rect, state)
				else
					draw_frame (memory_dc, text_rect, button_out)
				end
			end
				
				-- If there is a pixmap on `Current', then assign its implementation to
				--`internal_pixmap_state' and store its width in `image_width'.
			if internal_pixmap /= Void then
				internal_pixmap_state ?= internal_pixmap.implementation				
					-- Compute values for re-sizing
				image_width := internal_pixmap_state.width	
			end
			
				-- Compute width required to display `text' of `Current', and
				-- aassign it to `text_width'.
			text_width := memory_dc.tabbed_text_size (text).width
				
				-- Compute number of pixels space between an image and a text. This is also
				-- used as the extra spacing on each side of the text of `Current'.
			image_pixmap_space := extra_width // 2

				-- Calculate `combined_space', `right_space', and `left_space' for
				-- all three cases :- text only, pixmap only or both.
			if text.is_empty then
				combined_width := image_width
				right_spacing := pixmap_border
				left_spacing := pixmap_border
			elseif internal_pixmap = Void then
				combined_width := text_width
				right_spacing := image_pixmap_space
				left_spacing := image_pixmap_space
			else
				right_spacing := image_pixmap_space
				combined_width := image_width + text_width + image_pixmap_space
				left_spacing := pixmap_border
			end

				-- Calculate `left_position' which is the offset in pixels from the left of the button
				-- to draw the first graphical element. If a pixmap is set in `Current', then it will always be the first,
				-- as the text is always aligned to the right of the pixmap.
			if interface.is_left_aligned then
				left_position := left_spacing
			elseif interface.is_center_aligned then
				left_position := (width - combined_width) // 2 - ((right_spacing - left_spacing) // 2)
			elseif interface.is_right_aligned then
				left_position := width - combined_width - right_spacing
			end
			
				-- Now assign the left edge of the text rectangle.
				-- Note that if there is no image, `image_width' is 0, and we do not
				-- add on `image_pixmap_space'.
			text_rect.set_left (left_position + image_width + ((internal_pixmap /= Void).to_integer * image_pixmap_space))
		
				-- If the `button_in' flag is set in `state', then we must move the text one pixel
				-- to the right and one pixel down to simulate the depression.
			if flag_set (state, button_in) then
				text_rect.offset (1, 1)
			end

				-- Draw `text' of `Current' on `memory_dc'.
			draw_button_text_left (memory_dc, text_rect)
			
				-- If we have a pixmap set on `Current', then we must draw it.
			if internal_pixmap_state /= Void then
					-- Compute distance from top of button to display image.
				height_offset := (height - internal_pixmap_state.height - pixmap_border * 2) // 2
					-- Retrieve the image of `Current'.
				wel_bitmap := internal_pixmap_state.get_bitmap
					-- Perform the drawing.
				if internal_pixmap_state.has_mask then
					mask_bitmap := internal_pixmap_state.get_mask_bitmap
				end
				draw_bitmap_on_button (memory_dc, wel_bitmap, mask_bitmap, left_position, pixmap_border + height_offset , state)
			end

				-- If `Current' has the focus, then we must draw the focus rectangle.
			if flag_set (state, feature {WEL_ODS_CONSTANTS}.Ods_focus) then
				draw_focus_rect (memory_dc, focus_rect)
			end

				-- Copy the image from `memory_dc' to `dc' which is the dc originally provided
				-- in `draw_item_state'.
			dc.bit_blt (rect.left, rect.top, rect.width, rect.height, memory_dc, 0, 0, feature {WEL_RASTER_OPERATIONS_CONSTANTS}.Srccopy)

				-- Clean up GDI objects created.
			memory_dc.unselect_all
			memory_dc.delete
			l_background_brush.delete
			if mask_bitmap /= Void then
				mask_bitmap.decrement_reference	
			end
		end
		
	extract_icon (a_pixmap_imp_state: EV_PIXMAP_IMP_STATE): WEL_ICON is
			-- Extract the icon from `pixmap_imp'.
		local
			pix_imp: EV_PIXMAP_IMP
		do
			pix_imp ?= a_pixmap_imp_state
			if pix_imp /= Void then
				Result := pix_imp.icon
			end
			if Result /= Void then
				Result.increment_reference
			else
				Result := a_pixmap_imp_state.build_icon
				Result.enable_reference_tracking
			end
		end
		
	text_format: INTEGER is
			-- `Result' is formatting used for `text' when
			-- displayed in a WEL_RECT.
		once
			Result := set_flag (Result, Dt_left)
			Result := set_flag (Result, Dt_vcenter)
			Result := set_flag (Result, Dt_singleline)
		end
		
		
	draw_button_text_left (dc: WEL_DC; r: WEL_RECT) is
			-- Draw `text' of `Current' on `dc', in `r'.
			-- If not `is_sensitive' then perform appropriate
			-- higlighting on text.
		local
			old_text_color: WEL_COLOR_REF
			color_imp: EV_COLOR_IMP
		do
			old_text_color := dc.text_color
			if not is_sensitive then
				r.offset (1, 1)
				dc.set_background_transparent
				dc.set_text_color (white)
				dc.draw_text (text, r, text_format)
				dc.set_text_color (color_gray_text)
				r.offset (-1, -1)
			else
				color_imp ?= foreground_color.implementation
				dc.set_text_color (color_imp)
			end
			dc.set_background_transparent
			dc.draw_text (text, r, text_format)
			dc.set_text_color (old_text_color)
		end
		
	draw_bitmap_on_button (dc: WEL_DC; a_bitmap, mask_bitmap: WEL_BITMAP; an_x, a_y, state: INTEGER) is
			-- Draw `a_bitmap' on `dc' at `an_x'. `a_y'. If `button_in' is set in `state' then draw bitmap
			-- one pixel right, and one pixel down to simulate the button being depressed.
			-- Take `is_sensitive' into acount, and draw `a_bitmap' greyed out if not `is_sensitive'.
		local
			actual_x, actual_y: INTEGER
			draw_state_flags: INTEGER
			buffer_dc: WEL_MEMORY_DC
			wel_bitmap: WEL_BITMAP
			image_buffer_dc: WEL_MEMORY_DC
			wel_bitmap_image: WEL_BITMAP
		do
				-- Modify the coordinates of the image one pixel to right
				-- and one pixel down if the button is currently depressed.
			if flag_set (state, button_in) then
				actual_x := an_x + 1
				actual_y := a_y + 1
			else
				actual_x := an_x
				actual_y := a_y
			end
				-- Initialize `draw_state_flags' dependent on current state of `is_sensitive'.
			if is_sensitive then
				draw_state_flags := feature {WEL_DRAWING_CONSTANTS}.Dss_normal
			else
				draw_state_flags := feature {WEL_DRAWING_CONSTANTS}.Dss_disabled
			end

			if mask_bitmap = Void then
					-- Draw directly to `dc' as there is no mask. i.e. the image is completely
					-- rectangular.
				dc.draw_state_bitmap (Void, a_bitmap, actual_x, actual_y, draw_state_flags)
			else
				create buffer_dc.make_by_dc (dc)
				create wel_bitmap.make_compatible (dc, a_bitmap.width, a_bitmap.height)
				buffer_dc.select_bitmap (wel_bitmap)
				if buffer_dc.mask_blt_supported then
					-- If Windows platform supports mask_blt then we can draw the image the
					-- simple way.
					
					-- As there is a mask, we must draw the image to a buffer, and then
					-- blit it onto `dc'. This is because `draw_state_bitmap' does not allow
					-- you to use a mask. We then use `mask_blt' to copy the buffered image back.
					
					--	Draw the state bitmap on `buffer_dc' with style `draw_state_flags'.
				buffer_dc.draw_state_bitmap (Void, a_bitmap, 0, 0, draw_state_flags)
					-- Copy the image from `buffer_dc' to `dc'.
				dc.mask_blt (actual_x, actual_y, a_bitmap.width, a_bitmap.height, buffer_dc, 0, 0, mask_bitmap, 0 , 0,
					buffer_dc.make_rop4 (feature {WEL_RASTER_OPERATIONS_CONSTANTS}.srcpaint, feature {WEL_RASTER_OPERATIONS_CONSTANTS}.srccopy))
					-- Clean up GDI.
				else
						-- Windows platform does not support mask_blt, so we must simulate this ourselves with `bit_blt'.
						
						-- Create `image_buffer_dc' which is used to draw the state image onto.
					create image_buffer_dc.make_by_dc (dc)	
					create wel_bitmap_image.make_compatible (dc, a_bitmap.width, a_bitmap.height)
					image_buffer_dc.select_bitmap (wel_bitmap_image)
					
						-- Blt the current background of the button, onto `buffer_dc'. This is necessary, as a toggle
						-- button will have a checked background when selected.
					buffer_dc.bit_blt (0, 0, a_bitmap.width, a_bitmap.height, dc, actual_x, actual_y, feature {WEL_RASTER_OPERATIONS_CONSTANTS}.Srccopy)
						-- Draw the image to `image_buffer_dc' using `draw_state_flags'.
						-- Note that we must draw the image to another dc, as it is not possible to use any masking
						-- with `draw_state_bitmap'.
					image_buffer_dc.draw_state_bitmap (Void, a_bitmap, 0, 0, draw_state_flags)
						-- We now and `mask_bitmap' onto `buffer_dc'.
					buffer_dc.draw_bitmap_with_raster_operation (mask_bitmap, 0, 0, a_bitmap.width, a_bitmap.height, feature {WEL_RASTER_OPERATIONS_CONSTANTS}.srcand)
						-- Copy the actual image already drawn on `image_buffer_dc' to `buffer_dc'. Due to the previous operation, this
						-- will be effectively masked.
					buffer_dc.bit_blt (0, 0, a_bitmap.width, a_bitmap.height, image_buffer_dc, 0, 0, feature {WEL_RASTER_OPERATIONS_CONSTANTS}.srcpaint)
						-- Copy the final image from `buffer_dc' to `dc'.
					dc.bit_blt (actual_x, actual_y, a_bitmap.width, a_bitmap.height, buffer_dc, 0, 0, feature {WEL_RASTER_OPERATIONS_CONSTANTS}.Srccopy)
					wel_bitmap_image.dispose
					image_buffer_dc.unselect_all
					image_buffer_dc.delete
				end
				wel_bitmap.dispose
				buffer_dc.unselect_all
				buffer_dc.delete
			end		
		end
		
	draw_frame (dc: WEL_DC; r: WEL_RECT; state: INTEGER) is
			-- Draw frame around `Current', using `r' which represents the size of `Current',
			-- into `dc'. Take `state' into acount, and draw it in, out or bolded
			-- accordingly.
		local
			color: WEL_COLOR_REF
		do
				-- If `current' is a default puch button, then it must have a bold rectangle.
				-- default push buttons are only used in dialogs.
			if is_default_push_button then
				create color.make_rgb (0, 0, 0)
				Draw_Line(dc, r.left,  r.top, r.right, r.top, color)
				Draw_Line(dc, r.left, r.top, r.left, r.bottom, color)
				Draw_Line(dc, r.left, r.bottom - 1, r.right, r.bottom - 1, color)
				Draw_Line(dc, r.right - 1, r.top, r.right - 1, r.bottom, color)
				r.inflate (-1, -1)
			end
				-- If the button is out then display it accordingly. The further check
				-- is used for handling toggle buttons.
			if flag_set (state, button_out) or not flag_set (state, button_in) then
				color := Rhighlight
				Draw_Line(dc, r.left, r.top, r.right, r.top, color)
				Draw_Line(dc, r.left, r.top,r.left,  r.bottom, color)
				color := Rdark_shadow
				Draw_Line(dc, r.left, r.bottom - 1, r.right, r.bottom - 1, color)
				Draw_Line(dc, r.right - 1, r.top, r.right - 1, r.bottom, color)
				r.Inflate(-1, -1)
				color := rlight
				Draw_Line(dc, r.left, r.top, r.right, r.top, color)
				Draw_Line(dc, r.left, r.top, r.left, r.bottom, color)
				color := rshadow
				Draw_Line(dc, r.left, r.bottom - 1, r.right, r.bottom - 1, color)
				Draw_Line(dc, r.right - 1, r.top, r.right - 1, r.bottom, color)
			end
			
				-- If the button is in, then draw the appropriate border.
	  		if flag_set (state, button_in) then
	  			color := rdark_shadow
				Draw_Line(dc, r.left, r.top, r.right, r.top, color)
				Draw_Line(dc, r.left, r.top, r.left, r.bottom, color)
				color := Rhighlight
				Draw_Line(dc, r.left, r.bottom - 1, r.right, r.bottom - 1, color)
				Draw_Line(dc, r.right - 1, r.top, r.right - 1, r.bottom, color)
				r.Inflate(-1, -1)
				color := rshadow;
				Draw_Line(dc, r.left,  r.top, r.right - 1, r.top, color)
				Draw_Line(dc, r.left,  r.top, r.left,  r.bottom - 1, color)
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
		
	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erase_background message has been received by Windows.
			-- We must override the default processing, as if we do not, then
			-- Windows will draw the background for us, even though it is not needed.
			-- This causes flicker.
		do
			disable_default_processing
		end
		
	color_gray_text: WEL_COLOR_REF is
			-- `Result' is color corresponding to Windows color - Colorgraytext.
		once
			create Result.make_system ((create {WEL_COLOR_CONSTANTS}).Color_graytext)
		end
		
	white: WEL_COLOR_REF is
			-- `Result' is color corresponding to white
		once
			Create Result.make_rgb (255, 255, 255)
		end

	rtext_color: WEL_COLOR_REF is
			-- `Result' is color corresponding to Windows color - Colorbtntext
		once
			create Result.make_system ((create {WEL_COLOR_CONSTANTS}).Color_btntext)
		end

	rlight: WEL_COLOR_REF is
			-- `Result' is color corresponding to Windows color - Color3dlight
		once
			create Result.make_system ((create {WEL_COLOR_CONSTANTS}).Color_3dlight)
		end
		
	rhighlight: WEL_COLOR_REF is
			-- `Result' is color corresponding to Windows color - Colorbtnhighlight
		once
			create Result.make_system ((create {WEL_COLOR_CONSTANTS}).Color_btnhighlight)
		end
		
	rshadow: WEL_COLOR_REF is
			-- `Result' is color corresponding to Windows color - Colorbtnshadow.
		once
			create Result.make_system ((create {WEL_COLOR_CONSTANTS}).Color_btnshadow)
		end
		
	rdark_shadow: WEL_COLOR_REF is
			-- `Result' is color corresponding to Windows color -Color3ddkshadow
		once
			create Result.make_system ((create {WEL_COLOR_CONSTANTS}).Color_3ddkshadow)
		end
		
feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem
		do
			Result := cwin_get_next_dlgtabitem (hdlg, hctl, previous)
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem.
		do
			Result := cwin_get_next_dlggroupitem (hdlg, hctl, previous)
		end

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normally, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normally, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

feature {EV_ANY_I}

	interface: EV_BUTTON

end -- class EV_BUTTON_IMP

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

