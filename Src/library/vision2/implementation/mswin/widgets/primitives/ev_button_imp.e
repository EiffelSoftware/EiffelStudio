indexing
	description: "EiffelVision push button. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			update_current_push_button,
			on_mouse_enter,
			on_mouse_leave
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
			on_mouse_wheel,
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
			default_process_message,
			on_getdlgcode
		redefine
			default_style,
			on_bn_clicked,
			wel_set_text,
			on_erase_background,
			on_wm_theme_changed
		end

	EV_BUTTON_ACTION_SEQUENCES_IMP

	WEL_THEME_PBS_CONSTANTS
		export
			{NONE} all
		end

	WEL_THEME_PART_CONSTANTS
		export
			{NONE} all
		end

	WEL_ODS_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make (default_parent, "", 0, 0, 0, 0, 0)
			extra_width := 20
			text_alignment := default_alignment
				-- Retrieve the theme for the button.
			open_theme := application_imp.theme_drawer.open_theme_data (wel_item, "Button")
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
			l_text: like wel_text
		do
			l_text := wel_text
			if not l_text.is_empty then
				if private_font /= Void then
					font_imp ?= private_font.implementation
					check
						font_not_void: font_imp /= Void
					end
					w := extra_width + font_imp.string_width (l_text)
					h := h.max (19 * font_imp.height // 9)
				else
					w := extra_width + private_wel_font.string_width (l_text)
					h := h.max (19 * private_wel_font.height // 9)
				end
			end


			if pixmap_imp /= Void then
				if l_text.is_empty then
					w := private_pixmap.width + pixmap_border * 2
				else
					w := w + private_pixmap.width + pixmap_border
				end
				h := h.max (private_pixmap.height + pixmap_border * 2)
			end
			if l_text.is_empty and pixmap_imp = Void then
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

			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_Text_alignment_left
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

			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_Text_alignment_right
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

			text_alignment := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_Text_alignment_center
			invalidate
		end

	enable_default_push_button is
			-- Set the style "default_push_button" of `Current'.
		do
			is_default_push_button := True
			if internal_bitmap /= Void then
				invalidate
			else
				cwin_send_message (wel_item, bm_setstyle,
					to_wparam (style | bs_defpushbutton),
					cwin_make_long (1, 0))
			end
		end

	disable_default_push_button is
			-- Remove the style "default_push_button"  of `Current'.
		do
			is_default_push_button := False
			if flag_set (style, bs_ownerdraw) then
				invalidate
			else
				cwin_send_message (wel_item, bm_setstyle,
					to_wparam (style & bs_defpushbutton.bit_not),
					cwin_make_long (1, 0))
			end
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
			internal_pixmap_state: EV_PIXMAP_IMP_STATE
			font_imp: EV_FONT_IMP
			size_difference: INTEGER
		do
			private_pixmap := pix.twin
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

			internal_pixmap_state ?= private_pixmap.implementation
			internal_bitmap := internal_pixmap_state.get_bitmap
			internal_bitmap.decrement_reference
			set_default_minimum_size
			invalidate
		end

	set_font (ft: EV_FONT) is
			-- Make `ft' new font of `Current'.
		do
			Precursor {EV_FONTABLE_IMP} (ft)
			set_default_minimum_size
		end

	remove_pixmap is
			-- Remove `pixmap' from `Current'.
		do
			Precursor {EV_PIXMAPABLE_IMP}
			set_default_minimum_size
			invalidate
		end

	wel_set_text (txt: STRING_GENERAL) is
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
					-- Current is not in a dialog so Current should not
					-- have the `is_default_push_button' flag.
				disable_default_push_button
			end
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- Default style used to create `Current'.
		do
			Result := ws_visible | ws_child | ws_group | ws_tabstop | Ws_clipchildren | Ws_clipsiblings | Bs_ownerdraw
		end

	on_bn_clicked is
			-- `Current' has been pressed.
		do
			if select_actions_internal /= Void then
				select_actions_internal.call (Void)
			end
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed.
		do
			process_tab_key (virtual_key)
			Precursor {EV_PRIMITIVE_IMP} (virtual_key, key_data)
		end

	on_wm_theme_changed is
			-- WM_THEMECHANGED message received so update current theme object.
		do
			application_imp.theme_drawer.close_theme_data (open_theme)
			application_imp.update_theme_drawer
			open_theme := application_imp.theme_drawer.open_theme_data (wel_item, "Button")
		end

	open_theme: POINTER
		-- Theme currently open for `Current'. May be Void while running on Windows versions that
		-- do no support theming.

feature {EV_ANY_I} -- Drawing implementation

	has_pushed_appearence (state: INTEGER): BOOLEAN is
			-- Should `Current' have the appearence of being
			-- pressed?
		do
			Result := flag_set (state, Ods_selected)
		end

	pixmap_border: INTEGER is 4
		-- spacing between image and edge of `Current'.

	focus_rect_border: INTEGER is 3
		-- Distance of focus rectangle from edge of button.

	internal_background_brush: WEL_BRUSH is
			-- `Result' is background brush to be used for `Current'.
		local
			color_imp: EV_COLOR_IMP
			color: EV_COLOR
		do
			color_imp := background_color_imp
			if color_imp = Void then
				create color
				color_imp ?= color.implementation
				color_imp.set_with_system_id ({WEL_COLOR_CONSTANTS}.Color_btnface)
			end
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

			color_ref: WEL_COLOR_REF
			coordinate: EV_COORDINATE
			drawstate: INTEGER
				-- Drawstate of the button.
			theme_drawer: EV_THEME_DRAWER_IMP
				-- Theme drawer currently in use.
			l_internal_brush: WEL_BRUSH
		do
			theme_drawer := application_imp.theme_drawer

				-- Local access to information in `draw_item'.
			dc := draw_item.dc
			rect := draw_item.rect_item
			state := draw_item.item_state

				-- Create `memory_dc' for double buffering, and select
				-- a bitmap compatible with `dc' ready for drawing.
			create memory_dc.make_by_dc (dc)
			create wel_bitmap.make_compatible (dc, rect.width, rect.height)
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

					-- Calculate the draw state flags and then draw the background
			if has_pushed_appearence (state) then
				drawstate := pbs_pressed
			else
				drawstate := pbs_normal
				if flag_set (state, ods_hotlight) or mouse_on_button then
						--| FIXME This is a big hack as `mouse_on_button' is used as we do not seem to
						--| get the ODS_HOTLIGHT notification?
					drawstate := pbs_hot
				elseif flag_set (state, Ods_focus) then
					drawstate := pbs_defaulted
				elseif not is_sensitive then
					drawstate := pbs_disabled
				end
			end

							-- Need to first clear the area to the background color of `parent_imp'
			theme_drawer.draw_theme_parent_background (wel_item, memory_dc, rect, Void)

				-- We set the text color of `memory_dc' to white, so that if we are
				-- a toggle button, and must draw the checked background, it uses white combined with
				-- the current background color. We then restore the original `text_color' back into `memory_dc'.
			color_ref := memory_dc.text_color
			memory_dc.set_text_color (white)

			l_internal_brush := internal_background_brush
			theme_drawer.draw_theme_background (open_theme, memory_dc, bp_pushbutton, drawstate, rect, Void, l_internal_brush)
			l_internal_brush.delete

			memory_dc.set_text_color (color_ref)

			create focus_rect.make (rect.left, rect.top, rect.right, rect.bottom)
			create text_rect.make (rect.left, rect.top, rect.right, rect.bottom)
			focus_rect.inflate (-focus_rect_border, -focus_rect_border)

			if has_pushed_appearence (state) then
					drawstate := ods_selected
			else
				if is_default_push_button then
					drawstate := ods_default
				else
					drawstate := ods_grayed
				end
			end

				-- Draw the edge of the button.
			theme_drawer.draw_button_edge (memory_dc, drawstate, text_rect)

				-- If there is a pixmap on `Current', then assign its implementation to
				--`internal_pixmap_state' and store its width in `image_width'.
			if private_pixmap /= Void then
				internal_pixmap_state ?= private_pixmap.implementation
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
			elseif private_pixmap = Void then
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
			text_rect.set_left (left_position + image_width + ((private_pixmap /= Void).to_integer * image_pixmap_space))

			theme_drawer.update_button_text_rect_for_state (open_theme, state, text_rect)

			if foreground_color_imp /= Void then
				color_imp := foreground_color_imp
			else
				color_imp ?= default_foreground_color_imp
			end
			theme_drawer.draw_text (open_theme, memory_dc, bp_pushbutton, pbs_normal, wel_text, dt_left | dt_vcenter | dt_singleline, is_sensitive, text_rect, color_imp)

				-- If we have a pixmap set on `Current', then we must draw it.
			if internal_pixmap_state /= Void then
					-- Compute distance from top of button to display image.
				height_offset := (height - internal_pixmap_state.height - pixmap_border * 2) // 2
					-- Retrieve the image of `Current'.
				wel_bitmap := internal_bitmap
					-- Perform the drawing.
				if internal_pixmap_state.has_mask then
					mask_bitmap := internal_pixmap_state.get_mask_bitmap
				end
					-- Modify the coordinates of the image one pixel to right
					-- and one pixel down if the button is currently depressed.

				create coordinate.make (left_position, pixmap_border + height_offset)
				theme_drawer.update_button_pixmap_coordinates_for_state (open_theme, state, coordinate)

				theme_drawer.draw_bitmap_on_dc (memory_dc, wel_bitmap, mask_bitmap, coordinate.x, coordinate.y, is_sensitive)
			end

				-- If `Current' has the focus, then we must draw the focus rectangle.
			if flag_set (state, ods_focus) then
					-- If `is_default_push_button' then `Current' is being
					-- drawn as the focused button in a dialog. We must move
					-- `focus_rect' away from the extra thick border.
				if is_default_push_button then
					focus_rect.inflate (-1, -1)
				end
				draw_focus_rect (memory_dc, focus_rect)
			end

				-- Copy the image from `memory_dc' to `dc' which is the dc originally provided
				-- in `draw_item_state'.
			dc.bit_blt (rect.left, rect.top, rect.width, rect.height, memory_dc, 0, 0, {WEL_RASTER_OPERATIONS_CONSTANTS}.Srccopy)

				-- Clean up GDI objects created.
			memory_dc.unselect_all
			memory_dc.delete
			if l_background_brush /= Void then
				l_background_brush.delete
			end
			if mask_bitmap /= Void then
				mask_bitmap.decrement_reference
			end
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erase_background message has been received by Windows.
			-- We must override the default processing, as if we do not, then
			-- Windows will draw the background for us, even though it is not needed.
			-- This causes flicker.
		do
			disable_default_processing
		end

	white: WEL_COLOR_REF is
			-- `Result' is color corresponding to white
		once
			Create Result.make_rgb (255, 255, 255)
		end

	default_foreground_color_imp: EV_COLOR_IMP is
			-- Default foreground color for widgets.
		once
			Result ?= (create {EV_STOCK_COLORS}).default_foreground_color.implementation
		ensure
			result_not_void: result /= Void
		end

	mouse_on_button: BOOLEAN
		-- Is the mouse pointer currently held above `Current'? Used as
		-- a temporary hack until it can be found why Ods_hottrack does not seem to
		-- be sent when it should.

	on_mouse_enter is
			-- Called when the mouse enters `Current'.
		do
			Precursor {EV_PRIMITIVE_IMP}
			mouse_on_button := True
			invalidate
		end

	on_mouse_leave is
			-- Called when the mouse leaves `Current'.
		do
			Precursor {EV_PRIMITIVE_IMP}
			mouse_on_button := False
			invalidate
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_BUTTON;

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




end -- class EV_BUTTON_IMP

