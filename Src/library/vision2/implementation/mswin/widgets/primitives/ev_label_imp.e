indexing
	description: "EiffelVision label widget. Displays a single line of text.%
		%Mswindows implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LABEL_IMP

inherit
	EV_LABEL_I
		redefine
			interface
		select
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			set_default_minimum_size,
			interface,
			initialize
		end

	EV_TEXT_ALIGNABLE_IMP
		undefine
			set_default_minimum_size
		redefine
			align_text_center,
			align_text_left,
			align_text_right,
			interface,
			set_text
		end

	EV_FONTABLE_IMP
		rename
			interface as ev_fontable_imp_interface
		redefine
			set_font
		end

	EV_WEL_STATIC_OWNERDRAW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			background_color as wel_background_color,
			foreground_color as wel_foreground_color,
			font as wel_font,
			shown as is_displayed,
			set_font as wel_set_font,
			destroy as wel_destroy,
			width as wel_width,
			height as wel_height,
			enabled as is_sensitive,
			item as wel_item,
			x as x_position,
			y as y_position,
			move as wel_move,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			text as wel_text,
			set_text as wel_set_text,
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
			on_key_up,
			on_key_down,
			on_set_cursor,
			on_char,
			show,
			hide,
			on_size,
			x_position,
			y_position,
			wel_background_color,
			wel_foreground_color,
			on_sys_key_down,
			on_sys_key_up,
			default_process_message,
			on_getdlgcode,
			on_wm_dropfiles
		redefine
			default_style, on_erase_background
		end

	WEL_ODS_CONSTANTS
		export
			{NONE} all
		end

	WEL_DT_CONSTANTS
		export
			{NONE} all
		end

	WEL_SHARED_METRICS
		export
			{NONE} all
		end

	SINGLE_MATH

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make (default_parent, "", 0, 0, 0, 0, 0)
			align_text_center
		end

	initialize is
			-- Initialize `Current'.
		do
			set_default_font
			disable_tabable_from
			disable_tabable_to
			Precursor {EV_PRIMITIVE_IMP}
		end

feature -- Access

	angle: REAL
			-- Amount text is rotated counter-clockwise from horizontal plane in radians.
			-- Default is 0.

feature -- Element change

	set_angle (a_angle: REAL) is
			-- Set counter-clockwise rotation of text from horizontal plane.
			-- `a_angle' is expressed in radians.
		local
			l_font: EV_FONT
			l_font_imp: EV_FONT_IMP
			l_log_font: WEL_LOG_FONT
		do
			if a_angle /= angle then
				angle := a_angle
					-- We need to create a new `private_font' that has an escapement set.
				l_font := font
				l_font_imp ?= l_font.implementation
				l_log_font := l_font_imp.wel_font.log_font
				l_log_font.set_escapement ((angle * 1800 / 3.14).rounded)
				--l_log_font.set_orientation ((angle * 1800 / 3.14).rounded)
				l_font_imp.wel_font.set_indirect (l_log_font)
				wel_set_font (l_font_imp.wel_font)
				set_font (l_font)
				accomodate_text (text)
				invalidate
			end
		end

	set_text (a_text: STRING_GENERAL) is
			-- Assign `a_text' to `text'.
		do
			if not text.is_equal (a_text) then
				if a_text.is_empty then
					set_default_minimum_size
				else
					accomodate_text (a_text)
				end
				Precursor {EV_TEXT_ALIGNABLE_IMP} (a_text)
				invalidate
			end
		end

	set_font (ft: EV_FONT) is
			-- Make `ft' new font of `Current'.
		local
			l_text: like text
		do
				-- Optimization, instead of computing the `private_font' in `internal_font'
				-- we go directly and let the precursor version do it for us. This saves
				-- a comparison and a useless creation of `private_font'.
			if private_font = Void or else not internal_font.is_equal (ft) then
				Precursor {EV_FONTABLE_IMP} (ft)
				l_text := text
				if not l_text.is_empty then
					accomodate_text (l_text)
				end
				invalidate
			end
		end

feature -- Status setting

	align_text_center is
			-- Set text alignment of current label to center.
		do
			Precursor {EV_TEXT_ALIGNABLE_IMP}
			invalidate
		end

	align_text_right is
			-- Set text alignment of current label to right.
		do
			Precursor {EV_TEXT_ALIGNABLE_IMP}
			invalidate
		end

	align_text_left is
			-- Set text alignment of current label to left.
		do
			Precursor {EV_TEXT_ALIGNABLE_IMP}
			invalidate
		end

feature {EV_ANY_I} -- Initialization

	set_default_minimum_size is
			-- Resize to a default size.
		do
			accomodate_text (" ")
		end

	accomodate_text (a_text: STRING_GENERAL) is
			-- Change internal minimum size to make `a_text' fit.
		require
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		local
			t: TUPLE [width: INTEGER; height: INTEGER]
			a_width, a_height: INTEGER
			l_angle: REAL
		do
			if private_font /= Void then
				t := private_font.string_size (a_text)
			else
				t := private_wel_font.string_size (a_text)
			end
			a_width := t.width
			a_height := t.height

			l_angle := angle
			if l_angle /= 0.0 then
				a_height := (a_width * sine (l_angle) + a_height * cosine (l_angle)).rounded
				a_width := (a_width * cosine (l_angle) + a_height * sine (l_angle)).rounded
			end
			text_height := a_height
			text_width := a_width
			ev_set_minimum_size (a_width.abs, a_height.abs)
		end

feature {NONE} -- WEL Implementation

   	default_style: INTEGER is
   			-- Default style used to create `Current'.
   		do
 			Result := Ws_visible | Ws_child | Ss_notify | Ss_ownerdraw
 		end

feature {EV_CONTAINER_IMP} -- WEL Implementation

	on_draw_item (draw_item_struct: WEL_DRAW_ITEM_STRUCT) is
			-- Process `Wm_drawitem' message.
		local
			l_draw_dc: WEL_CLIENT_DC
			l_mem_dc: WEL_DC
			l_draw_flags: INTEGER
			l_draw_text_rect: WEL_RECT
			l_rect: WEL_RECT
			l_draw_font: WEL_FONT
			l_font_imp: EV_FONT_IMP
			l_bk_brush: WEL_BRUSH
			l_wel_color: WEL_COLOR_REF
			l_color_imp: EV_COLOR_IMP
			l_bitmap: WEL_BITMAP
			l_is_remote: BOOLEAN
		do
			l_wel_color := wel_background_color
			create l_bk_brush.make_solid (l_wel_color)

				-- Assign local variable for faster access
			l_draw_dc := draw_item_struct.dc
			l_rect := draw_item_struct.rect_item

			if internal_text /= Void then
				l_is_remote := metrics.is_remote_session
				if l_is_remote then
					l_mem_dc := l_draw_dc
				else
					create {WEL_MEMORY_DC} l_mem_dc.make_by_dc (l_draw_dc)
					create l_bitmap.make_compatible (l_draw_dc, l_rect.width, l_rect.height)
					l_mem_dc.select_bitmap (l_bitmap)
					l_bitmap.dispose
				end

					-- Set the flag for the forthcoming call to
					-- `draw_text'.
				inspect text_alignment
				when {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center then
					l_draw_flags := Dt_center
				when {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left then
					l_draw_flags := Dt_left
				when {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right then
					l_draw_flags := Dt_right
				else
					check
						Unexpected_alignment: False
					end
				end
				l_draw_flags := l_draw_flags | Dt_expandtabs | dt_vcenter

				-- Compute the bounding rectangle where the text need
				-- to be displayed.

				create l_draw_text_rect.make (
					l_rect.left, l_rect.top + (l_rect.height - text_height) // 2,
					l_rect.right, l_rect.bottom)

					-- Need to first clear the area to the background color of `parent_imp'
				application_imp.theme_drawer.draw_widget_background (Current, l_mem_dc, l_rect, l_bk_brush)

					-- Retrieve the font used to draw the text
				l_draw_font := private_wel_font
				if l_draw_font = Void then
					l_font_imp ?= internal_font.implementation
					l_draw_font := l_font_imp.wel_font
				end
					 -- Draw the text
				l_mem_dc.select_font (l_draw_font)
				l_color_imp ?= foreground_color.implementation
				l_mem_dc.set_text_color (l_color_imp)

					-- Set transparent because the background is drawn according to the label's set background color
					-- or notebook theme.
				l_mem_dc.set_background_transparent

				if not is_sensitive then
						-- Label is disabled
					l_mem_dc.draw_disabled_text (internal_text, l_draw_text_rect, l_draw_flags)
				else
						-- Label is NOT disabled
					l_mem_dc.draw_text (internal_text, l_draw_text_rect, l_draw_flags)
				end
				if not l_is_remote then
					l_draw_dc.bit_blt (l_rect.left, l_rect.top, l_rect.width, l_rect.height, l_mem_dc,
							0, 0, {WEL_RASTER_OPERATIONS_CONSTANTS}.Srccopy)
				end
				l_mem_dc.unselect_all
				l_mem_dc.delete
			else
				application_imp.theme_drawer.draw_widget_background (Current, l_draw_dc, l_rect, l_bk_brush)
			end
			l_bk_brush.delete
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erase_background message has been received by Windows.
			-- We must override the default processing, as if we do not, then
			-- Windows will draw the background for us, even though it is not needed.
			-- This causes flicker.
		do
			disable_default_processing
		end

feature {NONE} -- Implementation

	text_height: INTEGER
			-- Height in pixels of the current text.

	text_width: INTEGER
			-- Width of pixels of the current text.

feature {EV_ANY_I}

	interface: EV_LABEL;

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




end -- class EV_LABEL_IMP

