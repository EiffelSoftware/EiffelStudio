indexing
	description: "[
		Objects that permit graphical drawing operations to be performed which respect the
		theming state of Windows.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_THEME_DRAWER_IMP

feature -- Basic operations

	open_theme_data (item: POINTER; class_name: STRING_GENERAL): POINTER is
			-- Open theme data for WEL_WINDOW represented by `item'
			-- with type of theme `class_name'. See "Parts and States" of MSDN
			-- for a list of valid class names.
		require
			item_exists: item /= default_pointer
			class_name_not_void: class_name /= Void
		deferred
		end

	close_theme_data (item: POINTER) is
			-- Close theme data for WEL_WINDOW represented by `item'.
		deferred
		end

	get_window_theme (item: POINTER): POINTER is
			-- Retrieve a theme handle for WEL_WINDOW `item'.
		require
			item_not_default_pointer: item /= default_pointer
		deferred
		end

	draw_theme_background (theme: POINTER; a_hdc: WEL_DC; a_part_id, a_state_id: INTEGER; a_rect, a_clip_rect: WEL_RECT; background_brush: WEL_BRUSH) is
			-- Draw a background theme using the theme `theme' into `a_hdc'. `a_part_id' represents the part type to draw and `a_state_id' represents
			-- the item state. Drawing is performed into `a_rect' and clipped to `a_clip_rect'. If not themed then use `background_brush' for the background.
		require
			a_hdc_not_void: a_hdc /= Void
			a_rect_not_void: a_rect /= Void
			background_brush_not_void: background_brush /= Void
		deferred
		end

	draw_widget_background (a_widget: EV_WIDGET_IMP; a_hdc: WEL_DC; a_rect: WEL_RECT; background_brush: WEL_BRUSH) is
			-- Draw the background for `a_widget' onto `a_hdc' restricted to `a_rect'. `background_brush' is used as the
			-- brush although on some descendents (i.e. XP), the theming of a particular parent may be copied instead. This permits
			-- gradient theming to be applied to widgets even though they are nested in containers. For example notebooks
			-- on XP have a fill such as this and if no background color has been applied then the fill is used.
		require
			a_widget_not_void: a_widget /= Void
			a_hdc_not_void: a_hdc /= Void
			a_rect_not_void: a_rect /= Void
			background_brush_not_void: background_brush /= Void
		deferred
		end

	draw_notebook_background (notebook: EV_NOTEBOOK_IMP; a_hdc: WEL_DC; a_rect: WEL_RECT; background_brush: WEL_BRUSH) is
			-- Draw the background for `notebook' onto `a_hdc' restricted to `a_rect'. `background_brush' is used as the brush
			-- for classic versions.
		require
			notebook_not_void: notebook /= Void
			a_hdc_not_void: a_hdc /= Void
			a_rect_not_void: a_rect /= Void
			background_brush /= Void
		deferred
		end

	draw_theme_parent_background (wel_item: POINTER; a_hdc: WEL_DC; a_rect: WEL_RECT; background_brush: WEL_BRUSH) is
			-- For the  WEL_WINDOW represented by `wel_item', copy the background of it's `parent' into `a_hdc' using
			-- `a_rect'. On classic implementations, simply use `background_brush' if not Void.
		require
			wel_item_exists: wel_item /= default_pointer
			a_hdc_not_void: a_hdc /= Void
			a_rect_not_void: a_rect /= Void
		deferred
		end

	draw_button_edge (memory_dc: WEL_DC; a_state_id: INTEGER; a_rect: WEL_RECT) is
			-- Draw a button edge into `memory_dc' using `a_state_id' to give the current
			-- button state. `a_rect' gives the boundaries of the drawing.
		require
			memory_dc_not_void: memory_dc /= Void
			a_rect_not_void: a_rect /= Void
		deferred
		end

	update_button_text_rect_for_state (open_theme: POINTER; a_state: INTEGER; a_rect: WEL_RECT) is
			-- Update `a_rect' to reflect new position for text drawn on a button with state `a_state'.
		require
			a_rect_not_void: a_rect /= Void
		deferred
		end

	update_button_pixmap_coordinates_for_state (open_theme: POINTER; a_state: INTEGER; coordinate: EV_COORDINATE) is
			-- Update `coordinate' to reflect new coordinates for a pixmap drawn on a button with state `a_state'.
		require
			coordinate_not_void: coordinate /= Void
		deferred
		end

	draw_text (theme: POINTER; a_hdc: WEL_DC; a_part_id, a_state_id: INTEGER; text: STRING_GENERAL; dw_text_flags: INTEGER; is_sensitive: BOOLEAN; a_content_rect: WEL_RECT; foreground_color: EV_COLOR_IMP) is
			-- Draw `text' using theme `theme' on `a_hdc' within `a_content_rect' corresponding to part `a_part_id', `a_state_id'. Respect state of `is_sensitive' and use `foreground_color'
			-- if set.
		require
			a_hdc_not_void: a_hdc /= Void
			text_not_void: text /= Void
			a_content_rect_not_void: a_content_rect /= Void
			foreground_color_not_void: foreground_color /= void
		deferred
		end

	draw_bitmap_on_dc (dc: WEL_DC; a_bitmap, mask_bitmap: WEL_BITMAP; an_x, a_y: INTEGER; is_sensitive: BOOLEAN) is
			-- Draw `a_bitmap' on `dc' at `an_x'. `a_y'.
			-- Take `is_sensitive' into acount, and draw `a_bitmap' greyed out if not `is_sensitive'.
		require
			dc_not_void: dc /= Void
			a_bitmap_not_void: a_bitmap /= Void
		local
			draw_state_flags: INTEGER
			buffer_dc: WEL_MEMORY_DC
			wel_bitmap: WEL_BITMAP
			image_buffer_dc: WEL_MEMORY_DC
			wel_bitmap_image: WEL_BITMAP
		do
				-- Initialize `draw_state_flags' dependent on current state of `is_sensitive'.
			if is_sensitive then
				draw_state_flags := {WEL_DRAWING_CONSTANTS}.Dss_normal
			else
				draw_state_flags := {WEL_DRAWING_CONSTANTS}.Dss_disabled
			end

			if mask_bitmap = Void then
					-- Draw directly to `dc' as there is no mask. i.e. the image is completely
					-- rectangular.
				dc.draw_state_bitmap (Void, a_bitmap, an_x, a_y, draw_state_flags)
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
					dc.mask_blt (an_x, a_y, a_bitmap.width, a_bitmap.height, buffer_dc, 0, 0, mask_bitmap, 0 , 0,
						buffer_dc.make_rop4 ({WEL_RASTER_OPERATIONS_CONSTANTS}.srcpaint, {WEL_RASTER_OPERATIONS_CONSTANTS}.srccopy))
						-- Clean up GDI.
				else
						-- Windows platform does not support mask_blt, so we must simulate this ourselves with `bit_blt'.

						-- Create `image_buffer_dc' which is used to draw the state image onto.
					create image_buffer_dc.make_by_dc (dc)
					create wel_bitmap_image.make_compatible (dc, a_bitmap.width, a_bitmap.height)
					image_buffer_dc.select_bitmap (wel_bitmap_image)

						-- Blt the current background of the button, onto `buffer_dc'. This is necessary, as a toggle
						-- button will have a checked background when selected.
					buffer_dc.bit_blt (0, 0, a_bitmap.width, a_bitmap.height, dc, an_x, a_y, {WEL_RASTER_OPERATIONS_CONSTANTS}.Srccopy)
						-- Draw the image to `image_buffer_dc' using `draw_state_flags'.
						-- Note that we must draw the image to another dc, as it is not possible to use any masking
						-- with `draw_state_bitmap'.
					image_buffer_dc.draw_state_bitmap (Void, a_bitmap, 0, 0, draw_state_flags)
						-- We now and `mask_bitmap' onto `buffer_dc'.
					buffer_dc.draw_bitmap_with_raster_operation (mask_bitmap, 0, 0, a_bitmap.width, a_bitmap.height, {WEL_RASTER_OPERATIONS_CONSTANTS}.srcand)
						-- Copy the actual image already drawn on `image_buffer_dc' to `buffer_dc'. Due to the previous operation, this
						-- will be effectively masked.
					buffer_dc.bit_blt (0, 0, a_bitmap.width, a_bitmap.height, image_buffer_dc, 0, 0, {WEL_RASTER_OPERATIONS_CONSTANTS}.srcpaint)
						-- Copy the final image from `buffer_dc' to `dc'.
					dc.bit_blt (an_x, a_y, a_bitmap.width, a_bitmap.height, buffer_dc, 0, 0, {WEL_RASTER_OPERATIONS_CONSTANTS}.Srccopy)
					wel_bitmap_image.dispose
					image_buffer_dc.unselect_all
					image_buffer_dc.delete
				end
				wel_bitmap.dispose
				buffer_dc.unselect_all
				buffer_dc.delete
			end
		end

	internal_draw_text (item: POINTER; dc: WEL_DC; text: STRING_GENERAL; r: WEL_RECT; flags: INTEGER; is_sensitive: BOOLEAN; foreground_color: EV_COLOR_IMP) is
			-- Draw `text' of `Current' on `dc', in `r'.
			-- If not `is_sensitive' then perform appropriate
			-- higlighting on text.
		local
			old_text_color: WEL_COLOR_REF
		do
			old_text_color := dc.text_color
			if not is_sensitive then
				r.offset (1, 1)
				dc.set_background_transparent
				dc.set_text_color (white)
				dc.draw_text (text, r, flags)
				dc.set_text_color (color_gray_text)
				r.offset (-1, -1)
			else
				dc.set_text_color (foreground_color)
			end
			dc.set_background_transparent
			dc.draw_text (text, r, flags)
			dc.set_text_color (old_text_color)
		end

feature -- Query

	theme_color (a_theme: POINTER; a_color_id: INTEGER): EV_COLOR is
			-- Theme color
			-- `a_color_id' is one value from EV_THEME_COLOR_CONSTANTS.
			-- Actually it only work with values from WEL_COLOR_CONSTANTS. Not same behaviour as MSDN said.
		require
			valid: is_color_id_valid (a_color_id)
		deferred
		ensure
			not_void: Result /= Void
		end

	is_color_id_valid (a_color_id: INTEGER): BOOLEAN is
			-- If a_color_id valid?
		local
			l_constants: WEL_COLOR_CONSTANTS
		do
			create l_constants
			Result := l_constants.valid_color_constant (a_color_id)
		end

feature {NONE} -- Implementation

	white: WEL_COLOR_REF is
			-- `Result' is color corresponding to white
		once
			Create Result.make_rgb (255, 255, 255)
		end

	color_gray_text: WEL_COLOR_REF is
			-- `Result' is color corresponding to Windows color - Colorgraytext.
		do
			create Result.make_system ({WEL_COLOR_CONSTANTS}.Color_graytext)
		end

	rtext_color: WEL_COLOR_REF is
			-- `Result' is color corresponding to Windows color - Colorbtntext
		do
			create Result.make_system ({WEL_COLOR_CONSTANTS}.Color_btntext)
		end

	rlight: WEL_COLOR_REF is
			-- `Result' is color corresponding to Windows color - Color3dlight
		do
			create Result.make_system ({WEL_COLOR_CONSTANTS}.Color_3dlight)
		end

	rhighlight: WEL_COLOR_REF is
			-- `Result' is color corresponding to Windows color - Colorbtnhighlight
		do
			create Result.make_system ({WEL_COLOR_CONSTANTS}.Color_btnhighlight)
		end

	rshadow: WEL_COLOR_REF is
			-- `Result' is color corresponding to Windows color - Colorbtnshadow.
		do
			create Result.make_system ({WEL_COLOR_CONSTANTS}.Color_btnshadow)
		end

	rdark_shadow: WEL_COLOR_REF is
			-- `Result' is color corresponding to Windows color -Color3ddkshadow
		do
			create Result.make_system ({WEL_COLOR_CONSTANTS}.Color_3ddkshadow)
		end

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

