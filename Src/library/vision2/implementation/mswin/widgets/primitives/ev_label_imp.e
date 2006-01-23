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
			on_getdlgcode
		redefine
			default_style
		end

	WEL_ODS_CONSTANTS
		export
			{NONE} all
		end

	WEL_DT_CONSTANTS
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
			align_text_center
		end

	initialize is
			-- Initialize `Current'.
		do
			set_default_font
			Precursor {EV_PRIMITIVE_IMP}
		end

feature -- Element change

	set_text (a_text: STRING) is
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
		do
			if not internal_font.is_equal (ft) then
				Precursor {EV_FONTABLE_IMP} (ft)
				if not text.is_empty then
					accomodate_text (text)
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

	accomodate_text (a_text: STRING) is
			-- Change internal minimum size to make `a_text' fit.
		require
			a_text_not_void: a_text /= Void
			a_text_not_empty: not a_text.is_empty
		local
			t: TUPLE [INTEGER, INTEGER]
		do
			if private_font /= Void then
				t := private_font.string_size (a_text)
			else
				t := private_wel_font.string_size (a_text)
			end
			text_height := t.integer_item (2)
			ev_set_minimum_size (t.integer_item (1), text_height)
		end

feature {NONE} -- WEL Implementation

   	default_style: INTEGER is
   			-- Default style used to create `Current'.
   		do
 			Result := Ws_visible | Ws_child | Ss_notify | Ss_ownerdraw
 				| Ws_clipchildren | Ws_clipsiblings
 		end

feature {EV_CONTAINER_IMP} -- WEL Implementation

	on_draw_item (draw_item_struct: WEL_DRAW_ITEM_STRUCT) is
			-- Process `Wm_drawitem' message.
		local
			draw_dc: WEL_CLIENT_DC
			draw_flags: INTEGER
			draw_rect: WEL_RECT
			draw_item_struct_rect: WEL_RECT
			draw_font: WEL_FONT
			font_imp: EV_FONT_IMP
			theme_drawer: EV_THEME_DRAWER_IMP
			bk_brush: WEL_BRUSH
			color_imp: EV_COLOR_IMP
		do
			theme_drawer := application_imp.theme_drawer
			create bk_brush.make_solid (wel_background_color)

				-- Assign local variable for faster access
			draw_dc := draw_item_struct.dc
			draw_item_struct_rect := draw_item_struct.rect_item

			if internal_text /= Void then
					-- Retrieve the font used to draw the text
				draw_font := private_wel_font
				if draw_font = Void then
					font_imp ?= internal_font.implementation
					draw_font := font_imp.wel_font
				end
					-- Set the flag for the forthcoming call to
					-- `draw_text'.
				inspect text_alignment
				when {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center then
					draw_flags := Dt_center
				when {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left then
					draw_flags := Dt_left
				when {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right then
					draw_flags := Dt_right
				else
					check
						Unexpected_alignment: False
					end
				end
				draw_flags := draw_flags | Dt_expandtabs

				-- Compute the bounding rectangle where the text need
				-- to be displayed.

				create draw_rect.make (
					draw_item_struct_rect.left, draw_item_struct_rect.top +
						(draw_item_struct_rect.height - text_height) // 2,
					draw_item_struct_rect.right, draw_item_struct_rect.bottom)


					-- Need to first clear the area to the background color of `parent_imp'
				theme_drawer.draw_widget_background (Current, draw_dc, draw_item_struct_rect, bk_brush)

					-- Draw the text
				draw_dc.select_font (draw_font)
				color_imp ?= foreground_color.implementation
				draw_dc.set_text_color (color_imp)
				if not is_sensitive then
					-- Label is disabled
					draw_dc.draw_disabled_text (internal_text, draw_rect,
						draw_flags)
				else
					-- Label is NOT disabled
					draw_dc.draw_text (internal_text, draw_rect,
						draw_flags)
				end
				draw_dc.unselect_font
			else
				theme_drawer.draw_widget_background (Current, draw_dc, draw_item_struct_rect, bk_brush)
			end
			bk_brush.delete
		end

feature {NONE} -- Implementation

	text_height: INTEGER
			-- Height in pixels of the current text.

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

