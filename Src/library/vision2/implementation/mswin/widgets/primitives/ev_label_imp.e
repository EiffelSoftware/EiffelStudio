indexing
	description: "EiffelVision label widget. Displays a single line of text.%
		%Mswindows implementation";
	status: "See notice at end of class";
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
			default_process_message
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
			if a_text.is_empty then
				set_default_minimum_size
			else
				accomodate_text (a_text)
			end
			Precursor {EV_TEXT_ALIGNABLE_IMP} (a_text)
			invalidate
		end

	set_font (ft: EV_FONT) is
			-- Make `ft' new font of `Current'.
		do
			Precursor {EV_FONTABLE_IMP} (ft)
			if not text.is_empty then
				accomodate_text (text)
			end
			invalidate
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
 			Result := Ws_visible + Ws_child + Ss_notify + Ss_ownerdraw
 				+ Ws_clipchildren + Ws_clipsiblings
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
		do
				-- Assign local variable for faster access
			draw_dc := draw_item_struct.dc
			draw_item_struct_rect := draw_item_struct.rect_item
			
			if internal_text /= Void then
					-- Retrieve the font used to draw the text
				draw_font := private_wel_font
				if draw_font = Void then
					font_imp ?= font.implementation
					draw_font := font_imp.wel_font
				end
					-- Set the flag for the forthcoming call to
					-- `draw_text'.
				inspect text_alignment
				when feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center then
					draw_flags := Dt_center
				when feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left then
					draw_flags := Dt_left
				when feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right then
					draw_flags := Dt_right
				else
					check
						Unexpected_alignment: False
					end
				end
				draw_flags := draw_flags | Dt_expandtabs
	
					-- Compute the bounding rectangle where the text need
					-- to be displayed.
				check
					text_height_ok: (not internal_text.is_empty) implies 
						text_height = draw_font.string_height (internal_text)
				end
				create draw_rect.make (
					draw_item_struct_rect.left, draw_item_struct_rect.top + 
						(draw_item_struct_rect.height - text_height) // 2,
					draw_item_struct_rect.right, draw_item_struct_rect.bottom)

					-- Erase the background
				erase_background (draw_dc, draw_item_struct_rect)
			
					-- Draw the text
				draw_dc.select_font (draw_font)
				if draw_item_struct.item_state = Ods_disabled then
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
					-- No text, just erase the background
				erase_background (draw_dc, draw_item_struct_rect)
			end
		end
		
feature {NONE} -- Implementation

	erase_background (a_dc: WEL_DC; a_rect: WEL_RECT) is
			-- Erase the background for the rectangle `a_rect' using the
			-- Device context `a_dc'.
		local
			a_background_brush: WEL_BRUSH
		do
			create a_background_brush.make_solid (wel_background_color)
			a_dc.fill_rect (a_rect, a_background_brush)
			a_background_brush.delete
		end
	
	text_height: INTEGER
			-- Height in pixels of the current text.

feature {NONE} -- Feature that should be directly implemented by externals.

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Never_called: False
			end
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Never_called: False
			end
		end

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

feature {EV_ANY_I}

	interface: EV_LABEL

end -- class EV_LABEL_IMP

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

