indexing
	description: "EiffelVision push button.%
		% Mswindows implementation."
	status: "See notice at end of class"
	date: "$$"
	revision: "$$"

class
	EV_BUTTON_IMP

inherit
	EV_BUTTON_I

	EV_PRIMITIVE_IMP
		undefine
			set_default_minimum_size
		redefine
			widget_make
		end
   
	EV_BAR_ITEM_IMP
    
	EV_TEXTABLE_IMP
		redefine
			set_default_minimum_size
		end

	EV_PIXMAPABLE_IMP
		undefine
			pixmap_size_ok
		redefine
			set_pixmap
		end

	EV_FONTABLE_IMP

	WEL_BS_CONSTANTS
		export
			{NONE} all
		end

	WEL_BUTTON
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			font as wel_font,
			set_font as wel_set_font,
			set_text as wel_set_text,
			destroy as wel_destroy
		undefine
			-- We undefine the features redefined by EV_WIDGET_IMP,
			-- EV_PRIMITIVE_IMP and EV_TEXT_CONTAINER_IMP.
			remove_command,
			set_width,
			set_height,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_set_focus,
			on_kill_focus,
			on_key_down,
			on_key_up,
			on_set_cursor
		redefine
			on_bn_clicked,
			default_process_message
		end

creation
	make,
	make_with_text

feature {NONE} -- Initialization

	make is
			-- Create the label with an empty label.
		do
			make_with_text ("")
		end

	make_with_text (txt: STRING) is
			-- Create the label with `txt' as label.
		do
			wel_make (default_parent.item, txt,	0, 0, 0, 0, 0)
			extra_width := 10
		end

	widget_make (an_interface: EV_WIDGET) is
			-- Creation of the widget.
		do
			set_font (font)
			{EV_PRIMITIVE_IMP} Precursor (an_interface)
		end

feature -- Access

	extra_width: INTEGER
		-- Extra width on the size

feature -- Status setting

	set_default_minimum_size is
		-- Resize to a default size.
		local
			fw: EV_FONT_IMP
			w,h: INTEGER
		do
			-- A minimum width to be sure.
			w := extra_width
			h := 0

			-- The pixmap must go in,
			if pixmap_imp /= Void then
				w := w + pixmap_imp.width
				h := h + pixmap_imp.height + 11
			end

			-- the text too.
			if text /= "" then
				fw ?= font.implementation
				check
					font_not_void: fw /= Void
				end
				w := w + fw.string_width (text)
				h := h.max (7 * fw.height // 4 )
			end

			-- Finaly, we set the minimum values.
			set_minimum_width (w)
			set_minimum_height (h)
		end

feature -- Element change

	set_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of the widget.
		local
			local_style: INTEGER
		do
			{EV_PIXMAPABLE_IMP} Precursor (pix)
--			local_style := clear_flag (style, Bs_pushbutton)
--			local_style := set_flag (style, Bs_ownerdraw)
--			set_style (local_style)
			set_default_minimum_size
		end

feature -- Event - command association

	add_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add 'cmd' to the list of commands to be executed
			-- the button is pressed.
		do
			add_command (Cmd_click, cmd, arg)
		end

feature -- Event -- removing command association

	remove_click_commands is	
			-- Empty the list of commands to be executed when
			-- the button is pressed.
		do
			remove_command (Cmd_click)
		end

feature {NONE} -- WEL Implementation

	on_bn_clicked is
			-- When the button is pressed
		do
			execute_command (Cmd_click, Void)
		end

	default_process_message (msg, wparam, lparam: INTEGER) is
		   -- Process `msg' which has not been processed by
		   -- `process_message'.
		do
			if msg = Wm_erasebkgnd then
				disable_default_processing
			end
 		end

	background_brush: WEL_BRUSH is
		do
			!! Result.make_solid (background_color_imp)
		end

	current_state: INTEGER
			-- An Integer to know if the button is up or down.
			-- We us an integer for the toggle buttons.

	on_draw (struct: WEL_DRAW_ITEM_STRUCT) is
			-- Called when the system ask to redraw
			-- the container
		local
			action: INTEGER
			dc: WEL_DC
		do
			action := struct.item_action
			dc := struct.dc
			if action = Oda_focus then
				draw_focus (dc)
			elseif action = Oda_select then
				select_action
				dc.fill_rect (client_rect, background_brush)
				draw_edge (dc)
				draw_focus (dc)
				draw_body (dc)
			elseif action = Oda_drawentire then
				dc.fill_rect (client_rect, background_brush)
				if struct.item_state = Ods_focus then
					draw_focus (dc)
				end
				draw_edge (dc)
				draw_body (dc)
			end
		end

	wel_window: WEL_WINDOW is
			-- Window used to create the pixmap : Current
		do
			Result ?= Current
		end

feature {NONE} -- Basic operation

	select_action is
			-- Action to be down when `Oda_select'.
			-- We obtain alway 0 or 1, the two states.
		do
			current_state := (current_state + 1) \\ 2
		end

	is_down: BOOLEAN is
			-- Say if the button is down or not.
		do
			if current_state = 0 then
				Result := False
			else
				Result := True
			end
		end

	draw_edge (dc: WEL_DC) is
			-- Draw the edge of the button.
		do
			if is_down then
				routine_draw_edge (dc, client_rect, Edge_sunken, Bf_rect)
			else
				routine_draw_edge (dc, client_rect, Edge_raised, Bf_rect + Bf_soft)
			end
		end

	draw_focus (dc: WEL_DC) is
			-- Draw the focus line around the button.
		local
			rect: WEL_RECT
		do
			!! rect.make (3, 3, width - 3, height - 3)
			draw_focus_rect (dc, rect)
		end

	draw_body (dc: WEL_DC) is
			-- Draw the body of the button : bitmap + text
		local
			inrect: WEL_RECT
			tx, ty: INTEGER
		do
			-- First, we set the rectangle we will draw in, it depends if the
			-- button is up or down
			if is_down then
				!! inrect.make (5, 5, width - 5, height - 4)
			else
				!! inrect.make (5, 4, width - 5, height - 5)
			end

			-- We select the brushes and color
			dc.set_text_color (foreground_color_imp)
			dc.set_background_color (background_color_imp)

			-- If sensitive, we draw everything normaly.
			if not insensitive then
				if pixmap_imp /= Void and text /= "" then
					dc.bit_blt (inrect.left, inrect.top, inrect.width, inrect.height, pixmap_imp.dc, 0, 0, Srccopy)
					inrect.set_left (pixmap_imp.width + 5)
					dc.draw_centered_text (text, inrect)
				elseif pixmap_imp /= Void then
					dc.bit_blt (inrect.left, inrect.top, inrect.width, inrect.height, pixmap_imp.dc, 0, 0, Srccopy)
				elseif text /= "" then
					dc.draw_centered_text (text, inrect)
				end

			-- If insensitive, the text is gray.
			-- We don't set the pixmap gray, because the quality is bad.
			else
				if pixmap_imp /= Void and text /= "" then
					dc.bit_blt (inrect.left, inrect.top, inrect.width, inrect.height, pixmap_imp.dc, 0, 0, Srccopy)
					inrect.set_left (pixmap_imp.width + 5)
					tx := inrect.left + (inrect.width - dc.string_width (text)) // 2
					ty := inrect.top + ((inrect.height - dc.string_height (text)) // 2) 
					draw_insensitive_text (dc, text, tx, ty)
				elseif pixmap_imp /= Void then
					dc.bit_blt (inrect.left, inrect.top, inrect.width, inrect.height, pixmap_imp.dc, 0, 0, Srccopy)
				elseif text /= "" then
					tx := inrect.left + (inrect.width - dc.string_width (text)) // 2
					ty := inrect.top + ((inrect.height - dc.string_height (text)) // 2)
					draw_insensitive_text (dc, text, tx, ty)
				end
			end
		end	

feature {NONE} -- WEL Implementation

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlgtabitem (hdlg, hctl, previous)
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlggroupitem (hdlg, hctl, previous)
		end

	default_style: INTEGER is
			-- Not visible or child at creation
		do
			Result := Ws_child + Ws_visible + Ws_group
						+ Ws_tabstop --+ Bs_pushbutton
							 + Bs_ownerdraw
		end

end -- class EV_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
